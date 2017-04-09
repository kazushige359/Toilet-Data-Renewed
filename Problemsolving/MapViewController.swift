//
//  MapViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 1/12/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Cosmos


protocol HandleMapSearch: class {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}
//Copied from internet mapkit tutotial



class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate
    
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        changeStartCell()
        return  toilets.count
    }
    
    @available(iOS 2.0, *)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
//         cell.bounds = CGRect(x: 0, y: 0, width: mapView.bounds.width, height: cell.bounds.height )
        //cell.bounds = CGRect(0.0, 0.0, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds))
        /////
        
        cell.mainImageView.sd_setImage(with: URL(string: toilets[indexPath.row].urlOne))
        
        cell.waitminuteLabel.text = "平均待ち　\(toilets[indexPath.row].averageWait)分"
        cell.image7.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fredflag.jpeg?alt=media&token=6f464ebc-81a9-4553-aadd-1bb4b98d2b74"))
        // red flag
        
        cell.Star.settings.filledColor = UIColor.yellow
        cell.Star.settings.emptyBorderColor = UIColor.orange
        cell.Star.settings.filledBorderColor = UIColor.orange
        
        cell.Star.rating = Double(toilets[indexPath.row].averageStar)!
        
        //////////////////////////////////
        cell.Star.text = "\(Double(toilets[indexPath.row].averageStar)!)(\(toilets[indexPath.row].reviewCount)件) "
        cell.Star.settings.textColor = UIColor.black
        cell.Star.settings.textMargin = 10
        //text margin 10 to 5
        cell.Star.settings.textFont.withSize(CGFloat(50.0))
        //30 to 50
        
        //Added for the auto layout
        //////////////////////////////////
        
//        cell.starLabel.text = "\(toilets[indexPath.row].averageStar)"
//        //cell.reviewCountLabel.text = "(感想\(toilets[indexPath.row].reviewCount)件)"
//        cell.reviewCountLabel.text = "(\(toilets[indexPath.row].reviewCount))"
        
        // I got Pictures above from the Internet, so dont use them for commersial purposes
        cell.mainImageView.layer.masksToBounds = true
        cell.mainImageView.layer.cornerRadius = 8.0
        cell.mainLabel.text = toilets[indexPath.row].name
        if toilets[indexPath.row].distance > 1000{
            let td1 = round(0.01*toilets[indexPath.row].distance)/0.01/1000
            print("td1 = \(td1)")
            cell.distanceLabel.text = "\(td1)km"
            
        } else{
            cell.distanceLabel.text = "\(Int(round(0.1*toilets[indexPath.row].distance)/0.1))m"
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "mapToNewDetailSegue", sender: toilets[indexPath.row])
        
        //April 8 18 pm 
        
        //mapToPlaceDetailSegue
        //performSegue(withIdentifier: "DetailSegue", sender: toilets[indexPath.row])
        print("sender = \(toilets[indexPath.row])")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToNewDetailSegue"
        {
            //April 8 18 pm
            let nextVC = segue.destination as! PlaceDetailViewController
            //let nextVC = segue.destination as! DetailViewController
            nextVC.toilet = sender as! Toilet
           // nextVC.toilet = sender as! Toilet
            nextVC.filter = filter
            nextVC.search = search
            
            
////////////////////Commented April 8
        }
        if segue.identifier == "maptoFilterSegue"{
            let nextVC = segue.destination as! FilterTableViewController
            nextVC.filter = filter
            nextVC.search = search
        }
        if segue.identifier == "mapToacTVSegue"{
            //Changed to new name
            let nextVC = segue.destination as! AccountTableViewController
            nextVC.filter = filter
            nextVC.search = search
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    var locationManager = CLLocationManager()
    var mapHasCenteredOnce = false
    var allInitialDataLoaded = false
    var geoFire: GeoFire!
    var geoFireRef: FIRDatabaseReference!
    let queryannotations = MKPointAnnotation()
    var toilets: [Toilet] = []
    let toilet = Toilet()
    var search = Search()
    let Star = CosmosView()
    var polyline: MKPolyline?
    
    var filter = Filter()
    var removedToilet = false
    var createdArray = false
    
    //Below properties were copied from mapkit tutorial
    var resultSearchController: UISearchController!
    var selectedPin: MKPlacemark?
    let databaseRef = FIRDatabase.database().reference()
    let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)

    
    @IBOutlet weak var searchEndButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var searchEndLabel: UILabel!
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    //Cope=ied from example
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        geoFireRef = FIRDatabase.database().reference().child("ToiletLocations")
        geoFire = GeoFire(firebaseRef: geoFireRef)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
        self.tableView.bounds = CGRect(x: 0, y: 0, width: mapView.bounds.width, height: self.tableView.bounds.height )
        
        let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
        
        changeStartCell()
        
        //Below properties were copied from mapkit tutorial
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        // let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        searchBar.delegate = self
        
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        listButton.isHidden = true
        centerButton.isHidden = true
        if filter.myOrderSetted == false{
            filter.orderDistanceFilter = true
        }
        //filter.orderStarFilter = true
        
        if filter.distanceSetted == false{
            filter.distanceFilter = 3
        }
        
        print("search.searchOn = \(search.searchOn)")
        if search.searchOn == false {
            searchEndLabel.isHidden = true
            searchEndButton.isHidden = true
            
        }
        
        searchEndLabel.backgroundColor = UIColor.white
        searchEndButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        
        centerButton.layer.cornerRadius = 25
        centerButton.backgroundColor = UIColor.white
        centerButton.layer.shadowColor = UIColor.black.cgColor
        centerButton.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        
        centerButton.layer.shadowOpacity = 1
        centerButton.layer.shadowRadius = 1
        
        centerButton.layer.shouldRasterize = true
        
        listButton.layer.cornerRadius = 25
        listButton.backgroundColor = UIColor.white
        listButton.layer.shadowColor = UIColor.black.cgColor
        listButton.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        
        listButton.layer.shadowOpacity = 1
        listButton.layer.shadowRadius = 1
        listButton.layer.shouldRasterize = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.tableViewDisappear))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        mapView.addGestureRecognizer(tap)
        tableView.isHidden = false
        listButton.isHidden = true
        centerButton.isHidden = true
        
         print("filter.typeFilter = \(filter.typeFilter)")
        
        //savingToilets()
        
        self.navigationController?.navigationBar.tintColor = primaryColor
        
        
        progressBarDisplayer(msg:"トイレを検索中", true)
    }
    
    func tableViewDisappear(){
        tableView.isHidden = true
        listButton.isHidden = false
        centerButton.isHidden = false
        //showButtons()
    }
    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        print(msg)
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = primaryColor
        //messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)//witdh 50 to 200
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    
    //Copied from Example
    
 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        changeStartCell()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        resultSearchController!.searchBar.removeFromSuperview()
        
    }
    
    func changeStartCell(){
        
        
        print("self.tableView.frame = \(self.tableView.frame)")
        if toilets.count == 0 {
        }
        
        if toilets.count == 1 {
//            self.tableView.frame = CGRect(x:0 , y: tableView.frame.height - 82, width: tableView.frame.width, height: 82)
            self.tableView.frame = CGRect(x:0 , y: mapView.frame.height - 82, width: tableView.frame.width, height: 82)
        }
        if toilets.count == 2 {
           self.tableView.frame = CGRect(x:0 , y: mapView.frame.height - 164, width: tableView.frame.width, height: 164)
        }
        if toilets.count == 3 {
            self.tableView.frame = CGRect(x:0 , y: mapView.frame.height - 246, width: tableView.frame.width, height: 246)
        }
        if toilets.count == 4 {
            self.tableView.frame = CGRect(x:0 , y: mapView.frame.height - 328, width: tableView.frame.width, height: 328)
        }
        
        //This interepted the auto layout for the tableview cell
    }
    
    
    
    
    func savingToilets(){
        print("savingToilets()")
        let locationsRef = FIRDatabase.database().reference().child("ToiletLocations")
        let geoFire = GeoFire(firebaseRef: locationsRef)
        let locations = [
            ["name": "FamilyMart 筑前山家道店","latitude": -33.888212, "longitude": 151.193686],
            ["name": "FamilyMart 筑前原地蔵店","latitude": -33.886921, "longitude": 151.194030],
            ["name": "F3","latitude": -33.886208, "longitude": 151.194502],
            ["name": "F6","latitude": -33.887241, "longitude": 151.191219],
            ["name": "F5","latitude": -33.884851, "longitude": 151.190141]
        ]
        
        //under for key location["name"] as! String!
        
        
        for location in locations {
            
            geoFire!.setLocation(CLLocation(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees), forKey: location["name"] as! String!){(error) in
                if (error != nil) {
                    print("An error occured: \(error)")
                    
                } else {
                    print("Saved location successfully!")
                    print("in geoFire.setLocation")
                }
            }
            print("after geoFire.setLocation")
            
            let tdata : [String : Any] =
                ["name": "FamilyMart",
                 "openinghours": "07:30 〜　16:30",
                 "type": "ConvenienceStore",
                 "star": 3.5 ,
                 "waitingtime": 2 ,
                 "urlOne":"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2FFamilyMart.picture.jpg?alt=media&token=0de63d07-fb5e-4534-a423-796d1b5b44af",
                 "urlTwo":"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2FFamilyMart.picture.jpg?alt=media&token=0de63d07-fb5e-4534-a423-796d1b5b44af",
                 "urlThree":"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2FFamilyMart.picture.jpg?alt=media&token=0de63d07-fb5e-4534-a423-796d1b5b44af",
                 "tid": "jfiohaiohfj",
                 "washlet": false,
                 "wheelchair": false,
                 "onlyFemale": true,
                 "unisex": true,
                 "makeuproom": false,
                 "milkspace" : false,
                 "omutu": false,
                 "ostomate" : false,
                 "japanesetoilet": false,
                 "westerntoilet": true,
                 "warmSeat": false,
                 "baggageSpace": false,
                 "howtoaccess": "アクセス情報はまだ記入されていません",
                 "available": false,
                 "addedBy": "us",
                 "editedBy": "us",
                 "reviewCount": 0,
                 "averageStar": "0.0",
                 "star1": 0,
                 "star2": 0,
                 "star3": 0,
                 "star4": 0,
                 "star5": 0,
                 "star6": 0,
                 "star7": 0,
                 "star8": 0,
                 "star9": 0,
                 "star10": 0,
                 "wait1": 0,
                 "wait2": 0,
                 "wait3": 0,
                 "wait4": 0,
                 "wait5": 0,
                 "averageWait": 0
            ]
            
            let toiletsRef = FIRDatabase.database().reference().child("Toilets")
            toiletsRef.child(location["name"] as! String!).setValue(tdata)
            //self.toiletsRef.child(location["name"] as! String!).setValue(tdata)
            print("tdata = \(tdata)")
            print("toiletsRef data is saved!!")
        }
    }
    
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        if allInitialDataLoaded == true{
            
        }
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
            
        }
        
    }
    
    func changeSettings(){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            let alertController = UIAlertController (title: "位置情報を取得できませんでした", message: "GPSの設定を変更しますか", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "はい", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
            let cancelAction = UIAlertAction(title: "いいえ", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            present(alertController, animated: true, completion: nil)
        }
}
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        changeSettings()
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: false)
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)")
        if mapHasCenteredOnce == false{
            if search.searchOn == true{
                centerMapOnLocation(location: search.centerSearchLocation)
                toiletsSearch(center: search.centerSearchLocation)
                
            }else{
                let loc = userLocation.location
                toiletsSearch(center: loc!)
                centerMapOnLocation(location: loc!)
                
            }
            mapHasCenteredOnce = true
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationIdentifier = "Toilets"
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotation.isKind(of: MKUserLocation.self){
            return nil
            //Added for the blue dot for user Location 18th
        }else{
            
            if view == nil {
                //There was a error once (breakpoint 10.1) 18th
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = true
                let btn = UIButton()
                btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                btn.setImage(UIImage(named: "route"), for: .normal)
                view?.rightCalloutAccessoryView = btn
                
            } else {
                view?.annotation = annotation
            }
        }
        return view
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let anno = view.annotation{
            
            var place: MKPlacemark!
            place = MKPlacemark(coordinate: anno.coordinate)
            let destination = MKMapItem(placemark: place)
            destination.name = (view.annotation?.title)!
            let regionDistance: CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegionMakeWithDistance(anno.coordinate, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey:  NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking] as [String : Any]
            
            print("callout0")
            FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("youwent").child(destination.name!).setValue(destination.name!)
            print("Callout1")
            MKMapItem.openMaps(with: [destination], launchOptions: options)
        }
    }
    
    func starfilter() { // should probably be called sort and not filter
        toilets.sort() { $0.star > $1.star } // sort the fruit by name
        self.tableView.reloadData(); // notify the table view the data has changed
    }
    
    func waitingtimeFilter(){
        toilets.sort()  { $0.star > $1.star }
        self.tableView.reloadData()
    }
    
    //    func distanceFilter(){
    //        toilets.sort() { $0.distance > $1.distance }
    //         self.tableView.reloadData()
    //    }
   
    func toiletsSearch(center: CLLocation){
        print("center = \(center)")
        
        let circleQuery = geoFire.query(at: center, withRadius: self.filter.distanceFilter)
        _ = circleQuery?.observe(.keyEntered, with: { (key: String?, location: CLLocation?) in
            //query. need to be changed
            print("HEYKey '\(key)' entered the search area and is at location '\(location)'")
            
            
            let toiletsRef = FIRDatabase.database().reference().child("Toilets")
            
            //Question quertOrderedByKey??
            //toiletsRef.child(key!).queryOrderedByKey().observe(........ 12pm 14th Feb
            
            toiletsRef.child(key!).observe(FIRDataEventType.value, with: { snapshot in
                let toilet = Toilet()
        /////        //////Copied from new one April 6   .....
                
                
                toilet.key = key!
                let snapshotValue = snapshot.value as? NSDictionary
                
                let urlOne = snapshotValue?["urlOne"] as? String
                toilet.urlOne = urlOne!
                
                let type = snapshotValue?["type"] as? String
                toilet.type = type!
                // print("type = \(type)")
                
                let averageStar = snapshotValue?["averageStar"] as? String
                toilet.star = Double(averageStar!)!
                
                
                
                
                
                toilet.name = (snapshotValue?["name"] as? String)!
                toilet.type = (snapshotValue?["type"] as? String)!
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
                toilet.handrail = (snapshotValue?["handrail"] as? Bool)!
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
                print(" reviewCount= \(reviewCount)")
                
                
                let averageWait = snapshotValue?["averageWait"] as? Int
                toilet.averageWait = averageWait!
                
                
                let distance = location?.distance(from: center)
                
                
                toilet.distance = Double(distance!)

                
                
                
                
                
                
                
                
                ///////Copied from new one April 6   .....
          
                
                if self.filter.starFilterSetted == true && toilet.star < self.filter.starFilter{
                    self.removedToilet = true
                    
                }
                //toilet.star to toilet.averageStar 18 Feb 14th....
                
                
                
                
                if self.filter.availableFilter == true && toilet.available == false {
                    self.removedToilet = true
                }
                
                if self.filter.japaneseFilter == true && toilet.japanesetoilet == false {
                    self.removedToilet = true
                }
                
                if self.filter.westernFilter == true && toilet.westerntoilet == false {
                    self.removedToilet = true
                }
                
                if self.filter.onlyFemaleFilter == true && toilet.onlyFemale == false {
                    self.removedToilet = true
                }
                
                if self.filter.unisexFilter == true && toilet.unisex == false {
                    self.removedToilet = true
                }
                
                
                
                
                
                if self.filter.washletFilter == true && toilet.washlet == false {
                    self.removedToilet = true
                }
                
                if self.filter.warmSearFilter == true && toilet.warmSeat == false {
                    self.removedToilet = true
                }
                
                if self.filter.autoOpen == true && toilet.autoOpen == false {
                    self.removedToilet = true
                }
                
                if self.filter.noVirusFilter == true && toilet.noVirus == false {
                    self.removedToilet = true
                }
                
                if self.filter.paperForBenkiFilter == true && toilet.paperForBenki == false {
                    self.removedToilet = true
                }
                
                if self.filter.cleanerForBenkiFilter == true && toilet.cleanerForBenki == false {
                    self.removedToilet = true
                }
                
                if self.filter.autoToiletWashFilter == true && toilet.autoToiletWash == false {
                    self.removedToilet = true
                }
                
                
                
                
                
                
                if self.filter.sensorHandWashFilter == true && toilet.sensorHandWash == false {
                    self.removedToilet = true
                }
                
                if self.filter.handSoapFilter == true && toilet.handSoap == false {
                    self.removedToilet = true
                }
                if self.filter.autoHandSoapFilter == true && toilet.autoHandSoap == false {
                    self.removedToilet = true
                }
                
                if self.filter.paperTowelFilter == true && toilet.paperTowel == false {
                    self.removedToilet = true
                }
                
                if self.filter.handDrierFilter == true && toilet.handDrier == false {
                    self.removedToilet = true
                }
                
                
                
                
                
                if self.filter.otohime == true && toilet.otohime == false {
                    self.removedToilet = true
                }
                
                if self.filter.napkinSelling == true && toilet.napkinSelling == false {
                    self.removedToilet = true
                }
                
                if self.filter.makeroomFilter == true && toilet.makeuproom == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.clothes == true && toilet.clothes == false {
                    self.removedToilet = true
                }
                
                if self.filter.baggageSpaceFilter == true && toilet.baggageSpace == false {
                    self.removedToilet = true
                }
                
                
                
                
                
                
                if self.filter.wheelchairFilter == true && toilet.wheelchair == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.wheelchairAccessFilter == true && toilet.wheelchairAccess == false {
                    self.removedToilet = true
                }
                
                if self.filter.handrailFilter == true && toilet.handrail == false {
                    self.removedToilet = true
                }
                
                if self.filter.callHelpFilter == true && toilet.callHelp == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.ostomateFilter == true && toilet.ostomate == false {
                    self.removedToilet = true
                }
                
                if self.filter.writtenEnglish == true && toilet.english == false {
                    self.removedToilet = true
                }
                
                if self.filter.braille == true && toilet.braille == false {
                    self.removedToilet = true
                }
                
                if self.filter.voiceGuideFilter == true && toilet.voiceGuide == false {
                    self.removedToilet = true
                }
                
                
                
                
                
                
                if self.filter.fancy == true && toilet.fancy == false {
                    self.removedToilet = true
                }
                
                if self.filter.smell == true && toilet.smell == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.confortableWise == true && toilet.conforatableWide == false {
                    self.removedToilet = true
                }
                if self.filter.noNeedAsk == true && toilet.noNeedAsk == false {
                    self.removedToilet = true
                }
                
                if self.filter.parking == true && toilet.parking == false {
                    self.removedToilet = true
                }
                
                if self.filter.airConditionFilter == true && toilet.airCondition == false {
                    self.removedToilet = true
                }
                if self.filter.wifiFilter == true && toilet.wifi == false {
                    self.removedToilet = true
                }
                
                
                
                
                
                
                if self.filter.milkspaceFilter == true && toilet.milkspace == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyRoomOnlyFemaleFilter == true && toilet.babyroomOnlyFemale == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.babyRoomMaleCanEnterFilter == true && toilet.babyroomManCanEnter == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyRoomPersonalSpaceFilter == true && toilet.babyPersonalSpace == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyRoomPersonalWithLockFilter == true && toilet.babyPersonalSpace == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.babyRoomWideSpaceFilter == true && toilet.babyRoomWideSpace == false {
                    self.removedToilet = true
                }
                
                
                
                
                if self.filter.babyCarRentalFilter == true && toilet.babyCarRental == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyCarAccessFilter == true && toilet.babyCarAccess == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.omutuFilter == true && toilet.omutu == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyHipWashingStuffFilter == true && toilet.hipWashingStuff == false {
                    self.removedToilet = true
                }
                
                if self.filter.omutuTrashCanFilter == true && toilet.babyTrashCan == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.omutuSelling == true && toilet.omutuSelling == false {
                    self.removedToilet = true
                }
                
                
                
                
                if self.filter.babySinkFilter == true && toilet.babyRoomSink == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyWashstandFilter == true && toilet.babyWashStand == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.babyHotWaterFilter == true && toilet.babyHotWater == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyMicrowaveFilter == true && toilet.babyMicroWave == false {
                    self.removedToilet = true
                }
                
                if self.filter.babySellingWaterFilter == true && toilet.babyWaterSelling == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyFoodSellingFilter == true && toilet.babyFoddSelling == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyEatingSpaceFilter == true && toilet.babyEatingSpace == false {
                    self.removedToilet = true
                }
                
                
                
                
                
                
                if self.filter.babyChairFilter == true && toilet.babyChair == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.babySoffaFilter == true && toilet.babySoffa == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyToiletFilter == true && toilet.babyKidsToilet == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyKidsSpaceFilter == true && toilet.babyKidsSpace == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.babyHeightMeasureFilter == true && toilet.babyHeightMeasure == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyWeightMeasureFilter == true && toilet.babyWeightMeasure == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyToyFilter == true && toilet.babyToy == false {
                    self.removedToilet = true
                }
                
                
                if self.filter.babyRoomFancyFilter == true && toilet.babyFancy == false {
                    self.removedToilet = true
                }
                
                if self.filter.babyRoomSmellGoodFilter == true && toilet.babySmellGood == false {
                    self.removedToilet = true
                }
                
                if self.filter.typeFilterOn == true {
                    if self.filter.typeFilter != toilet.type{
                    self.removedToilet = true
                    }
                    print("toilet.type = \(toilet.type)")
                }
                
                if self.removedToilet == false {
                    self.toilets.append(toilet)
                    let queryannotations = MKPointAnnotation()
                    
                    //if toilet.available = true{
                    queryannotations.title = toilet.name
                    queryannotations.coordinate = (location?.coordinate)!
                    
                    self.mapView.addAnnotation(queryannotations)
                    
                    self.createdArray = true

                    self.tableView.reloadData()
                    if self.filter.orderDistanceFilter == true {
                        self.toilets.sort() { $0.distance < $1.distance }
                    }
                    if self.filter.orderStarFilter == true{
                        self.toilets.sort() { $0.star > $1.star }
                    }
                    if self.filter.orderReviewFilter == true{
                        self.toilets.sort() { $0.reviewCount > $1.reviewCount }
                    }
                    
                    
                }
                self.removedToilet = false
            })
        })
        circleQuery?.observeReady({
            print("All initial data has been loaded and events have been fired!")
            self.allInitialDataLoaded = true
            self.messageFrame.removeFromSuperview()
            self.tableView.reloadData()
            self.changeStartCell()
        })
    }
       @IBAction func listButtonTapped(_ sender: Any) {
        listButton.isHidden = true
        centerButton.isHidden = true
        changeStartCell()
        if createdArray == false{
            
            let alertController = UIAlertController (title: "トイレが見つかりませんでした", message: "検索条件を変更してください", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "了解", style: .default, handler: nil)
            //let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            //alertController.addAction(cancelAction)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
       
        }
        tableView.isHidden = false
    }
    
    @IBAction func centerButtonTapped(_ sender: Any) {
        
        if search.searchOn == true {
            centerMapOnLocation(location: search.centerSearchLocation)
        }else {
            
            if let coord = locationManager.location?.coordinate {
                let region = MKCoordinateRegionMakeWithDistance(coord, 500, 500)
                //200 to 500 11am
                mapView.setRegion(region, animated: true)
            }
        }
    }
    
    @IBAction func searchEndTapped(_ sender: Any) {
        print("searchEndTapped")
        search.searchOn = false
        let center = locationManager.location
        print("locationManager.location = \(locationManager.location)")
        centerMapOnLocation(location: center!)
        toiletsSearch(center: center!)
        searchEndLabel.isHidden = true
        searchEndButton.isHidden = true
        mapView.showsUserLocation = true
        print("search.searchOn = \(search.searchOn)")
        print(search.searchOn)
    }
 
    @IBAction func accountButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "userAccountInfoSegue", sender: nil)
        
        //self.performSegue(withIdentifier: "mapToacTVSegue", sender: nil)
        //April 7th 10pm
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "maptoFilterSegue", sender: nil)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        resultSearchController.hidesNavigationBarDuringPresentation = true
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        self.present(resultSearchController, animated:true, completion:nil)
    }
}

extension MapViewController: HandleMapSearch {
    
    func dropPinZoomIn(_ placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        let centerA = placemark.coordinate
        
        let getLat: CLLocationDegrees = centerA.latitude
        let getLon: CLLocationDegrees = centerA.longitude
        
        
        let centerB: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)
        toilets.removeAll()
        createdArray = false
        print(" toilets.removeAll() = \(toilets)")
        mapView.removeAnnotations(mapView.annotations)
        toiletsSearch(center: centerB)
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
        self.tableView.reloadData()
        print("dropPinZoomIn center= \(centerB)")
        search.searchOn = true
        search.centerSearchLocation = centerB
        searchEndButton.isHidden = false
        searchEndLabel.isHidden = false
        print("search.searchOn = \(search.searchOn)")
        print(search.searchOn)
    }
}
//Copied from Mapkit tutorial




