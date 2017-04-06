//
//  UserStartLoginViewController.swift
//  Pods
//
//  Created by 重信和宏 on 6/4/17.
//
//

import UIKit

class UserStartLoginViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var buttonLoginOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonLoginOutlet.layer.cornerRadius = 7.0
        buttonLoginOutlet.layer.shadowRadius = 2.0
        buttonLoginOutlet.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonLoginAction(_ sender: Any) {
    }

}
