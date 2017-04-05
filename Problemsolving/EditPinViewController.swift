//
//  EditPinViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 12/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import MapKit




class EditPinViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var longTappedLabel: UILabel!
    @IBOutlet weak var sendLocationButton: UIButton!
    
    var toiletLocation = CLLocationCoordinate2D()
    //Not sure
    var locationManager = CLLocationManager()
    var annotationAdded = false
    let annotation = MKPointAnnotation()
    let toiletAnnoation = MKPointAnnotation()
    
    
    var originalPlaceName = ""
    var originalPlaceCategory = ""
    var originalOpeningHours = ""
    
    var washletisOn = Bool()
    var wheelchairisOn = Bool()
    var onlyFemaleisOn = Bool()
    var unisexisOn = Bool()
    var makeroomisOn = Bool()
    var milkspaceisOn = Bool()
    var omutuspaceisOn = Bool()
    var ostomateisOn = Bool()
    var japaneseisOn = Bool()
    var westernisOn = Bool()
    
    var toilet = Toilet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("toilet.key = \(toilet.key)")
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        backLabel.backgroundColor = UIColor.white
        sendLocationButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        
        toiletAnnoation.coordinate = toiletLocation
        
        mapView.addAnnotation(toiletAnnoation)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(toiletLocation, 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: false)
        
        let uilgr = UILongPressGestureRecognizer(target: self, action: #selector(AddPinViewController.action(gestureRecognizer:)))
        uilgr.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(uilgr)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(toiletLocation, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    
    func action(gestureRecognizer:UIGestureRecognizer){
        if annotationAdded == true {
            mapView.removeAnnotation(annotation) }
        
        
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        print("newCoordinates = \(newCoordinates)")
        //let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        print("annotation.coordinate = \(annotation.coordinate)")
        mapView.addAnnotation(annotation)
        annotationAdded = true
        
        
    }
    
    
    
    @IBAction func sendLocationButtonTapped(_ sender: Any) {
       //  _ = self.navigationController?.popViewController(animated: true)
        print("sendLocationButtonTapped")
        
        
        if annotationAdded == true{
            print("sendLocationButtonTapped true")
            performSegue(withIdentifier: "editPintoEditDetailSegue", sender: nil)
            print(annotation.coordinate)
         //    _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editPintoEditDetailSegue"{
            let nextV = segue.destination as! EditTableViewController
            
            nextV.toilet.key = toilet.key
            print("toilet.key = \(toilet.key)")
            let coordinate: CLLocationCoordinate2D = annotation.coordinate
            
            nextV.toilet = toilet
            nextV.pincoodinate = coordinate

        }

//        if segue.identifier == "pintodatailSegue"{
//            let nextVC = segue.destination as! ChangeDetailTableViewController
//            nextVC.pincoodinate = annotation.coordinate
//        }
    }
    
    
    
    
    

    
}
