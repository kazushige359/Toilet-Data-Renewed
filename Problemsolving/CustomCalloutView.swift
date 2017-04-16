//
//  CustomCalloutView.swift
//  Problemsolving
//
//  Created by 重信和宏 on 15/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import Cosmos

class CustomCalloutView: UIView {

    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var placeType: UILabel!
    
    
    @IBOutlet weak var availableWaitAndDistanceLabel: UILabel!
    
    
    @IBOutlet weak var lookDetailLabel: UILabel!
    
    
    @IBOutlet weak var starImage: CosmosView!
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    var key = String()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
