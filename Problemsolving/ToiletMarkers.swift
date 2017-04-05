//
//  ToiletMarkers.swift
//  
//
//  Created by 重信和宏 on 12/12/16.
//
//

import UIKit



class ToiletMarkers: NSObject, MKAnnotation{

    var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(key: String){
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        self.key = key
        
    }
}

