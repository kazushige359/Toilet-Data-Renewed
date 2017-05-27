//
//  YouWentTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 30/12/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase

class YouWentTableViewController: UITableViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    
    var toilet = Toilet()
    var toilets: [Toilet] = []
    var search = Search()
    var filter = Filter()
    var deleteArray: [String] = []
    var locationManager = CLLocationManager()
    let firebaseRef = FIRDatabase.database().reference()
    var multipleDeleteMode = false
    
    var geoFire: GeoFire!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationAuthStatus()
        locationManager.delegate = self
        firebaseQuery()
        tableView.allowsMultipleSelectionDuringEditing = true
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(toilets[indexPath.row])
        print(toilets[indexPath.row].key)
        firebaseRef.child("Users").child(FIRAuth.auth()!.currentUser!.uid).child("youwent").child(toilets[indexPath.row].key).removeValue { (error, ref) in
            if error != nil{
                print("Failed to delete a cell",error!)
                return
            }
        }
        
        self.toilets.remove(at:indexPath.row)
        //self.toilets.remove(at: toilets[indexPath.row])
        self.tableView.reloadData()
        
    }
    
    
    func firebaseQuery(){
        let firebaseRef = FIRDatabase.database().reference().child("UserWentList").child(FIRAuth.auth()!.currentUser!.uid)
        firebaseRef.observeSingleEvent(of: FIRDataEventType.childAdded, with: {(snapshot) in
            
            
            if !snapshot.exists(){
                return
            }

            
        //firebaseRef.observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print("First Snap!!")
            print(snapshot)
            print(snapshot.value!)
            
            let favkey = snapshot.key
            
            
            
            firebaseRef.child("ToiletUserList").child(favkey).observeSingleEvent(of:FIRDataEventType.value, with: { snapshot in
                
                if !snapshot.exists(){
                    return
                }

                
            //firebaseRef.child("ToiletUserList").child(favkey).queryOrderedByKey().observe(FIRDataEventType.value, with: { snapshot in
                print(snapshot)
                print(snapshot.key)
                
                let toilet = Toilet()
                toilet.key = favkey
                
                let snapshotValue = snapshot.value as? NSDictionary
                
                let urlOne = snapshotValue?["urlOne"] as? String
                toilet.urlOne = urlOne!
                
//                let type = snapshotValue?["type"] as? Integer
//                toilet.type = type!
                // print("type = \(type)")
                
                let averageStar = snapshotValue?["averageStar"] as? String
                toilet.star = Double(averageStar!)!
                
                
                
                
                
                toilet.name = (snapshotValue?["name"] as? String)!
                toilet.type = (snapshotValue?["type"] as? Int)!
                toilet.urlOne = (snapshotValue?["urlOne"] as? String)!
                toilet.averageStar = (snapshotValue?["averageStar"] as? String)!
                
                
                
                
                //toilet.openHours = (snapshotValue?["openHours"] as? Int)!
               // toilet.closeHours = (snapshotValue?["closeHours"] as? Int)!
                toilet.reviewCount = (snapshotValue?["reviewCount"] as? Int)!
                toilet.averageWait = (snapshotValue?["averageWait"] as? Int)!
                
                
                
                
                toilet.available = (snapshotValue?["available"] as? Bool)!
                
                
                let reviewCount = snapshotValue?["reviewCount"] as? Int
                toilet.reviewCount = reviewCount!
                print(" reviewCount= \(String(describing: reviewCount))")
                
                
                let averageWait = snapshotValue?["averageWait"] as? Int
                toilet.averageWait = averageWait!
                self.toilet.latitude = (snapshotValue?["latitude"] as? Double)!
                self.toilet.longitude = (snapshotValue?["longitude"] as? Double)!
                
                
                
                self.toilet.loc = CLLocation(latitude: self.toilet.latitude, longitude: self.toilet.longitude)
                //let distance = location?.distance(from: search.centerSearchLocation)
                
                
                
                //MapViewController.distanceCalculationGetString()
//                toilet.distance = MapViewController.distanceCalculationGetString(self.toilet.loc, self.search.centerSearchLocation)
                //toilet.distance = MapViewController.distanceCalculationGetString(destination: CLLocation, center: CLLocation)
                
                
                toilet.distance = MapViewController.distanceCalculationGetString(destination: self.toilet.loc, center: self.search.centerSearchLocation)
                
                self.toilets.append(toilet)
                self.tableView.reloadData()
            })
        }
    
    )
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toilets.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
        
    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self,
//                                            options: nil)?.first as! TableViewCell
//        cell.mainImageView.sd_setImage(with: URL(string: toilets[indexPath.row].urlOne))
//        
//        cell.image7.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fredflag.jpeg?alt=media&token=6f464ebc-81a9-4553-aadd-1bb4b98d2b74")) // red flag
//        
//        // I got Pictures above from the Internet, so dont use them for commersial purposes
//        cell.mainImageView.layer.masksToBounds = true
//        cell.mainImageView.layer.cornerRadius = 8.0
//        
//        
//        cell.mainLabel.text = toilets[indexPath.row].key
//        
//        cell.waitminuteLabel.text = "平均待ち　\(toilets[indexPath.row].averageWait)分"
//        cell.Star.settings.filledColor = UIColor.yellow
//        cell.Star.settings.emptyBorderColor = UIColor.orange
//        cell.Star.settings.filledBorderColor = UIColor.orange
//        cell.Star.rating = Double(toilets[indexPath.row].averageStar)!
//        
//        cell.Star.text = "\(Double(toilets[indexPath.row].averageStar)!)(\(toilets[indexPath.row].reviewCount)件)"
//        cell.Star.settings.textColor = UIColor.black
//       
//        cell.Star.settings.textMargin = 10
//        cell.Star.settings.textFont.withSize(CGFloat(30.0))
////        cell.starLabel.text = "\(toilets[indexPath.row].averageStar)"
////        cell.reviewCountLabel.text = "(感想\(toilets[indexPath.row].reviewCount)件)"
//        
//        //let meter = toilets[indexPath.row].distance
//        
//        //cell.distanceLabel.text = "\(toilets[indexPath.row].distance)m"
////        
////        if toilets[indexPath.row].distance > 1000{
////            let toiletD = round(0.01*toilets[indexPath.row].distance)/0.01/1000
////            cell.distanceLabel.text = "\(toiletD)km"
////            print("cell.distanceLabel.text = \(toiletD)km")
////            
////        } else{
////            print("toilets[indexPath.row].distance = \(toilets[indexPath.row].distance)m")
////            let toiletD = Int(round(0.1*toilets[indexPath.row].distance)/0.1)
////            cell.distanceLabel.text = "\(toiletD)m"
////            print("cell.distanceLabel.text = \(toiletD)m")
////            
////        }
////        if toilets[indexPath.row].distance >= 1000000{
////            let toiletD = Int(round(0.01*toilets[indexPath.row].distance)/0.01/1000000)
////            cell.distanceLabel.text = "\(toiletD)Mm"
////            print("cell.distanceLabel.text = \(toiletD)Mm")
////            
////        }
//        
//        
//        cell.distanceLabel.text = toilet.distance
//        
//        
//        return cell
//        
//        
//        // Configure the cell...
//    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        if toilet.urlOne != ""{
            cell.mainImageView.sd_setImage(with: URL(string: toilets[indexPath.row].urlOne))
        }
        
        cell.waitminuteLabel.text = "平均待ち　\(toilets[indexPath.row].averageWait)分"
        
        cell.Star.settings.filledColor = UIColor.yellow
        cell.Star.settings.emptyBorderColor = UIColor.orange
        cell.Star.settings.filledBorderColor = UIColor.orange
        
        cell.Star.rating = Double(toilets[indexPath.row].averageStar)!
        
        
        cell.Star.text = "\(Double(toilets[indexPath.row].averageStar)!)(\(toilets[indexPath.row].reviewCount)件) "
        cell.Star.settings.textColor = UIColor.black
        cell.Star.settings.textMargin = 10
        cell.Star.settings.textFont.withSize(CGFloat(50.0))
        
        cell.mainImageView.layer.masksToBounds = true
        cell.mainImageView.layer.cornerRadius = 8.0
        cell.mainLabel.text = toilets[indexPath.row].name
        
        cell.distanceLabel.text = toilets[indexPath.row].distance
        
        
        return cell
        
        
        // Configure the cell...
    }
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if multipleDeleteMode == false{
            let storyboard = UIStoryboard(name: "PlaceDetailViewController", bundle: nil)
            let navigationContoller = storyboard.instantiateViewController(withIdentifier: "PlaceNavigationController") as! UINavigationController
            let nextVC = navigationContoller.topViewController as! PlaceDetailViewController
            
            
            nextVC.toilet = toilets[indexPath.row]
            nextVC.filter = filter
            nextVC.search = search
            
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            
            self.present(navigationContoller, animated: false, completion: nil)
            
           
        }
        
        if self.deleteArray.contains(toilets[indexPath.row].key){
            print("AlreadyIntheArray")
        }else{
            print("toilets[indexPath.row].key = \(toilets[indexPath.row].key)")
            self.deleteArray.append(toilets[indexPath.row].key)
            
            print(deleteArray)
            
            
        }

    }

    
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if multipleDeleteMode == false{
//            performSegue(withIdentifier: "YoutodSegue", sender: toilets[indexPath.row])
//            print("sender = \(toilets[indexPath.row])")
//        }
//        
//        
//        if self.deleteArray.contains(toilets[indexPath.row].key){
//            print("AlreadyIntheArray")
//        }else{
//            print("toilets[indexPath.row].key = \(toilets[indexPath.row].key)")
//            self.deleteArray.append(toilets[indexPath.row].key)
//            
//            print(deleteArray)
//            
//            
//        }
//    }
    
    
    
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "youWentToAcSegue"{
            let nextVC = segue.destination as! UserPrivateAccountViewController
            nextVC.search = search
            nextVC.filter = filter
            
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
        for item in deleteArray{
            firebaseRef.child("UserWentList").child(FIRAuth.auth()!.currentUser!.uid).child(item).removeValue { (error, ref) in
                if error != nil{
                    print("Failed to delete a cell",error!)
                    return
                }
                
                if let idx = self.toilets.index(where: {$0.key == item}) {
                    print("idx = \(idx)")
                    self.toilets.remove(at: idx)
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    func deleteAll(){
        
        
        firebaseRef.child("UserWentList").child(FIRAuth.auth()!.currentUser!.uid).removeValue { (error, ref) in
            if error != nil{
                print("Failed to delete a cell",error!)
                return
            }
        }
        
        self.toilets.removeAll()
        self.tableView.reloadData()
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier:"youWentToAcSegue", sender: nil)
        
    }
    
    
    
//    
//    @IBAction func backButtonTapped(_ sender: Any) {
//        
//        performSegue(withIdentifier: "FavoriteToMyPageSegue", sender: nil)
//        //print("sender = \(toilets[indexPath.row])")
//        
//    }
    
}

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "YoutodSegue", sender: toilets[indexPath.row])
//        print("sender = \(toilets[indexPath.row])")
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "YoutodSegue"{
//            let nextVC = segue.destination as! DetailViewController
//            nextVC.toilet = sender as! Toilet
//            
//        }}

 
