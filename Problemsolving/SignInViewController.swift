//
//  SignInViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 21/11/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase


class SignInViewController: UIViewController {
    
    var errorMessage: UILabel!
    var errorMessage2: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorMessage = UILabel()
        errorMessage.text = "That's not right password. Sorry!"
        print("That's not right password. Sorry!")
        errorMessage.font = UIFont.systemFont(ofSize: 10)
        errorMessage.sizeToFit()
        errorMessage.center = CGPoint(x:160 ,y:250)
        errorMessage.isHidden = true
        view.addSubview(errorMessage)
        
        errorMessage2 = UILabel()
        errorMessage2.text = "Created User successfully!"
        print("Created User successfully!")
        errorMessage2.font = UIFont.systemFont(ofSize: 10)
        errorMessage2.sizeToFit()
        errorMessage2.center = CGPoint(x:160 ,y:250)
        errorMessage2.isHidden = true
        view.addSubview(errorMessage2)
        
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("Hey we have an error : \(String(describing: error))")
                self.errorMessage.isHidden = false
            } else { print("We signed in successfully")
                FIRDatabase.database().reference().child("users").child(user!.uid).child("userName").setValue(user!.email!)
                
                self.performSegue(withIdentifier: "signinsegue", sender: nil)}
        })}
    
    @IBAction func createAccountTapped(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
            print("We tried to create a user")
            
            if error != nil {
                print("Hey we have an error:\(String(describing: error))")
            } else {
                self.errorMessage2.isHidden = false
                print("Created User successfully!")
                
                let userRef = FIRDatabase.database().reference().child("users").child(user!.uid)
                let data : [String : Any] = ["userName":user!.email!,"userPhoto": "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fdefault%20picture.png?alt=media&token=b407a188-5a9d-4b0f-8b43-3bf6c2060573","email":user!.email!,"totalLikedCount":0,"totalHelpedCount":0, "totalFavoriteCount":0
                ]
                
                userRef.setValue(data)
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        }
        )
    }
}

