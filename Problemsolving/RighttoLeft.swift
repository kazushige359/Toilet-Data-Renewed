//
//  RighttoLeft.swift
//  Problemsolving
//
//  Created by 重信和宏 on 19/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit

class RighttoLeft: UIStoryboardSegue {
    override func perform() {
        print("FirstCustomSegue")
        
        //credits to http://www.appcoda.com/custom-segue-animations/
        
        let firstClassView = self.source.view
        let secondClassView = self.destination.view
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
       
         secondClassView?.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        // CGRect(x: screenWidth (original code)
//        secondClassView?.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight)
        
        if let window = UIApplication.shared.keyWindow {
            
            window.insertSubview(secondClassView!, aboveSubview: firstClassView!)
            
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                //Duration 0.4 to 0.1
                firstClassView?.frame = (firstClassView?.frame.offsetBy(dx: screenWidth, dy: 0))!
                secondClassView?.frame = ((secondClassView?.frame)?.offsetBy(dx: screenWidth, dy: 0))!

//                firstClassView?.frame = (firstClassView?.frame.offsetBy(dx: -screenWidth, dy: 0))!
//                secondClassView?.frame = ((secondClassView?.frame)?.offsetBy(dx: -screenWidth, dy: 0))!
                
            }) {(Finished) -> Void in
                
                self.source.navigationController?.pushViewController(self.destination, animated: false)
                
            }
            
        }
        
    }
}
