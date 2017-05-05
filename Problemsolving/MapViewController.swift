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
        
        if toilets[indexPath.row].urlOne != ""{
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
        
        
        
        
//        
//        if toilets[indexPath.row].distance > 1000{
//            let td1 = round(0.01*toilets[indexPath.row].distance)/0.01/1000
//            print("td1 = \(td1)")
//            cell.distanceLabel.text = "\(td1)km"
//            
//        } else{
//            cell.distanceLabel.text = "\(Int(round(0.1*toilets[indexPath.row].distance)/0.1))m"
//        }
        
        //Commented April 16
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "mapToNewDetailSegue"
        {
            //April 8 18 pm
//            let storyboard = UIStoryboard(name: "PlaceDetailViewController", bundle: nil)
//            let navigationContoller = storyboard.instantiateViewController(withIdentifier: "PlaceNavigationController") as! UINavigationController
//            let  = navigationContoller.topViewController as! PlaceDetailViewController
//            vc.toilet = toilet
//
//            //let nextVC = segue.destination as! PlaceDetailViewController
//            //let nextVC = segue.destination as! DetailViewController
//            nextVC.toilet = sender as! Toilet
//           // nextVC.toilet = sender as! Toilet
//            nextVC.filter = filter
//            nextVC.search = search
            
            
////////////////////Commented April 8
        }
        if segue.identifier == "maptoFilterSegue"{
            let nextVC = segue.destination as! FilterTableViewController
            nextVC.filter = filter
            nextVC.search = search
        }
        if segue.identifier == "userAccountInfoSegue"{
            //Changed to new name
            let nextVC = segue.destination as! UserPrivateAccountViewController
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
   // var passingData = PassingData()
    let Star = CosmosView()
    var polyline: MKPolyline?
    
    var filter = Filter()
    var removedToilet = false
    var createdArray = false
    
    @IBOutlet weak var tableViewConstraint: NSLayoutConstraint!
    
    
    
    var resultSearchController: UISearchController!
    var selectedPin: MKPlacemark?
    var databaseRef: FIRDatabaseReference!
    let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)

    
    @IBOutlet weak var searchEndButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var searchEndLabel: UILabel!
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = FIRDatabase.database().reference()
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
        
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
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
        
        if filter.distanceSetted == false{
            filter.distanceFilter = 3
        }
        
        print("search.searchOn = \(search.searchOn)")
        if search.searchOn == false {
            searchEndLabel.isHidden = true
            searchEndButton.isHidden = true
            
        }
        
        searchEndLabel.backgroundColor = UIColor.white
        searchEndButton.backgroundColor = primaryColor
        
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
        
//        tableView.isHidden = false
      listButton.isHidden = true
      centerButton.isHidden = true
        
         print("filter.typeFilter = \(filter.typeFilter)")
        
        
        let stringText = "japanese_toilet".localized
        print("This is the string Text 888\(stringText)")
        
        
        //savingToilets()
        
        self.navigationController?.navigationBar.tintColor = primaryColor
        
        
        progressBarDisplayer(msg:"トイレを検索中", true)
        
//        print("PassingData.sharedInstance.welcomeMessage = \(PassingData.shared.welcomeMessage)")
//        print("PassingData.sharedInstance.filterOn = \(PassingData.shared.filterOn)")
//
//        
//        
//        PassingData.sharedInstance.welcomeMessage = "HEY CHANGED"
//        PassingData.sharedInstance.filterOn = false
        
    }
    
    func tableViewDisappear(){
        //tableView.isHidden = true
        
        if listButton.isHidden == true{
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        tableViewConstraint.constant = screenHeight
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        //booleanTableViewLeftConstraint.constant = screenWidth
        listButton.isHidden = false
        centerButton.isHidden = false
        //showButtons()
        }
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
        print("mapCentered Called 888")
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        //2000 to 1000
        //May 5
        mapView.setRegion(coordinateRegion, animated: false)
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)")
        if mapHasCenteredOnce == false{
            print("mapCentered888")
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
    
   // func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //changed MKAnnotaion to ToiletMarkers April 15th
    
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationIdentifier = "Toilets"
        
        var view = self.mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotation.isKind(of: MKUserLocation.self){
            print("Annotaion User Return nil")
            return nil
            //Added for the blue dot for user Location 18th
        }else{
           
            if annotation.isKind(of: StarOneMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_one_yellow_30-2")
            } else if annotation.isKind(of: StarTwoMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_two_blue_30")
            } else if annotation.isKind(of: StarThreeMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_three_red_ 30")
            } else if annotation.isKind(of: StarFourMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_four_parple_30")
            } else if annotation.isKind(of: StarFiveMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_five_orange_30-1")
            } else if view == nil {
                
                
                //There was a error once (breakpoint 10.1) 18th
                
                
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                
                
                
                
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_red_40_20")

                
                
                print("view == nil called")
                
            } else {
                view?.annotation = annotation
                print("else view == annotaion")
                
                view?.image = UIImage(named: "pin_red_40_20")

            }
        }
        //print("MKAnnotaionView Return \(String(describing: view))")
        
        return view
        
    
    }
    
    
    ////Copied from Custom Annotaiton Tutorial 
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        // 2
        let toiletAnnotation = view.annotation as! ToiletMarkers
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.placeNameLabel.text = toiletAnnotation.name
        calloutView.availableWaitAndDistanceLabel.text = "平均待ち" + "\(toiletAnnotation.averageWait)" + "分/" + "\(toiletAnnotation.distance)"
        calloutView.starImage.rating = Double(toiletAnnotation.averageStar)!
        //calloutView.starImage.text = toiletAnnotation.averageStar
        calloutView.starImage.settings.filledColor = UIColor.yellow
        calloutView.starImage.settings.emptyBorderColor = UIColor.orange
        calloutView.starImage.settings.filledBorderColor = UIColor.orange
        
        
        calloutView.starImage.text = "\(Double(toiletAnnotation.averageStar)!)(\(toiletAnnotation.reviewCount)件) "
        calloutView.starImage.settings.textColor = UIColor.black
        calloutView.starImage.settings.textMargin = 3
        calloutView.starImage.settings.textFont.withSize(CGFloat(50.0))
        
        
        
        
        
        
        calloutView.key = toiletAnnotation.key
        
        print("calloutView.key = \(calloutView.key)")
        
//        calloutView.starbucksName.text = .name
//        calloutView.starbucksAddress.text = starbucksAnnotation.address
//        calloutView.starbucksPhone.text = starbucksAnnotation.phone
        
        //
        let button = UIButton(frame: calloutView.lookDetailLabel.frame)
        button.addTarget(self, action: #selector(MapViewController.lookDetailInfoFunction(sender:)), for: .touchUpInside)
        calloutView.addSubview(button)
       // calloutView.starbucksImage.image = starbucksAnnotation.image
        // 3
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }


    
    func lookDetailInfoFunction(sender: UIButton)
    {
        print("lookDetailInfoButtonTapped")
        let v = sender.superview as! CustomCalloutView
        
        let storyboard = UIStoryboard(name: "PlaceDetailViewController", bundle: nil)
        let navigationContoller = storyboard.instantiateViewController(withIdentifier: "PlaceNavigationController") as! UINavigationController
        let nextVC = navigationContoller.topViewController as! PlaceDetailViewController
        
        print("lookDetailInfoButtonTapped  1111")
       
        nextVC.toilet.key = v.key
        print("V.key\(v.key)")
        nextVC.filter = filter
        nextVC.search = search
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        print("lookDetailInfoButtonTapped  2222")
        view.window!.layer.add(transition, forKey: kCATransition)
        

        
        self.present(navigationContoller, animated: false, completion: nil)
        
        print("lookDetailInfoButtonTapped  3333")

        
        
        
//        if let url = URL(string: "telprompt://\(v.starbucksPhone.text!)"), UIApplication.shared.canOpenURL(url)
//        {
//            UIApplication.shared.openURL(url)
//        }
        
    }

    
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        
//        if let anno = view.annotation{
//            
//            var place: MKPlacemark!
//            place = MKPlacemark(coordinate: anno.coordinate)
//            let destination = MKMapItem(placemark: place)
//            destination.name = (view.annotation?.title)!
//            let destionationKey = view.annotation?.subtitle
//            let regionDistance: CLLocationDistance = 1000
//            let regionSpan = MKCoordinateRegionMakeWithDistance(anno.coordinate, regionDistance, regionDistance)
//            
//            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey:  NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking] as [String : Any]
//            
//            print("callout0")
//            
//           FIRDatabase.database().reference().child("UserWentList").child(FIRAuth.auth()!.currentUser!.uid).child(destionationKey!!).setValue(true)
//            print("Callout1")
//            MKMapItem.openMaps(with: [destination], launchOptions: options)
//        }
//    }
    
    
    
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
        search.centerSearchLocation = center
        //Added April 10 2pm
        
        print("center = \(center)")
        
        let circleQuery = geoFire.query(at: center, withRadius: self.filter.distanceFilter)
        _ = circleQuery?.observe(.keyEntered, with: { (key: String?, location: CLLocation?) in
            //query. need to be changed
           //
            print("HEYKey '\(String(describing: key))' entered the search area and is at location '\(String(describing: location))'")
            
            
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
                
//                let type = snapshotValue?["type"] as? Inte
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
                
                
                //let distance = location?.distance(from: center)
                
                //toilet.distance = Double(distance!)
                
              //  toilet.distance = self.distanceCalculationGetString(destination: location!, center: center)
                
                
                toilet.distance = MapViewController.distanceCalculationGetString(destination: location!, center: center)
                
                print("THIS IS THE DISTANCE\(toilet.distance)")
                
                
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
                
                if self.filter.autoDoorFilter == true && toilet.autoDoor == false {
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
                
//                if self.filter.typeFilterOn == true {
//                    if self.filter.typeFilter != toilet.type{
//                    self.removedToilet = true
//                    }
//                    print("toilet.type = \(toilet.type)")
//                }
                
                //Changed toilet type String to Integer
                
                if self.removedToilet == false {
                    self.toilets.append(toilet)
                   
                    //let queryannotations = MKPointAnnotation()
                    let starValueDouble = Double(toilet.averageStar)
                    let starValueInt = Int(starValueDouble!)
                    
                    print("starValueDouble111 = \(String(describing: starValueDouble))")
                        
                    print("starValueInt111 = \(starValueInt)")
                    if starValueInt < 2{
                        let starOneMarker = StarOneMarker(coordinate: (location?.coordinate)!)
                        
                        
                        starOneMarker.key = toilet.key
                        starOneMarker.name = toilet.name
                        starOneMarker.distance = toilet.distance
                        starOneMarker.averageStar = toilet.averageStar
                        starOneMarker.averageWait = toilet.averageWait
                        starOneMarker.coordinate = (location?.coordinate)!
                        starOneMarker.reviewCount = toilet.reviewCount
                        
                        self.mapView.addAnnotation(starOneMarker)
    
                    } else if starValueInt < 3{
                        let starTwoMarker = StarTwoMarker(coordinate: (location?.coordinate)!)
                        
                        starTwoMarker.key = toilet.key
                        starTwoMarker.name = toilet.name
                        starTwoMarker.distance = toilet.distance
                        starTwoMarker.averageStar = toilet.averageStar
                        starTwoMarker.averageWait = toilet.averageWait
                        starTwoMarker.coordinate = (location?.coordinate)!
                        starTwoMarker.reviewCount = toilet.reviewCount
                        
                        self.mapView.addAnnotation(starTwoMarker)
                        
                        
                        
                    } else if starValueInt < 4{
                        let starThreeMarker = StarThreeMarker(coordinate: (location?.coordinate)!)
                        
                        
                        starThreeMarker.key = toilet.key
                        starThreeMarker.name = toilet.name
                        starThreeMarker.distance = toilet.distance
                        starThreeMarker.averageStar = toilet.averageStar
                        starThreeMarker.averageWait = toilet.averageWait
                        starThreeMarker.coordinate = (location?.coordinate)!
                        starThreeMarker.reviewCount = toilet.reviewCount
                        
                        self.mapView.addAnnotation(starThreeMarker)
                        
                    } else if starValueInt < 5{
                        let starFourMarker = StarFourMarker(coordinate: (location?.coordinate)!)
                        
                        
                        starFourMarker.key = toilet.key
                        starFourMarker.name = toilet.name
                        starFourMarker.distance = toilet.distance
                        starFourMarker.averageStar = toilet.averageStar
                        starFourMarker.averageWait = toilet.averageWait
                        starFourMarker.coordinate = (location?.coordinate)!
                        starFourMarker.reviewCount = toilet.reviewCount
                        
                        self.mapView.addAnnotation(starFourMarker)
                        
                    } else if starValueInt == 5{
                     let starFiveMarker = StarFiveMarker(coordinate: (location?.coordinate)!)
                     
                        
                        starFiveMarker.key = toilet.key
                        starFiveMarker.name = toilet.name
                        starFiveMarker.distance = toilet.distance
                        starFiveMarker.averageStar = toilet.averageStar
                        starFiveMarker.averageWait = toilet.averageWait
                        starFiveMarker.coordinate = (location?.coordinate)!
                        starFiveMarker.reviewCount = toilet.reviewCount
                        
                        self.mapView.addAnnotation(starFiveMarker)


                    } else{
                    
                        
                    let queryannotations = ToiletMarkers(coordinate: (location?.coordinate)!)
                    
                    print("location Coodinates \(String(describing: location?.coordinate))")
                    
                    queryannotations.key = toilet.key
                    queryannotations.name = toilet.name
                    queryannotations.distance = toilet.distance
                    queryannotations.averageStar = toilet.averageStar
                    queryannotations.averageWait = toilet.averageWait
                    queryannotations.coordinate = (location?.coordinate)!
                    queryannotations.reviewCount = toilet.reviewCount
                    self.mapView.addAnnotation(queryannotations)
                        
                    
                    
                    print("queryannotaions121\(queryannotations)")
                        
                    }
                    
                    
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
//        listButton.isHidden = true
//        centerButton.isHidden = true
//        ....
        
        //Commented April 14 for animation table view
        
        // let screenSize = UIScreen.main.bounds
        //let screenHeight = screenSize.height
        tableViewConstraint.constant = 192
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        //booleanTableViewLeftConstraint.constant = screenWidth
        listButton.isHidden = true
        centerButton.isHidden = true
        
            
            
        changeStartCell()
        if createdArray == false{
            
            let alertController = UIAlertController (title: "トイレが見つかりませんでした", message: "検索条件を変更しますか？", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "はい", style: .default){ (_) -> Void in
                self.performSegue(withIdentifier: "maptoFilterSegue", sender: nil)
            }
            let cancelAction = UIAlertAction(title: "いいえ", style: .default, handler: nil)
            //let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            //alertController.addAction(cancelAction)
            alertController.addAction(okayAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
       
        }
        //tableView.isHidden = false
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
        print("locationManager.location = \(String(describing: locationManager.location))")
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
    
    
    class func distanceCalculationGetString(destination: CLLocation, center: CLLocation) -> String{
        var dString = ""
        let distance = destination.distance(from: center)
        let distanceDouble = Double(distance)
        
        
        if distanceDouble >= 1000000{
            let td0 = Int(round(0.01*distanceDouble)/0.01/1000000)
            dString = "\(td0)Mm"
        }else if distanceDouble > 1000{
            let td1 = round(0.01*distanceDouble)/0.01/1000
            dString = "\(td1)km"
        } else {
            dString = "\(Int(round(0.1*distanceDouble)/0.1))m"
        }
    
        return dString
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

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
//Copied from Mapkit tutorial




