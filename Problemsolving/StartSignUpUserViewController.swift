//
//  StartSignUpUserViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 6/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class StartSignUpUserViewController: UIViewController
//, UITextFieldDelegate
{

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var buttonSignUpOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("Sign uP View load")
        let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
        
        
        
//        emailTextField.delegate = self
//        passwordTextField.delegate = self
//        userNameTextField.delegate = self
//        
        buttonSignUpOutlet.layer.cornerRadius = 7.0
        buttonSignUpOutlet.layer.shadowRadius = 2.0
        buttonSignUpOutlet.layer.backgroundColor = primaryColor.cgColor
        
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StartSignUpUserViewController.dismissKeyboard))
//        
//        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
//        //tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
        

        

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("text Return Called")
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        print("dismiss keyboardCalled")

        view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userSignUp(){
        
        print("User Sign UP Called")
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("Hey we have an error : \(error)")
            } else { print("We signed in successfully")
                let userData : [String : Any] = [
                    "userName": self.userNameTextField.text! as String,
                    "password": self.passwordTextField.text! as String,
                    "userPhoto": "",
                    "userEmail": self.emailTextField.text! as String,
                    "totalLikedCount": 0,
                    "totalHelpedCount": 0,
                    "totalFavoriteCount": 0
                ]
                FIRDatabase.database().reference().child("users").child(user!.uid).setValue(userData)
                
               // self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        })
        
    
    }
    
    @IBAction func buttonSignUpTapped(_ sender: Any) {
        print("Button Sign up")
        
        
        userSignUp()

    }

    @IBAction func buttonForgetPasswordAction(_ sender: UIButton) {
        print("Button Forget")
        
    }
//    @IBAction func buttonSignUpAction(_ sender: Any) {
//        
//        print("Button Sign up")
//
//        
//        userSignUp()
//    }
//   

}
