//
//  AddPinViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 9/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import MapKit

class AddPinViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var longTappedLabel: UILabel!
    @IBOutlet weak var sendLocationButton: UIButton!
    
    
    var locationManager = CLLocationManager()
    var annotationAdded = false
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        backLabel.backgroundColor = UIColor.white
        sendLocationButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)

        let uilgr = UILongPressGestureRecognizer(target: self, action: #selector(AddPinViewController.action(gestureRecognizer:)))
        uilgr.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(uilgr)

        // Do any additional setup after loading the view.
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
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
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
        if annotationAdded == true{
        performSegue(withIdentifier: "pintodatailSegue", sender: nil)
        print(annotation.coordinate)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pintodatailSegue"{
            let nextVC = segue.destination as! ChangeDetailTableViewController
            nextVC.pincoodinate = annotation.coordinate
        }
        }
  
}
