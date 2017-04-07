//
//  NewStartLoginViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 6/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class NewStartLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var buttonLoginOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("NewStartLoginViewController loaded")
        
        let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
        buttonLoginOutlet.layer.cornerRadius = 7.0
        buttonLoginOutlet.layer.shadowRadius = 2.0
        
        buttonLoginOutlet.layer.backgroundColor = primaryColor.cgColor

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewStartLoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

        
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonLoginActionStart(_ sender: UIButton) {
        print("Start userLogin()")
        userLogin()
        
        //performSegue(withIdentifier:"moveLoginViewToMapSegue", sender: nil)

        
    }
    
    func userLogin(){
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                
                switch errCode {
                case .errorCodeInvalidEmail:
                    print("invalid email")
                case .errorCodeEmailAlreadyInUse:
                    print("in use")
                default:
                    print("Create User Error: \(error)")
                }    
            } else {
                print("We signed in successfully")
                //FIRDatabase.database().reference().child("users").child(user!.uid).setValue(user!.email!)
                self.performSegue(withIdentifier:"moveLoginViewToMapSegue", sender: nil)
                
            }
        
     
        
        })}
    
    
    @IBAction func buttonForgetPasswordAction(_ sender: Any) {
        print("button Forget")
    }
    
    
    @IBAction func readServicePolicyButtonAction(_ sender: Any) {
         print("button Service")
    }
    
    @IBAction func buttonReadPrivacyAction(_ sender: Any) {
         print("button Privacy")
    }
    
    @IBAction func backToFirstTimeViewTapped(_ sender: Any) {
        self.performSegue(withIdentifier:"backToFirstTimeViewSegue", sender: nil)
        
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
