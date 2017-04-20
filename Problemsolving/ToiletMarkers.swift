//
//  ToiletMarkers.swift
//  
//
//  Created by 重信和宏 on 12/12/16.
//
//

import UIKit
import MapKit



class ToiletMarkers: NSObject, MKAnnotation{

    var coordinate: CLLocationCoordinate2D
    var key = ""
    var type = ""
    var name = ""
    var averageStar = ""
    var distance =  ""
    var reviewCount = 1
    var averageWait = 3
    var pinOne = ""
    var pinTwo = ""
    
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
        
    }
    
}

