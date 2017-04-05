//
//  Toilet.poke.swift
//  Problemsolving
//
//  Created by 重信和宏 on 14/12/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import Foundation
import MapKit

class ToiletMarkers: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var pokemonNumber: Int
    var pokemonName: String
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, pokemonNumber: Int) {
        self.coordinate = coordinate
        self.pokemonNumber = pokemonNumber
        self.pokemonName = pokemon[pokemonNumber - 1].capitalized
        self.title = self.pokemonName
    }
}
