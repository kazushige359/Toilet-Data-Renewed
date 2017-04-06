//
//  StartLoginUserViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 6/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit

class StartLoginUserViewController: UIViewController {

    
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    
    @IBOutlet weak var buttonLoginOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
//        
//        let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
        
        
        
        

        buttonLoginOutlet.layer.cornerRadius = 7.0
        buttonLoginOutlet.layer.shadowRadius = 2.0
        
        buttonLoginOutlet.layer.backgroundColor = primaryColor.cgColor
        
        //buttonLoginOutlet.backgroundColor = primaryColor.cgColor
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonLoginAction(_ sender: Any) {
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
