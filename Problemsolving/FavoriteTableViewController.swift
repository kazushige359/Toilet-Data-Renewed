
//
//  FavoriteTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 29/12/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase

class FavoriteTableViewController: UITableViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    var toilet = Toilet()
    var search = Search()
    var filter = Filter()
    var toilets: [Toilet] = []
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
        firebaseRef.child("Users").child(FIRAuth.auth()!.currentUser!.uid).child("favourite").child(toilets[indexPath.row].key).removeValue { (error, ref) in
            if error != nil{
                print("Failed to delete a cell",error!)
                return
            }
        }
        
        self.toilets.remove(at:indexPath.row)
        //self.toilets.remove(at: toilets[indexPath.row])
        self.tableView.reloadData()
        
    }
    
    
    ///aaaa
    func firebaseQuery(){
        let firebaseRef = FIRDatabase.database().reference()
        firebaseRef.child("FavoriteList").child(FIRAuth.auth()!.currentUser!.uid).observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print("First Snap!!")
            print(snapshot)
            print(snapshot.value!)
            
            let favkey = snapshot.key
            
            
            firebaseRef.child("Toilets").child(favkey).queryOrderedByKey().observe(FIRDataEventType.value, with: { snapshot in
                print(snapshot)
                print(snapshot.key)
                
                let toilet = Toilet()
                toilet.key = favkey
                
                let snapshotValue = snapshot.value as? NSDictionary
                
                let urlOne = snapshotValue?["urlOne"] as? String
                toilet.urlOne = urlOne!
                
//                let type = snapshotValue?["type"] as? Int
//                toilet.type = type!
                // print("type = \(type)")
                
                let averageStar = snapshotValue?["averageStar"] as? String
                toilet.star = Double(averageStar!)!
                
                
                
                
                
                toilet.name = (snapshotValue?["name"] as? String)!
                toilet.type = (snapshotValue?["type"] as? Int)!
                toilet.urlOne = (snapshotValue?["urlOne"] as? String)!
                toilet.averageStar = (snapshotValue?["averageStar"] as? String)!
                
                
                
                
                toilet.openHours = (snapshotValue?["openHours"] as? Int)!
                toilet.closeHours = (snapshotValue?["closeHours"] as? Int)!
                toilet.reviewCount = (snapshotValue?["reviewCount"] as? Int)!
                toilet.averageWait = (snapshotValue?["averageWait"] as? Int)!
                
                
                
                
                toilet.available = (snapshotValue?["available"] as? Bool)!
                toilet.japanesetoilet = (snapshotValue?["japanesetoilet"] as? Bool)!
                toilet.westerntoilet = (snapshotValue?["westerntoilet"] as? Bool)!
                toilet.onlyFemale = (snapshotValue?["onlyFemale"] as? Bool)!
                toilet.unisex = (snapshotValue?["unisex"] as? Bool)!
                
                
                
                
                
                toilet.washlet = (snapshotValue?["washlet"] as? Bool)!
                toilet.warmSeat = (snapshotValue?["warmSeat"] as? Bool)!
                toilet.autoOpen = (snapshotValue?["autoOpen"] as? Bool)!
                toilet.noVirus = (snapshotValue?["noVirus"] as? Bool)!
                toilet.paperForBenki = (snapshotValue?["paperForBenki"] as? Bool)!
                toilet.cleanerForBenki = (snapshotValue?["cleanerForBenki"] as? Bool)!
                toilet.autoToiletWash = (snapshotValue?["nonTouchWash"] as? Bool)!
                
                
                
                toilet.sensorHandWash = (snapshotValue?["sensorHandWash"] as? Bool)!
                toilet.handSoap = (snapshotValue?["handSoap"] as? Bool)!
                toilet.autoHandSoap = (snapshotValue?["nonTouchHandSoap"] as? Bool)!
                toilet.paperTowel = (snapshotValue?["paperTowel"] as? Bool)!
                toilet.handDrier = (snapshotValue?["handDrier"] as? Bool)!
                
                
                
                
                toilet.otohime = (snapshotValue?["otohime"] as? Bool)!
                toilet.napkinSelling = (snapshotValue?["napkinSelling"] as? Bool)!
                toilet.makeuproom = (snapshotValue?["makeuproom"] as? Bool)!
                toilet.clothes = (snapshotValue?["clothes"] as? Bool)!
                toilet.baggageSpace = (snapshotValue?["baggageSpace"] as? Bool)!
                
                
                toilet.wheelchair = (snapshotValue?["wheelchair"] as? Bool)!
                toilet.wheelchairAccess = (snapshotValue?["wheelchairAccess"] as? Bool)!
                toilet.autoDoor = (snapshotValue?["autoDoor"] as? Bool)!
                toilet.callHelp = (snapshotValue?["callHelp"] as? Bool)!
                toilet.ostomate = (snapshotValue?["ostomate"] as? Bool)!
                toilet.english = (snapshotValue?["english"] as? Bool)!
                toilet.braille = (snapshotValue?["braille"] as? Bool)!
                toilet.voiceGuide = (snapshotValue?["voiceGuide"] as? Bool)!
                
                
                
                
                
                toilet.fancy = (snapshotValue?["fancy"] as? Bool)!
                toilet.smell = (snapshotValue?["smell"] as? Bool)!
                toilet.conforatableWide = (snapshotValue?["confortable"] as? Bool)!
                toilet.noNeedAsk = (snapshotValue?["noNeedAsk"] as? Bool)!
                toilet.parking = (snapshotValue?["parking"] as? Bool)!
                toilet.airCondition = (snapshotValue?["airCondition"] as? Bool)!
                toilet.wifi = (snapshotValue?["wifi"] as? Bool)!
                
                toilet.milkspace = (snapshotValue?["milkspace"] as? Bool)!
                toilet.babyroomOnlyFemale = (snapshotValue?["babyRoomOnlyFemale"] as? Bool)!
                toilet.babyroomManCanEnter = (snapshotValue?["babyRoomMaleEnter"] as? Bool)!
                toilet.babyPersonalSpace = (snapshotValue?["babyRoomPersonalSpace"] as? Bool)!
                toilet.babyPersonalSpaceWithLock = (snapshotValue?["babyRoomPersonalSpaceWithLock"] as? Bool)!
                toilet.babyRoomWideSpace = (snapshotValue?["babyRoomWideSpace"] as? Bool)!
                
                toilet.babyCarRental = (snapshotValue?["babyCarRental"] as? Bool)!
                toilet.babyCarAccess = (snapshotValue?["babyCarAccess"] as? Bool)!
                toilet.omutu = (snapshotValue?["omutu"] as? Bool)!
                toilet.hipWashingStuff = (snapshotValue?["hipCleaningStuff"] as? Bool)!
                toilet.babyTrashCan = (snapshotValue?["omutuTrashCan"] as? Bool)!
                toilet.omutuSelling = (snapshotValue?["omutuSelling"] as? Bool)!
                
                
                
                
                
                
                toilet.babyRoomSink = (snapshotValue?["babySink"] as? Bool)!
                toilet.babyWashStand = (snapshotValue?["babyWashstand"] as? Bool)!
                toilet.babyHotWater = (snapshotValue?["babyHotwater"] as? Bool)!
                toilet.babyMicroWave = (snapshotValue?["babyMicrowave"] as? Bool)!
                toilet.babyWaterSelling = (snapshotValue?["babyWaterSelling"] as? Bool)!
                toilet.babyFoddSelling = (snapshotValue?["babyFoodSelling"] as? Bool)!
                toilet.babyEatingSpace = (snapshotValue?["babyEatingSpace"] as? Bool)!
                
                
                toilet.babyChair = (snapshotValue?["babyChair"] as? Bool)!
                toilet.babySoffa = (snapshotValue?["babySoffa"] as? Bool)!
                toilet.babyKidsToilet = (snapshotValue?["kidsToilet"] as? Bool)!
                toilet.babyKidsSpace = (snapshotValue?["kidsSpace"] as? Bool)!
                toilet.babyHeightMeasure = (snapshotValue?["babyHeight"] as? Bool)!
                toilet.babyWeightMeasure = (snapshotValue?["babyWeight"] as? Bool)!
                toilet.babyToy = (snapshotValue?["babyToy"] as? Bool)!
                toilet.babyFancy = (snapshotValue?["babyFancy"] as? Bool)!
                toilet.babySmellGood = (snapshotValue?["babySmellGood"] as? Bool)!
                
                
                
                
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
    
   
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("indexPath.row = \(indexPath.row)")
        if deleteArray.count - 1 >= indexPath.row{
            print("deleteArray.count = \(deleteArray.count)")
            print("indexPath.row = \(indexPath.row)")
            self.deleteArray.remove(at: indexPath.row)
        }
        
        
        print(deleteArray)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fvToAcSegue"{
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
        for item in deleteArray{
            
              firebaseRef.child("FavoriteList").child(FIRAuth.auth()!.currentUser!.uid).child(item).removeValue { (error, ref) in
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
        
    
    firebaseRef.child("FavoriteList").child(FIRAuth.auth()!.currentUser!.uid).removeValue { (error, ref) in
                if error != nil{
                    print("Failed to delete a cell",error!)
                    return
                }
            }
        
        self.toilets.removeAll()
        self.tableView.reloadData()
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "fvToAcSegue", sender: nil)
        //print("sender = \(toilets[indexPath.row])")
        
    }
    
   
    
}
