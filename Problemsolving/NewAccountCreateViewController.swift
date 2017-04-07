//
//  NewAccountCreateViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 7/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit

class NewAccountCreateViewController: UIViewController {

    
    @IBOutlet weak var createAccountOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
        createAccountOutlet.layer.cornerRadius = 7.0
        createAccountOutlet.layer.shadowRadius = 2.0
        createAccountOutlet.layer.backgroundColor = primaryColor.cgColor
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createNewAccountTapped(_ sender: Any) {
        print("Create New Account Tapped")
        self.performSegue(withIdentifier:"goToMapFromNewAccountSegue", sender: nil)
        
    }
    

    @IBAction func buttonForgetButtonTapped(_ sender: Any) {
        print("Forget Tapped")
    }
    
    @IBAction func buttonReadServiceTapped(_ sender: Any) {
        print("Service Tapped")
    }
    
    @IBAction func buttonPrivacyTapped(_ sender: Any) {
        print("Privacy Tapped")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        print("BackBUtton Tapped")
         self.performSegue(withIdentifier:"backToFirstViewSegue", sender: nil)

        
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
