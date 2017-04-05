//
//  Pins.swift
//  Problemsolving
//
//  Created by 重信和宏 on 13/12/16.
//  Copyright © 2016 Hiro. All rights reserved.
//


import UIKit

class Pin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(key: String) {
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        self.key = key
    }
    
}
