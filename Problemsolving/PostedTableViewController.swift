//
//  PostedTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 24/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase
import Cosmos

class PostedTableViewController: UITableViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    
    var toilet = Toilet()
    var search = Search()
    var filter = Filter()
    //var userReviewComment = UserReviewComment()
    //var toilets: [Toilet] = []
    var commentData: [UserReviewComment] = []
    var deleteArray: [String] = []
    var allRidArray: [String] = []
    var locationManager = CLLocationManager()
    let firebaseRef = FIRDatabase.database().reference()
    var multipleDeleteMode = false
    
    let uid = FIRAuth.auth()!.currentUser!.uid
    var geoFire: GeoFire!
    var firstViewLoaded = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationAuthStatus()
        locationManager.delegate = self
        reviewRidQuery()
        //firebaseQuery()
        tableView.allowsMultipleSelectionDuringEditing = true
        print("Posted Table View Loaded")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 260
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        firebaseRef.child("ReviewList").child(uid).child(commentData[indexPath.row].key).removeValue { (error, ref) in
            if error != nil{
                print("Failed to delete a cell",error!)
                return
            }
        }
        
        firebaseRef.child("ReviewInfo").child(commentData[indexPath.row].key).removeValue { (error, ref) in
            if error != nil{
                print("Failed to delete a cell",error!)
                return
            }
        }
        
        
        self.commentData.remove(at:indexPath.row)
        //self.toilets.remove(at: toilets[indexPath.row])
        self.tableView.reloadData()
        
    }
    
    //private void reviewRidQuery()
    
    func reviewRidQuery(){
        
        print("reviewRidQuery Called")
        
        let reviewListRef = firebaseRef.child("ReviewList").child(FIRAuth.auth()!.currentUser!.uid)
        
        reviewListRef.queryOrderedByKey().observe(FIRDataEventType.value, with: { snapshot in
            print(snapshot)
            
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots
                {
                    let rid = snap.key
                    
                    self.commnetsReviewInfoQuery(ridKey: rid)
                    self.allRidArray.append(rid)
                    print("Rid Key == \(rid)")
                    
                    
                }
            }
        })
    }
    
    func commnetsReviewInfoQuery(ridKey: String){
        
       
        
        print("commnetsReviewInfoQueryCalled")
        let userReviewComment = UserReviewComment()
        
        let reviewRef = firebaseRef.child("ReviewInfo").child(ridKey)
        
        reviewRef.queryOrderedByKey().observe(FIRDataEventType.value, with: { snapshot in
            
             if self.firstViewLoaded == false {
            
            let snapshotValue = snapshot.value as? NSDictionary
            
            print("reivewRef snapshot == \(snapshot)")
            
            userReviewComment.key = ridKey
            
            
            
            userReviewComment.uid = (snapshotValue?["uid"] as? String)!
            
            userReviewComment.feedback = (snapshotValue?["feedback"] as? String)!
            userReviewComment.time = (snapshotValue?["time"] as? String)!
            userReviewComment.userWaitingTime = (snapshotValue?["waitingtime"] as? String)! + "分待ちました"
            
            userReviewComment.userRatedStar = (snapshotValue?["star"] as? String)!
            
            userReviewComment.tid = (snapshotValue?["tid"] as? String)!
            
            let tidKey = userReviewComment.tid
            
            
            let toiletRef = self.firebaseRef.child("ToiletView").child(tidKey)
            toiletRef.queryOrderedByKey().observe(FIRDataEventType.value, with: { snapshot in
                
                let snapshotValue = snapshot.value as? NSDictionary
                
                userReviewComment.name = (snapshotValue?["name"] as? String)!
                userReviewComment.urlOne = (snapshotValue?["urlOne"] as? String)!
                userReviewComment.averageStar = (snapshotValue?["averageStar"] as? String)!
                userReviewComment.reviewCount = (snapshotValue?["reviewCount"] as? Int)!
                userReviewComment.avWaitingTime = String((snapshotValue?["averageWait"] as? Int)!)
                userReviewComment.available = (snapshotValue?["available"] as? Bool)!
                
                
                userReviewComment.latitude = (snapshotValue?["latitude"] as? Double)!
                userReviewComment.longitude = (snapshotValue?["longitude"] as? Double)!
                
                
                let destinationLoc = CLLocation(latitude: userReviewComment.latitude, longitude: userReviewComment.longitude)
                
                
                userReviewComment.distance = MapViewController.distanceCalculationGetString(destination: destinationLoc, center: self.search.centerSearchLocation)
                
                self.commentData.append(userReviewComment)
                self.tableView.reloadData()
                
                
                
                
                
            
            })
            }
            
            
            //            self.commentsToiletInfoQuery(tidKey: self.userReviewComment.tid);
            //            print("Tid Key == \(self.userReviewComment.tid)")
            
            
        })
        
        }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentData.count
    }
    
    //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 260
    //
    //    }
    
    //commented for adding wrap content
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = Bundle.main.loadNibNamed("YourReviewTableViewCell", owner: self, options: nil)?.first as! YourReviewTableViewCell
        
        cell.placeNameLabel.text = commentData[indexPath.row].name
        
        cell.placeDistanceLabel.text =  commentData[indexPath.row].distance
        cell.placeStarView.rating = Double(commentData[indexPath.row].averageStar)!
        cell.placeStarView.settings.filledColor = UIColor.yellow
        cell.placeStarView.settings.emptyBorderColor = UIColor.orange
        cell.placeStarView.settings.filledBorderColor = UIColor.orange
        cell.placeStarView.text = "\(Double(commentData[indexPath.row].averageStar)!)(\(Double(commentData[indexPath.row].reviewCount))件) "
        cell.placeStarView.settings.textColor = UIColor.black
        cell.placeStarView.settings.textMargin = 10
        cell.placeStarView.settings.textFont.withSize(CGFloat(50.0))
        
        
        
        cell.placeWaitingTime.text = "平均待ち" +  commentData[indexPath.row].avWaitingTime + "分"
        if  commentData[indexPath.row].urlOne != ""{
            
            cell.placeViewImage.sd_setImage(with: URL(string:  commentData[indexPath.row].urlOne))
            
        }
        
        if  commentData[indexPath.row].available == true
        {
            cell.placeWarningPhoto.isHidden = true
            
        }
        
        cell.userCommentDateLabel.text =  commentData[indexPath.row].time
        cell.userRatedStarView.rating = Double( commentData[indexPath.row].userRatedStar)!
        cell.userRatedStarView.settings.filledColor = UIColor.yellow
        cell.userRatedStarView.settings.emptyBorderColor = UIColor.orange
        cell.userRatedStarView.settings.filledBorderColor = UIColor.orange
        cell.userRatedStarView.text = commentData[indexPath.row].userRatedStar
        cell.userRatedStarView.settings.textColor = UIColor.black
        cell.userRatedStarView.settings.textMargin = 10
        cell.userRatedStarView.settings.textFont.withSize(CGFloat(50.0))
        
        cell.userLikedCountLabel.text = "いいね" + String( commentData[indexPath.row].likedCount) + "件"
        cell.userFeedbackTextView.text =  commentData[indexPath.row].feedback
        print("cell.userFeedbackTextView.text = \(commentData[indexPath.row].feedback)")
        
        cell.userWaitingTimeLabel.text =  commentData[indexPath.row].userWaitingTime
        
        return cell
        
    }
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if multipleDeleteMode == false{
            //            performSegue(withIdentifier: "postedToDetailSegue", sender: commentData[indexPath.row])
            //            print("sender = \(toilets[indexPath.row])")
            
            print("Table view did select")
            
            let storyboard = UIStoryboard(name: "PlaceDetailViewController", bundle: nil)
            let navigationContoller = storyboard.instantiateViewController(withIdentifier: "PlaceNavigationController") as! UINavigationController
            let nextVC = navigationContoller.topViewController as! PlaceDetailViewController
            
            
            nextVC.toilet.key = commentData[indexPath.row].tid
            nextVC.filter = filter
            nextVC.search = search
            
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            
            print("Table view Segue Called")
            
            
            
            self.present(navigationContoller, animated: false, completion: nil)
            
            print("Table view Segue Ended")
            
            
            
        }
        
        
        if self.deleteArray.contains(commentData[indexPath.row].key){
            print("AlreadyIntheArray")
        }else{
            
            self.deleteArray.append(commentData[indexPath.row].key)
            
            print(deleteArray)
            
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("indexPath.row = \(indexPath.row)")
        if deleteArray.count - 1 >= indexPath.row{
            print("deleteArray.count = \(deleteArray.count)")
            print("indexPath.row = \(indexPath.row)")
            self.deleteArray.remove(at: indexPath.row)
        }
        
        print(deleteArray)
        
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        performSegue(withIdentifier: "YoutodSegue", sender: toilets[indexPath.row])
    //        print("sender = \(toilets[indexPath.row])")
    //    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "postedToDetailSegue"{
    //            let nextVC = segue.destination as! DetailViewController
    //            nextVC.toilet = sender as! Toilet
    //
    //        }}
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "youHaveAddedToAcSegue"{
            let nextVC = segue.destination as! UserPrivateAccountViewController
            nextVC.filter = filter
            nextVC.search = search
            
        }}
    
    
    
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            let alertController = UIAlertController (title: "GPS singal not found", message: "Change GPS settings?", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        
        if multipleDeleteMode == true{
            let alertController2 = UIAlertController (title: "選択されたトイレを本当に削除しますか", message: "", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "はい", style: .default) { (_) -> Void in
                self.multipleDeleteExecution()
                self.multipleDeleteMode = false
                self.tableView.setEditing(false, animated: true)
                
                
                
            }
            let noAction = UIAlertAction(title: "いいえ", style: .default) { (_) -> Void in
                self.multipleDeleteMode = false
                self.tableView.setEditing(false, animated: true)
                
            }
            
            alertController2.addAction(yesAction)
            alertController2.addAction(noAction)
            present(alertController2, animated: true, completion: nil)
        }else{
            
            let alertController = UIAlertController (title: "リストを削除しますか", message: "", preferredStyle: .alert)
            let deleteAllAction = UIAlertAction(title: "全て削除する",style: .default) { (_) -> Void in
                let alertController3 = UIAlertController (title: "本当に削除しますか", message: "", preferredStyle: .alert)
                let yesAction = UIAlertAction(title: "はい", style: .default) { (_) -> Void in
                    self.deleteAll()
                    
                }
                let noAction = UIAlertAction(title: "いいえ", style: .default, handler: nil)
                
                
                alertController3.addAction(yesAction)
                alertController3.addAction(noAction)
                self.present(alertController3, animated: true, completion: nil)
                
            }
            
            let onlydeleteAction = UIAlertAction(title: "選択削除する", style: .default) { (_) -> Void in
                self.multipleDeleteMode = true
                
                self.tableView.setEditing(true, animated: true)
            }
            
            
            let cancelAction = UIAlertAction(title: "削除しない", style: .default, handler: nil)
            alertController.addAction(deleteAllAction)
            alertController.addAction(onlydeleteAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    func multipleDeleteExecution(){
        firstViewLoaded = true
        //        for item in deleteArray{
        //            firebaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).child("youPosted").child(item).removeValue { (error, ref) in
        //                if error != nil{
        //                    print("Failed to delete a cell",error!)
        //                    return
        //                }
        //
        //                if let idx = self.commentData.index(where: {$0.key == item}) {
        //                    print("idx = \(idx)")
        //                    self.commentData.remove(at: idx)
        //                }
        //                self.tableView.reloadData()
        //            }
        //        }
        
        for item in deleteArray{
            firebaseRef.child("ReviewList").child(uid).child(item).removeValue { (error, ref) in
                if error != nil{
                    print("Failed to delete a cell",error!)
                    return
                }
                
            }
            
            firebaseRef.child("ReviewInfo").child(item).removeValue { (error, ref) in
                if error != nil{
                    print("Failed to delete a cell",error!)
                    return
                }
                
            }
            
            if let idx = self.commentData.index(where: {$0.key == item}) {
                    print("idx = \(idx)")
                    self.commentData.remove(at: idx)
                }
            
                self.tableView.reloadData()
            
        }
        
    }
    
    func deleteAll(){
        
        firstViewLoaded = true
        
        
        firebaseRef.child("ReviewList").child(uid).removeValue { (error, ref) in
            if error != nil{
                print("Failed to delete a cell",error!)
                return
            }
        }
        
        for item in allRidArray{
            
            firebaseRef.child("ReviewInfo").child(item).removeValue { (error, ref) in
                if error != nil{
                    print("Failed to delete a cell",error!)
                    return
                }
                
            }
            
        }

        self.commentData.removeAll()
        self.tableView.reloadData()
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier:"youHaveAddedToAcSegue", sender: nil)
        
    }
    
    
}

