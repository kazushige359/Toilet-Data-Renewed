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
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        backLabel.backgroundColor = UIColor.white
        sendLocationButton.backgroundColor = primaryColor

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
            centerMapOnLocation(location: locationManager.location!)
            
            //Added April 12 
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
        progressBarDisplayer(msg:"", true)
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
