//
//  TRY.swift
//  Problemsolving
//
//  Created by 重信和宏 on 14/12/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class TRY: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIAlertViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var mapHasCenteredOnce = false
    var geoFire: GeoFire!
    var geoFireRef: FIRDatabaseReference!
    var regionQuery: GFRegionQuery?
    var foundQuery: GFCircleQuery?
    var annotations: Dictionary<String, ToiletMarkers> = Dictionary(minimumCapacity: 8)
    var nearbyTrucks = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        geoFireRef = FIRDatabase.database().reference()
        geoFire = GeoFire(firebaseRef: geoFireRef)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        //            self.mapView.userLocation.addObserver(self, forKeyPath: "location", options: NSKeyValueObservingOptions(), context: nil)}
    }
    //        //Sigabart 4 1pm
    //    }
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            //            self.mapView.userLocation.addObserver(self, forKeyPath: "location", options: NSKeyValueObservingOptions(), context: nil)
            //Sigabart 3
            print("common LOCAITON")
            //IF this time runs this code, problem is not this code, but maybe code which will run after
            //Sigabart 2
            
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
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if let loc = userLocation.location {
            if !mapHasCenteredOnce {
                centerMapOnLocation(location: loc)
                mapHasCenteredOnce = true
            }
        }
    }
    
    
//    func createSighting(forLocation location: CLLocation, withToilet key: String) {
//        print("geoFire.setLocation(location, forKey")
//        geoFire.setLocation(location, forKey: "\(key)")
//        
//        
//    }
    
    //    func showSightingsOnMap(location: CLLocation) {
    //        let circleQuery = geoFire!.query(at: location, withRadius: 25)
    //        //If Radius is too big, it might give me breakpoint
    //
    //        _ = circleQuery?.observe(GFEventType.keyEntered, with: { (key, location) in
    //
    //            if let key = key, let location = location {
    //                let anno = ToiletMarkers(coordinate: location.coordinate, ToiletID: Int(key)!)
    //                self.mapView.addAnnotation(anno)
    //            }
    //        })
    //    }
    
//    func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutableRawPointer) {
//        
//        print("HELLO")
//        if (self.mapView.showsUserLocation && self.mapView.userLocation.location != nil) {
//            
//            let span = MKCoordinateSpanMake(0.0125, 0.0125)
//            let region = MKCoordinateRegion(center: (self.mapView.userLocation.location?.coordinate)!, span: span)
//            self.mapView.setRegion(region, animated: true)
//            print("HEYYYYY2")
//            
//            if regionQuery == nil {
//                regionQuery = geoFire?.query(with: region)
//                print("regionQuery is nil")
//                
//                regionQuery!.observe(.keyEntered, with: { (key: String?, location: CLLocation?) in
//                    print("Key '\(key)' entered the search area and is at location '\(location)'")
//                    let annotation = ToiletMarkers(key: key!)
//                    annotation.coordinate = (location?.coordinate)!
//                    self.mapView.addAnnotation(annotation)
//                    self.annotations[key!] = annotation
//                })
//                
//                
//                
//                
//            }
//        }
//        regionQuery!.observe(.keyExited, with: { (key: String?, location: CLLocation?) -> Void in
//            self.mapView.removeAnnotation(self.annotations[key!]!)
//            self.annotations[key!] = nil
//        })
//        
//    }
    func getNearbyTrucks(){
        //Query GeoFire for nearby users
        //Set up query parameters
        let center = CLLocation(latitude: 37.331469, longitude: -122.029825)
        let circleQuery = geoFire.query(at: center, withRadius: 100)
        
        circleQuery?.observe(.keyEntered, with: { (key: String?, coordinate: CLLocation?) in
            
            self.nearbyTrucks = []
            let newTruck = ToiletMarkers(key: (key?)!)
            newTruck.key = key!
            newTruck.coordinate = coordinate!
            self.nearbyTrucks.append(newTruck)
            
            print((nearbyTrucks[0] as AnyObject).id)
        }) //End truckQuery
        
        //Execute code once GeoFire is done with its' query!
        circleQuery?.observeReady({
            
            for truck in self.nearbyTrucks{
                
                ref.childByAppendingPath("users/\(truck.id)").observeEventType(.Value, withBlock: { snapshot in
                    print(snapshot.value["name"] as! String)
                    
                    truck.name = snapshot.value["name"] as! String
                    truck.description = snapshot.value["selfDescription"] as! String
                    let base64String = snapshot.value["profileImage"] as! String
                    let decodedData = NSData(base64EncodedString: base64String as String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                    truck.photo = UIImage(data: decodedData!)!
                })
            }
            
        }) //End observeReadyWithBlock
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool)
    {
        
        //        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        //        showSightingsOnMap(location: loc)
    }
}

