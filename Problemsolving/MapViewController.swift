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
        
        cell.waitminuteLabel.text = "showAverageWait".localized + String(toilets[indexPath.row].averageWait) + "minute".localized
        
        //cell.waitminuteLabel.text = "平均待ち　\(toilets[indexPath.row].averageWait)分"
        
        cell.Star.settings.filledColor = UIColor.yellow
        cell.Star.settings.emptyBorderColor = UIColor.orange
        cell.Star.settings.filledBorderColor = UIColor.orange
        cell.Star.rating = Double(toilets[indexPath.row].averageStar)!
        
        
//        "showAverageWait" = "平均待ち";
//        "mapReviews" = "件";
        
        cell.Star.text = String(Double(toilets[indexPath.row].averageStar)!) + "(" + String(toilets[indexPath.row].reviewCount) + "mapReviews".localized + ") "
        
       // cell.Star.text = "\(Double(toilets[indexPath.row].averageStar)!)(\(toilets[indexPath.row].reviewCount)件) "
        cell.Star.settings.textColor = UIColor.black
        cell.Star.settings.textMargin = 10
        cell.Star.settings.textFont.withSize(CGFloat(50.0))
        
        cell.mainImageView.layer.masksToBounds = true
        cell.mainImageView.layer.cornerRadius = 8.0
        cell.mainLabel.text = toilets[indexPath.row].name
        
        cell.distanceLabel.text = toilets[indexPath.row].distance
        
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
        
        if segue.identifier == "maptoFilterSegue"{
            let nextVC = segue.destination as! FilterTableViewController
            nextVC.filter = filter
            nextVC.search = search
        }
        if segue.identifier == "userAccountInfoSegue"{
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
    
    var query300 = false
    var query600 = false
    var query900 = false
    var query1200 = false
    var query1500 = false
    var query1800 = false
    var query3600 = false
    var query7200 = false
    var query10000 = false
    
    var distance300: [String] = []
    var distance300In: [String] = []
    var distance600: [String] = []
    var distance600In: [String] = []
    var distance900: [String] = []
    var distance900In: [String] = []
    var distance1200: [String] = []
    var distance1200In: [String] = []
    var distance1500: [String] = []
    var distance1500In: [String] = []
    var distance1800: [String] = []
    var distance1800In: [String] = []
    var distance3600: [String] = []
    var distance3600In: [String] = []
    var distance7200: [String] = []
    var distance7200In: [String] = []
    var distance10000: [String] = []
    var distance10000In: [String] = []
    
    
    var centerLocation = CLLocation()
    let toilet = Toilet()
    var search = Search()
    let Star = CosmosView()
    var polyline: MKPolyline?
    var filter = Filter()
    var removedToilet = false
    var createdArray = false
    var wifiAlert = false
    
    
    
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
        
        viewLayout()
    }
    
    func viewLayout(){
        
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
        
//        if filter.distanceSetted == false{
//            filter.distanceFilter = 3
//        }
        
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
        
        
        mapView.addGestureRecognizer(tap)
        
        
        listButton.isHidden = true
        centerButton.isHidden = true
        
        
        
        
        let stringText = "japanese_toilet".localized
        print("This is the string Text 888\(stringText)")
        
        
        self.navigationController?.navigationBar.tintColor = primaryColor
        
        
        progressBarDisplayer(msg:"トイレを検索中", true)
        
        if FIRAuth.auth()!.currentUser != nil{
            //Current user exists
            print("User Found")
            // let userID = FIRAuth.auth()!.currentUser!.uid
            
        } else {
            print("User Not Found")
            anonymousLogin()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
        updateUserInterface()
    }
    
    func anonymousLogin(){
        print("anonymouLogin Called")
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if error != nil{
                print("Error \(String(describing: error))")
                return
            }else {
                
                print("User Sigin In Anonymously Uid \(user!.uid)")
                
            }
        })
    }
    
    func updateUserInterface() {
        guard let status = Network.reachability?.status else { return }
        switch status {
        case .unreachable:
            view.backgroundColor = .red
        case .wifi:
            view.backgroundColor = .green
        case .wwan:
            view.backgroundColor = .yellow
        }
        print("Reachability Summary")
        print("Status:", status)
        print("HostName:", Network.reachability?.hostname ?? "nil")
        print("Reachable:", Network.reachability?.isReachable ?? "nil")
        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
        
        if Network.reachability?.isReachableViaWiFi == false {
            
            useWifi()
        }
    }
    
    func noNetwork(){
        
        let alertController = UIAlertController (title: "Netword", message: "cannot find", preferredStyle: .alert)
        
        
        let settingsAction = UIAlertAction(title: "はい", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "いいえ", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func useWifi(){
        if wifiAlert == false{
            wifiAlert = true
            
           
            let alertController = UIAlertController (title: "locationAccuracy".localized, message: "WifiOn".localized , preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "settings".localized, style: .default) { (_) -> Void in
                
                guard let settingsUrl = URL(string: "App-Prefs:root=WIFI") else {
                    return
                }
                
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
                
            }
            //let settingsAction = UIAlertAction(title: "はい", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "settingIgnore".localized , style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            present(alertController, animated: true, completion: nil)
        }
        
        
        
    }
    
    func statusManager(_ notification: NSNotification) {
        updateUserInterface()
    }
    
    
    func tableViewDisappear(){
        
        if listButton.isHidden == true{
            let screenSize = UIScreen.main.bounds
            let screenHeight = screenSize.height
            tableViewConstraint.constant = screenHeight
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            listButton.isHidden = false
            centerButton.isHidden = false
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
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
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
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        if allInitialDataLoaded == true{
            //What is this??
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
        
        var view = self.mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotation.isKind(of: MKUserLocation.self){
            print("Annotaion User Return nil")
            return nil
        }else{
            
            
            
            if annotation.isKind(of: ReviewZeroMarkers.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                //Test June 12
                view?.image = UIImage(named: "image_review_zero_30")

            
            } else if annotation.isKind(of: StarOneMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_one_primary_30")
            } else if annotation.isKind(of: StarOneRedMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)        //Red
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "red_pin_one")
            } else if annotation.isKind(of: StarTwoMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_two_primary_30")
            } else if annotation.isKind(of: StarTwoRedMarker.self){                                         //Red
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "red_pin_two")
            }else if annotation.isKind(of: StarThreeMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_three_primary_ 30")
            } else if annotation.isKind(of: StarThreeRedMarker.self){                                       //Red
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_red_three")
            }else if annotation.isKind(of: StarFourMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_four_primary_30")
            } else if annotation.isKind(of: StarFourRedMarker.self){                                       //Red
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "red_pin_four")
            }else if annotation.isKind(of: StarFiveMarker.self){
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "pin_five_primary_30")
            } else if annotation.isKind(of: StarFiveRedMarker.self){                                       //Red
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                
                view?.image = UIImage(named: "red_pin_five")
            }
            else if view == nil {
                
                view = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view?.canShowCallout = false
                view?.image = UIImage(named: "pin_two_primary_30")
                
            } else {
                view?.annotation = annotation
                view?.image = UIImage(named: "pin_two_primary_30")
                
            }
        }
        return view
    }
    
    
    ////Copied from Custom Annotaiton Tutorial
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        
        
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
        calloutView.starImage.settings.filledColor = UIColor.yellow
        calloutView.starImage.settings.emptyBorderColor = UIColor.orange
        calloutView.starImage.settings.filledBorderColor = UIColor.orange
        
        
        calloutView.starImage.text = "\(Double(toiletAnnotation.averageStar)!)(\(toiletAnnotation.reviewCount)件) "
        calloutView.starImage.settings.textColor = UIColor.black
        calloutView.starImage.settings.textMargin = 3
        calloutView.starImage.settings.textFont.withSize(CGFloat(50.0))
        calloutView.key = toiletAnnotation.key
        
        let button = UIButton(frame: calloutView.lookDetailLabel.frame)
        button.addTarget(self, action: #selector(MapViewController.lookDetailInfoFunction(sender:)), for: .touchUpInside)
        calloutView.addSubview(button)
        
        
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
        
        let v = sender.superview as! CustomCalloutView
        
        let storyboard = UIStoryboard(name: "PlaceDetailViewController", bundle: nil)
        let navigationContoller = storyboard.instantiateViewController(withIdentifier: "PlaceNavigationController") as! UINavigationController
        let nextVC = navigationContoller.topViewController as! PlaceDetailViewController
        
        
        
        nextVC.toilet.key = v.key
        nextVC.filter = filter
        nextVC.search = search
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(navigationContoller, animated: false, completion: nil)
    }
    
    func starfilter() { // should probably be called sort and not filter
        toilets.sort() { $0.star > $1.star } // sort the fruit by name
        self.tableView.reloadData(); // notify the table view the data has changed
    }
    
    func waitingtimeFilter(){
        toilets.sort()  { $0.star > $1.star }
        self.tableView.reloadData()
    }
    
    
    func distanceFilter(){
        toilets.sort() { $0.distance < $1.distance }
        self.tableView.reloadData()
    }
    
    
    
    func toiletsSearch(center: CLLocation){
        search.centerSearchLocation = center
        
        
        centerLocation = center
        
        
        let circleQuery = geoFire.query(at: center, withRadius: 10.0)
        _ = circleQuery?.observe(.keyEntered, with: { (key: String?, location: CLLocation?) in
            
            let distance = location?.distance(from: center)
            let distanceDouble = Double(distance!)
            
            if distanceDouble <= 300{
                self.distance300.append(key!)
            } else if distanceDouble <= 600{
                self.distance600.append(key!)
            } else if distanceDouble <= 900{
                self.distance900.append(key!)
            } else if distanceDouble <= 1200{
                self.distance1200.append(key!)
            } else if distanceDouble <= 1500{
                self.distance1500.append(key!)
            } else if distanceDouble <= 1800{
                self.distance1800.append(key!)
            } else if distanceDouble <= 3600{
                self.distance3600.append(key!)
            }else if distanceDouble <= 7200{
                self.distance7200.append(key!)
            } else {
                self.distance10000.append(key!)
            }
            
        })
        circleQuery?.observeReady({
            print(" 555 All initial data has been loaded and events have been fired!")
            self.distance300Call()
            self.allInitialDataLoaded = true
            self.messageFrame.removeFromSuperview()
            self.tableView.reloadData()
            self.changeStartCell()
            
            
        })
    }
    
    
    func distance300Call(){
        
        query300 = true
        
        if distance300.isEmpty{
            print("distance300 is empty Call 00 for in inside 666")
            distance600Call()
        }
        
        queryByDistaceArray(array: distance300)
        
    }
    
    

    
    func distance600Call(){
        
        
        query600 = true
        query300 = false

        if distance600.isEmpty{
            print("distance600 is empty Call 1200 for in inside 666")
            distance900Call()
        }
        
        queryByDistaceArray(array: distance600)

    }
    
    func distance900Call(){
        
        
        query900 = true
        query600 = false
        
        if distance900.isEmpty{
            print("distance600 is empty Call 1200 for in inside 666")
            distance1200Call()
        }
        
        queryByDistaceArray(array: distance900)
        
    }
    
    func distance1200Call(){
        
        query1200 = true
        query900 = false
        
        if distance1200.isEmpty{
            distance1500Call()
            
        }
        queryByDistaceArray(array: distance1200)
     
    }
    
    func distance1500Call(){
        
        query1500 = true
        query1200 = false
        
        if distance1500.isEmpty{
            distance1800Call()
        }
        queryByDistaceArray(array: distance1500)
        
    }

    
    func distance1800Call(){
        
        query1800 = true
        query1500 = false
  
        if distance1800.isEmpty{
            distance3600Call()
        }
        queryByDistaceArray(array: distance1800)

    }
    
    
    func distance3600Call(){
        
        query3600 = true
        query1800 = false
        
        if distance3600.isEmpty{
            distance7200Call()
        }
        
        queryByDistaceArray(array: distance3600)

    }
    
    
    func distance7200Call(){
        query7200 = true
        query3600 = false
        
        if distance7200.isEmpty{
            distance10000Call()
        }
        
        queryByDistaceArray(array: distance7200)

    }
    
    func distance10000Call(){
        query10000 = true
        query7200 = false
        
        queryByDistaceArray(array: distance10000)
    }
    
    func queryByDistaceArray(array: Array<Any>){
        
        var queryPath = self.filter.queryPath
        if queryPath == ""{
            queryPath = "NoFilter"
        }
        
        for item in array{
                let toiletsRef = FIRDatabase.database().reference().child(queryPath)
                toiletsRef.child(item as! String).observeSingleEvent(of: FIRDataEventType.value, with:{ snapshot in
                    self.createTableViewAndMarker(snapshot: snapshot, key: item as! String)
                })
            }
    }
    
    
    func createTableViewAndMarker(snapshot: FIRDataSnapshot, key: String){
        
        if !snapshot.exists(){
            return
        }
        
        //Chnanged toilets.count < 4 to 100
        if query300 == true{
            distance300In.append(key)
            if distance300In.count == distance300.count{
                if toilets.count < 100 {
                    distance600Call()
                }
            }
            
        } else if query600 == true{
            distance600In.append(key)
            if distance600In.count == distance600.count{
                if toilets.count < 100 {
                    distance900Call()
                }
            }
            
        } else if query900 == true{
            distance900In.append(key)
            if distance900In.count == distance900.count{
                if toilets.count < 100 {
                    distance1200Call()
                }
            }
            
        } else if query1200 == true{
            distance1200In.append(key)
            if distance1200In.count == distance1200.count{
                if toilets.count < 100 {
                    distance1500Call()
                }
            }
        } else if query1500 == true{
            distance1500In.append(key)
            if distance1500In.count == distance1500.count{
                if toilets.count < 100 {
                    distance1500Call()
                }
            }
        } else if query1800 == true{
            
            distance1800In.append(key)
            if distance1800In.count == distance1800.count{
                if toilets.count < 100 {
                    distance3600Call()
                }
            }
            
            
        } else if query3600 == true{
            distance3600In.append(key)
            if distance3600In.count == distance3600.count{
                if toilets.count < 100 {
                    distance7200Call()
                }
            }
            
            
        } else if query7200 == true{
            distance7200In.append(key)
            if distance7200In.count == distance7200.count{
                if toilets.count < 100 {
                    distance10000Call()
                }
            }
            
            
        }

        let toilet = Toilet()
        let snapshotValue = snapshot.value as? NSDictionary
        
        //Type Filter
        toilet.type = (snapshotValue?["type"] as? Int)!
        
        if self.filter.typeFilterOn == true && self.filter.typeFilter != toilet.type {
            return
        }
        
        //Gotta Make sure the integet is the right  May 8
    
        //Star Filter
        
        let averageStar = snapshotValue?["averageStar"] as? String
        toilet.star = Double(averageStar!)!
        
        if self.filter.starFilterSetted == true && toilet.star < self.filter.starFilter{
            return
        }
        
        //Available Filter
        
        
        
        if self.filter.availableFilter == true{
            toilet.openHours = (snapshotValue?["openHours"] as? Int)!
            toilet.closeHours = (snapshotValue?["closeHours"] as? Int)!
            
            //Do something to know its availble or not
            return
        }
        
        //Opening Hours Filter
        
        
        
        toilet.available = (snapshotValue?["available"] as? Bool)!
        if toilet.available == false{
            return
        }
        
        
        //Available is different from other boolean values becuase every data has available boolean. //May 22
        //Boolean Filters
        //Basic Info
        if self.filter.japaneseFilter == true {
            toilet.japanesetoilet = (snapshotValue?["japanesetoilet"] as? Bool)!
            if toilet.japanesetoilet == false{
                return
            }
        }
        if self.filter.westernFilter == true {
            toilet.westerntoilet = (snapshotValue?["westerntoilet"] as? Bool)!
            if toilet.westerntoilet == false{
                return
            }
        }
        if self.filter.onlyFemaleFilter == true {
            toilet.onlyFemale = (snapshotValue?["onlyFemale"] as? Bool)!
            if toilet.onlyFemale == false{
                return
            }
        }
        if self.filter.unisexFilter == true {
            toilet.unisex = (snapshotValue?["unisex"] as? Bool)!
            if toilet.unisex == false{
                return
            }
        }
        
        //Toilet Seat
        if self.filter.washletFilter == true {
            toilet.washlet = (snapshotValue?["washlet"] as? Bool)!
            if toilet.washlet == false{
                return
            }
        }
        if self.filter.warmSearFilter == true {
            toilet.warmSeat = (snapshotValue?["warmSeat"] as? Bool)!
            if toilet.warmSeat == false{
                return
            }
        }
        if self.filter.autoOpen == true {
            toilet.autoOpen = (snapshotValue?["autoOpen"] as? Bool)!
            if toilet.autoOpen == false{
                return
            }
        }
        if self.filter.noVirusFilter == true {
            toilet.noVirus = (snapshotValue?["noVirus"] as? Bool)!
            if toilet.noVirus == false{
                return
            }
        }
        if self.filter.paperForBenkiFilter == true {
            toilet.paperForBenki = (snapshotValue?["paperForBenki"] as? Bool)!
            if toilet.paperForBenki == false{
                return
            }
        }
        if self.filter.cleanerForBenkiFilter == true {
            toilet.cleanerForBenki = (snapshotValue?["cleanerForBenki"] as? Bool)!
            if toilet.cleanerForBenki == false{
                return
            }
        }
        if self.filter.autoToiletWashFilter == true {
            toilet.autoToiletWash = (snapshotValue?["nonTouchWash"] as? Bool)!
            if toilet.autoToiletWash == false{
                return
            }
        }
        
        
        
        //Washstand
        if self.filter.sensorHandWashFilter == true {
            toilet.sensorHandWash = (snapshotValue?["sensorHandWash"] as? Bool)!
            if toilet.sensorHandWash == false{
                return
            }
        }
        if self.filter.handSoapFilter == true {
            toilet.handSoap = (snapshotValue?["handSoap"] as? Bool)!
            if toilet.handSoap == false{
                return
            }
        }
        if self.filter.autoHandSoapFilter == true {
            toilet.autoHandSoap = (snapshotValue?["nonTouchHandSoap"] as? Bool)!
            if toilet.autoHandSoap == false{
                return
            }
        }
        if self.filter.paperTowelFilter == true {
            toilet.paperTowel = (snapshotValue?["paperTowel"] as? Bool)!
            if toilet.paperTowel == false{
                return
            }
        }
        if self.filter.handDrierFilter == true {
            toilet.handDrier = (snapshotValue?["handDrier"] as? Bool)!
            if toilet.handDrier == false{
                return
            }
        }
        
        
        
        
        
        //Other things one
        
        if self.filter.fancy == true {
            toilet.fancy = (snapshotValue?["fancy"] as? Bool)!
            if toilet.fancy == false{
                return
            }
        }
        if self.filter.smell == true {
            toilet.smell = (snapshotValue?["smell"] as? Bool)!
            if toilet.smell == false{
                return
            }
        }
        if self.filter.confortableWise == true {
            toilet.conforatableWide = (snapshotValue?["confortable"] as? Bool)!
            if toilet.conforatableWide == false{
                return
            }
        }
        if self.filter.clothes == true {
            toilet.clothes = (snapshotValue?["clothes"] as? Bool)!
            if toilet.clothes == false{
                return
            }
        }
        if self.filter.baggageSpaceFilter == true {
            toilet.baggageSpace = (snapshotValue?["baggageSpace"] as? Bool)!
            if toilet.baggageSpace == false{
                return
            }
        }
        
        
        //Other things two
        if self.filter.noNeedAsk == true {
            toilet.noNeedAsk = (snapshotValue?["noNeedAsk"] as? Bool)!
            if toilet.noNeedAsk == false{
                return
            }
        }
        if self.filter.writtenEnglish == true {
            toilet.english = (snapshotValue?["english"] as? Bool)!
            if toilet.english == false{
                return
            }
        }
        if self.filter.parking == true {
            toilet.parking = (snapshotValue?["parking"] as? Bool)!
            if toilet.parking == false{
                return
            }
        }
        if self.filter.airConditionFilter == true {
            toilet.airCondition = (snapshotValue?["airCondition"] as? Bool)!
            if toilet.airCondition == false{
                return
            }
        }
        if self.filter.wifiFilter == true {
            toilet.wifi = (snapshotValue?["wifi"] as? Bool)!
            if toilet.wifi == false{
                return
            }
        }
        
        //Ladys
        if self.filter.otohime == true {
            toilet.otohime = (snapshotValue?["otohime"] as? Bool)!
            if toilet.otohime == false{
                return
            }
        }
        if self.filter.napkinSelling == true {
            toilet.napkinSelling = (snapshotValue?["napkinSelling"] as? Bool)!
            if toilet.napkinSelling == false{
                return
            }
        }
        if self.filter.makeroomFilter == true {
            toilet.makeuproom = (snapshotValue?["makeuproom"] as? Bool)!
            if toilet.makeuproom == false{
                return
            }
        }
        if self.filter.ladyOmutu == true {
            toilet.ladyOmutu = (snapshotValue?["ladyOmutu"] as? Bool)!
            if toilet.ladyOmutu == false{
                return
            }
        }
        if self.filter.ladyBabyChair == true {
            toilet.ladyBabyChair = (snapshotValue?["ladyBabyChair"] as? Bool)!
            if toilet.ladyBabyChair == false{
                return
            }
        }
        if self.filter.ladyBabyChairGood == true {
            toilet.ladyBabyChairGood = (snapshotValue?["ladyBabyChairGood"] as? Bool)!
            if toilet.ladyBabyChairGood == false{
                return
            }
        }
        if self.filter.ladyBabyCarAccess == true {
            toilet.ladyBabyCarAccess = (snapshotValue?["ladyBabyCarAccess"] as? Bool)!
            if toilet.ladyBabyCarAccess == false{
                return
            }
        }
        
        //Men
        if self.filter.maleOmutu == true {
            toilet.maleOmutu = (snapshotValue?["maleOmutu"] as? Bool)!
            if toilet.maleOmutu == false{
                return
            }
        }
        if self.filter.maleBabyChair == true {
            toilet.maleBabyChair = (snapshotValue?["maleBabyChair"] as? Bool)!
            if toilet.maleBabyChair == false{
                return
            }
        }
        if self.filter.maleBabyChairgood == true {
            toilet.maleBabyChairGood = (snapshotValue?["maleBabyChairGood"] as? Bool)!
            if toilet.maleBabyChairGood == false{
                return
            }
        }
        if self.filter.maleBabyCarAccess == true {
            toilet.maleBabyCarAccess = (snapshotValue?["maleBabyCarAccess"] as? Bool)!
            if toilet.maleBabyCarAccess == false{
                return
            }
        }
        
        
        //Family
        if self.filter.wheelchairFilter == true {
            toilet.wheelchair = (snapshotValue?["wheelchair"] as? Bool)!
            if toilet.wheelchair == false{
                return
            }
        }
        if self.filter.wheelchairAccessFilter == true {
            toilet.wheelchairAccess = (snapshotValue?["wheelchairAccess"] as? Bool)!
            if toilet.wheelchairAccess == false{
                return
            }
        }
        if self.filter.autoDoorFilter == true {
            toilet.autoDoor = (snapshotValue?["autoDoor"] as? Bool)!
            if toilet.autoDoor == false {
                return
            }
        }
        if self.filter.callHelpFilter == true {
            toilet.callHelp = (snapshotValue?["callHelp"] as? Bool)!
            if toilet.callHelp == false{
                return
            }
        }
        if self.filter.ostomateFilter == true {
            toilet.ostomate = (snapshotValue?["ostomate"] as? Bool)!
            if toilet.ostomate == false{
                return
            }
        }
        if self.filter.braille == true {
            toilet.braille = (snapshotValue?["braille"] as? Bool)!
            if toilet.braille == false{
                return
            }
        }
        if self.filter.voiceGuideFilter == true {
            toilet.voiceGuide = (snapshotValue?["voiceGuide"] as? Bool)!
            if toilet.voiceGuide == false{
                return
            }
        }
        if self.filter.familyOmutu == true {
            toilet.familyOmutu = (snapshotValue?["familyOmutu"] as? Bool)!
            if toilet.familyOmutu == false{
                return
            }
        }
        if self.filter.familyBabyChair == true {
            toilet.familyBabyChair = (snapshotValue?["familyBabyChair"] as? Bool)!
            if toilet.familyBabyChair == false{
                return
            }
        }
        
        
        //Milk Room One
        if self.filter.milkspaceFilter == true{
            toilet.milkspace = (snapshotValue?["milkspace"] as? Bool)!
            
            if toilet.milkspace == false{
                return
            }
        }
        if self.filter.babyRoomOnlyFemaleFilter == true {
            toilet.babyroomOnlyFemale = (snapshotValue?["babyRoomOnlyFemale"] as? Bool)!
            if toilet.babyroomOnlyFemale == false{
                return
            }
        }
        if self.filter.babyRoomMaleCanEnterFilter == true {
            toilet.babyroomManCanEnter = (snapshotValue?["babyRoomMaleEnter"] as? Bool)!
            if toilet.babyroomManCanEnter == false{
                return
            }
        }
        if self.filter.babyRoomPersonalSpaceFilter == true {
            toilet.babyPersonalSpace = (snapshotValue?["babyRoomPersonalSpace"] as? Bool)!
            if toilet.babyPersonalSpace == false{
                return
            }
        }
        if self.filter.babyRoomPersonalWithLockFilter == true{
            toilet.babyPersonalSpaceWithLock = (snapshotValue?["babyRoomPersonalSpaceWithLock"] as? Bool)!
            if toilet.babyPersonalSpace == false{
                return
            }
        }
        if self.filter.babyRoomWideSpaceFilter == true {
            toilet.babyRoomWideSpace = (snapshotValue?["babyRoomWideSpace"] as? Bool)!
            if toilet.babyRoomWideSpace == false{
                return
            }
        }
        
        
        
        //MIlk Room Two
        if self.filter.babyCarRentalFilter == true {
            toilet.babyCarRental = (snapshotValue?["babyCarRental"] as? Bool)!
            if toilet.babyCarRental == false{
                return
            }
        }
        if self.filter.babyCarAccessFilter == true{
            toilet.babyCarAccess = (snapshotValue?["babyCarAccess"] as? Bool)!
            if toilet.babyCarAccess == false{
                return
            }
        }
        if self.filter.omutuFilter == true {
            toilet.omutu = (snapshotValue?["omutu"] as? Bool)!
            if toilet.omutu == false{
                return
            }
        }
        if self.filter.babyHipWashingStuffFilter == true {
            toilet.hipWashingStuff = (snapshotValue?["hipCleaningStuff"] as? Bool)!
            if toilet.hipWashingStuff == false{
                return
            }
        }
        if self.filter.omutuTrashCanFilter == true {
            toilet.babyTrashCan = (snapshotValue?["omutuTrashCan"] as? Bool)!
            if toilet.babyTrashCan == false{
                return
            }
        }
        if self.filter.omutuSelling == true  {
            toilet.omutuSelling = (snapshotValue?["omutuSelling"] as? Bool)!
            if toilet.omutuSelling == false{
                return
            }
        }
        
        
        //Milk Room 3
        if self.filter.babySinkFilter == true {
            toilet.babyRoomSink = (snapshotValue?["babySink"] as? Bool)!
            if toilet.babyRoomSink == false{
                return
            }
        }
        if self.filter.babyWashstandFilter == true {
            toilet.babyWashStand = (snapshotValue?["babyWashstand"] as? Bool)!
            if toilet.babyWashStand == false{
                return
            }
        }
        if self.filter.babyHotWaterFilter == true {
            toilet.babyHotWater = (snapshotValue?["babyHotwater"] as? Bool)!
            if toilet.babyHotWater == false{
                return
            }
        }
        if self.filter.babyMicrowaveFilter == true {
            toilet.babyMicroWave = (snapshotValue?["babyMicrowave"] as? Bool)!
            if toilet.babyMicroWave == false{
                return
            }
        }
        if self.filter.babySellingWaterFilter == true {
            toilet.babyWaterSelling = (snapshotValue?["babyWaterSelling"] as? Bool)!
            if toilet.babyWaterSelling == false{
                return
            }
        }
        if self.filter.babyFoodSellingFilter == true {
            toilet.babyFoddSelling = (snapshotValue?["babyFoodSelling"] as? Bool)!
            if toilet.babyFoddSelling == false {
                return
            }
        }
        if self.filter.babyEatingSpaceFilter == true {
            toilet.babyEatingSpace = (snapshotValue?["babyEatingSpace"] as? Bool)!
            if toilet.babyEatingSpace == false{
                return
            }
        }
        
        
        //Milk Room 4
        if self.filter.babyChairFilter == true {
            toilet.babyChair = (snapshotValue?["babyChair"] as? Bool)!
            if toilet.babyChair == false{
                return
            }
        }
        if self.filter.babySoffaFilter == true {
            toilet.babySoffa = (snapshotValue?["babySoffa"] as? Bool)!
            if toilet.babySoffa == false{
                return
            }
        }
        if self.filter.babyToiletFilter == true {
            toilet.babyKidsToilet = (snapshotValue?["kidsToilet"] as? Bool)!
            if toilet.babyKidsToilet == false{
                return
            }
        }
        if self.filter.babyKidsSpaceFilter == true{
            toilet.babyKidsSpace = (snapshotValue?["kidsSpace"] as? Bool)!
            if toilet.babyKidsSpace == false{
                return
            }
        }
        if self.filter.babyHeightMeasureFilter == true {
            toilet.babyHeightMeasure = (snapshotValue?["babyHeight"] as? Bool)!
            if toilet.babyHeightMeasure == false{
                return
            }
        }
        if self.filter.babyWeightMeasureFilter == true{
            toilet.babyWeightMeasure = (snapshotValue?["babyWeight"] as? Bool)!
            if toilet.babyWeightMeasure == false{
                return
            }
        }
        if self.filter.babyToyFilter == true {
            toilet.babyToy = (snapshotValue?["babyToy"] as? Bool)!
            if toilet.babyToy == false{
                return
            }
        }
        if self.filter.babyRoomFancyFilter == true {
            toilet.babyFancy = (snapshotValue?["babyFancy"] as? Bool)!
            if toilet.babyFancy == false{
                return
            }
        }
        if self.filter.babyRoomSmellGoodFilter == true {
            toilet.babySmellGood = (snapshotValue?["babySmellGood"] as? Bool)!
            if toilet.babySmellGood == false{
                return
            }
        }
        
        
        
        //Boolean Filters Complete
        
        
        toilet.key = key
        
        
        let urlOne = snapshotValue?["urlOne"] as? String
        toilet.urlOne = urlOne!
        
        toilet.averageStar = (snapshotValue?["averageStar"] as? String)!
        //There are toilet star and toilet averageStar Maybe Redundant??
        
        
        
        
        
        
        toilet.name = (snapshotValue?["name"] as? String)!
        toilet.urlOne = (snapshotValue?["urlOne"] as? String)!
        
        
        toilet.reviewCount = (snapshotValue?["reviewCount"] as? Int)!
        toilet.averageWait = (snapshotValue?["averageWait"] as? Int)!
        
        
        
        let reviewCount = snapshotValue?["reviewCount"] as? Int
        toilet.reviewCount = reviewCount!
        let averageWait = snapshotValue?["averageWait"] as? Int
        toilet.averageWait = averageWait!
        
        
        
        let center = centerLocation
        toilet.latitude = (snapshotValue?["latitude"] as? Double)!
        toilet.longitude = (snapshotValue?["longitude"] as? Double)!
        let location = CLLocation(latitude: toilet.latitude, longitude: toilet.longitude)
        
        
        let distance = location.distance(from: center)
        
        toilet.distanceNumber = distance
        toilet.distance = MapViewController.distanceCalculationGetString(destination: location, center: center)
        self.toilets.append(toilet)
    
        let starValueDouble = Double(toilet.star)
        
        let starValueInt = Int(starValueDouble)
    
        if toilet.reviewCount == 0{
            
            let reviewZeroMarker = ReviewZeroMarkers(coordinate: (location.coordinate))
            
            reviewZeroMarker.key = toilet.key
            reviewZeroMarker.name = toilet.name
            reviewZeroMarker.distance = toilet.distance
            reviewZeroMarker.averageStar = toilet.averageStar
            reviewZeroMarker.averageWait = toilet.averageWait
            reviewZeroMarker.coordinate = (location.coordinate)
            reviewZeroMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(reviewZeroMarker)

            
        
        } else if starValueInt < 2 && toilet.available == true{
            let starOneMarker = StarOneMarker(coordinate: (location.coordinate))
            
            
            
            starOneMarker.key = toilet.key
            starOneMarker.name = toilet.name
            starOneMarker.distance = toilet.distance
            starOneMarker.averageStar = toilet.averageStar
            starOneMarker.averageWait = toilet.averageWait
            starOneMarker.coordinate = (location.coordinate)
            starOneMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starOneMarker)
            
        } else if starValueInt < 2 && toilet.available == false{
            let starOneMarker = StarOneRedMarker(coordinate: (location.coordinate))
            
            
            starOneMarker.key = toilet.key
            starOneMarker.name = toilet.name
            starOneMarker.distance = toilet.distance
            starOneMarker.averageStar = toilet.averageStar
            starOneMarker.averageWait = toilet.averageWait
            starOneMarker.coordinate = (location.coordinate)
            starOneMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starOneMarker)
            
        }
            
        else if starValueInt < 3 && toilet.available == true{
            let starTwoMarker = StarTwoMarker(coordinate: (location.coordinate))
            
            starTwoMarker.key = toilet.key
            starTwoMarker.name = toilet.name
            starTwoMarker.distance = toilet.distance
            starTwoMarker.averageStar = toilet.averageStar
            starTwoMarker.averageWait = toilet.averageWait
            starTwoMarker.coordinate = (location.coordinate)
            starTwoMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starTwoMarker)
            
            
            
        } else if starValueInt < 3 && toilet.available == false{
            let starTwoMarker = StarTwoRedMarker(coordinate: (location.coordinate))
            
            starTwoMarker.key = toilet.key
            starTwoMarker.name = toilet.name
            starTwoMarker.distance = toilet.distance
            starTwoMarker.averageStar = toilet.averageStar
            starTwoMarker.averageWait = toilet.averageWait
            starTwoMarker.coordinate = (location.coordinate)
            starTwoMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starTwoMarker)
            
            
        } else if starValueInt < 4 && toilet.available == true{
            let starThreeMarker = StarThreeMarker(coordinate: (location.coordinate))
            
            
            starThreeMarker.key = toilet.key
            starThreeMarker.name = toilet.name
            starThreeMarker.distance = toilet.distance
            starThreeMarker.averageStar = toilet.averageStar
            starThreeMarker.averageWait = toilet.averageWait
            starThreeMarker.coordinate = (location.coordinate)
            starThreeMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starThreeMarker)
            
        } else if starValueInt < 4 && toilet.available == false{
            let starThreeMarker = StarThreeRedMarker(coordinate: (location.coordinate))
            
            
            starThreeMarker.key = toilet.key
            starThreeMarker.name = toilet.name
            starThreeMarker.distance = toilet.distance
            starThreeMarker.averageStar = toilet.averageStar
            starThreeMarker.averageWait = toilet.averageWait
            starThreeMarker.coordinate = (location.coordinate)
            starThreeMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starThreeMarker)
            
        } else if starValueInt < 5 && toilet.available == true{
            let starFourMarker = StarFourMarker(coordinate: (location.coordinate))
            
            
            starFourMarker.key = toilet.key
            starFourMarker.name = toilet.name
            starFourMarker.distance = toilet.distance
            starFourMarker.averageStar = toilet.averageStar
            starFourMarker.averageWait = toilet.averageWait
            starFourMarker.coordinate = (location.coordinate)
            starFourMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starFourMarker)
            
        } else if starValueInt < 5 && toilet.available == false{
            let starFourMarker = StarFourRedMarker(coordinate: (location.coordinate))
            
            
            starFourMarker.key = toilet.key
            starFourMarker.name = toilet.name
            starFourMarker.distance = toilet.distance
            starFourMarker.averageStar = toilet.averageStar
            starFourMarker.averageWait = toilet.averageWait
            starFourMarker.coordinate = (location.coordinate)
            starFourMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starFourMarker)
            
        } else if starValueInt == 5 && toilet.available == true {
            let starFiveMarker = StarFiveMarker(coordinate: (location.coordinate))
            
            
            starFiveMarker.key = toilet.key
            starFiveMarker.name = toilet.name
            starFiveMarker.distance = toilet.distance
            starFiveMarker.averageStar = toilet.averageStar
            starFiveMarker.averageWait = toilet.averageWait
            starFiveMarker.coordinate = (location.coordinate)
            starFiveMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starFiveMarker)
            
            
        } else if starValueInt == 5 && toilet.available == false {
            let starFiveMarker = StarFiveRedMarker(coordinate: (location.coordinate))
            
            
            starFiveMarker.key = toilet.key
            starFiveMarker.name = toilet.name
            starFiveMarker.distance = toilet.distance
            starFiveMarker.averageStar = toilet.averageStar
            starFiveMarker.averageWait = toilet.averageWait
            starFiveMarker.coordinate = (location.coordinate)
            starFiveMarker.reviewCount = toilet.reviewCount
            
            self.mapView.addAnnotation(starFiveMarker)
            
            
        } else{
            
            
            let queryannotations = ToiletMarkers(coordinate: (location.coordinate))
            queryannotations.key = toilet.key
            queryannotations.name = toilet.name
            queryannotations.distance = toilet.distance
            queryannotations.averageStar = toilet.averageStar
            queryannotations.averageWait = toilet.averageWait
            queryannotations.coordinate = (location.coordinate)
            queryannotations.reviewCount = toilet.reviewCount
            self.mapView.addAnnotation(queryannotations)
        }
        
        
        self.createdArray = true
        if self.filter.orderDistanceFilter == true {
            self.toilets.sort() { $0.distanceNumber < $1.distanceNumber }
            self.tableView.reloadData()
        }
        
        if self.filter.orderStarFilter == true{
            self.toilets.sort() { $0.star > $1.star }
            self.tableView.reloadData()
        }
        
        if self.filter.orderReviewFilter == true{
            self.toilets.sort() { $0.reviewCount > $1.reviewCount }
            self.tableView.reloadData()
        }
        
    }
    
    
    
    
    @IBAction func listButtonTapped(_ sender: Any) {
        
        tableViewConstraint.constant = 192
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        listButton.isHidden = true
        centerButton.isHidden = true
        changeStartCell()
        if createdArray == false{
            
            let alertController = UIAlertController (title: "トイレが見つかりませんでした", message: "検索条件を変更しますか？", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "はい", style: .default){ (_) -> Void in
                self.performSegue(withIdentifier: "maptoFilterSegue", sender: nil)
            }
            let cancelAction = UIAlertAction(title: "いいえ", style: .default, handler: nil)
            alertController.addAction(okayAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func centerButtonTapped(_ sender: Any) {
        if search.searchOn == true {
            centerMapOnLocation(location: search.centerSearchLocation)
        }else {
            
            if let coord = locationManager.location?.coordinate {
                let region = MKCoordinateRegionMakeWithDistance(coord, 500, 500)
                mapView.setRegion(region, animated: true)
            }
        }
    }
    
    @IBAction func searchEndTapped(_ sender: Any) {
        search.searchOn = false
        let center = locationManager.location
        centerMapOnLocation(location: center!)
        toiletsSearch(center: center!)
        searchEndLabel.isHidden = true
        searchEndButton.isHidden = true
        mapView.showsUserLocation = true
    }
    
    @IBAction func accountButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "userAccountInfoSegue", sender: nil)
        
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
        mapView.removeAnnotations(mapView.annotations)
        toiletsSearch(center: centerB)
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
        self.tableView.reloadData()
        search.searchOn = true
        search.centerSearchLocation = centerB
        searchEndButton.isHidden = false
        searchEndLabel.isHidden = false
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
//Copied from Mapkit tutorial




