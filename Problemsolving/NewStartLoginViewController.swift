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
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("NewStartLoginViewController loaded")
        
        let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
        buttonLoginOutlet.layer.cornerRadius = 7.0
        buttonLoginOutlet.layer.shadowRadius = 2.0
        
        buttonLoginOutlet.layer.backgroundColor = primaryColor.cgColor

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewStartLoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func buttonLoginActionStart(_ sender: UIButton) {
        userLogin()
        progressBarDisplayer(msg:"ログイン中", true)
    }
    
    func userLogin(){
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            self.messageFrame.removeFromSuperview()
            if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                
                switch errCode {
                case .errorCodeInvalidEmail:
                    print("invalid email")
                    self.firebaseLoginErrorShow(errorMessage: "入力されたメールアドレスに誤りがあります")
                default:
                    print("Create User Error: \(String(describing: error))")
                    self.firebaseLoginErrorShow(errorMessage:"入力された情報に誤りがあります")
                    
                }    
            } else {
                print("We signed in successfully")
                self.messageFrame.removeFromSuperview()
                self.performSegue(withIdentifier:"moveLoginViewToMapSegue", sender: nil)
            }
        })}
    
    func firebaseLoginErrorShow(errorMessage: String){
        let alertController = UIAlertController (title: "エラー", message: errorMessage, preferredStyle: .alert)
        let errorGot = UIAlertAction(title: "了解", style: .default, handler: nil)
        alertController.addAction(errorGot)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }

    
    
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
    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        print(msg)
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        //Chagnged x: 50 to 30
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = primaryColor
        //messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)//witdh 50 to 200
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
}
