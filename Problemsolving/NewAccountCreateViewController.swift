//
//  NewAccountCreateViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 7/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase




class NewAccountCreateViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    
    @IBOutlet weak var createAccountOutlet: UIButton!
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
        createAccountOutlet.layer.cornerRadius = 7.0
        createAccountOutlet.layer.shadowRadius = 2.0
        createAccountOutlet.layer.backgroundColor = primaryColor.cgColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewAccountCreateViewController.dismissKeyboard))
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
    
    
    @IBAction func createNewAccountTapped(_ sender: Any) {
        print("Create New Account Tapped")
        createAccount()
        progressBarDisplayer(msg: "アカウントを作成", true)
    }
    
    func createAccount(){
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                
                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                   self.messageFrame.removeFromSuperview()
                    
                    switch errCode {
                    case .errorCodeInvalidEmail:
                        self.firebaseNewAccountError(errorMessage: "メールアドレスに誤りがあります。")
 
                    case .errorCodeEmailAlreadyInUse:
                         self.firebaseNewAccountError(errorMessage: "入力されたメールアドレスはすでに使われております。")
                       
                    default:
                        self.firebaseNewAccountError(errorMessage: "入力された情報に誤りがあります。")
                    }
                }
                
            } else {
                print("all good... continue")
                
                let userPrivateData : [String : Any] = [
                "password": self.passwordTextField.text! as String,
                "userEmail": self.emailTextField.text! as String,
                ]

                
                let userData : [String : Any] = [
                    "userName": self.userNameTextField.text! as String,
                    "userPhoto": "",
                    "totalLikedCount": 0,
                    "totalHelpedCount": 0,
                    "totalFavoriteCount": 0
                ]
                let firebaseRef = FIRDatabase.database().reference()
                
                let mutipleData = ["UserPrivateInfo/\(user!.uid)": userPrivateData,
                                   "Users/\(user!.uid)": userData,
                                    ] as [String : Any]
                
                firebaseRef.updateChildValues(mutipleData, withCompletionBlock: { (error, FIRDatabaseReference) in if error != nil{
                        print("Error = \(String(describing: error))")
                        
                    }else{
                        //Success
                        
                    }
                })

                //FIRDatabase.database().reference().child("Users").child(user!.uid).setValue(userData)
                self.messageFrame.removeFromSuperview()
                self.performSegue(withIdentifier:"goToMapFromNewAccountSegue", sender: nil)
                

                
            }
        }
    }
    func firebaseNewAccountError(errorMessage: String){
        
    let alertController = UIAlertController (title: "エラー", message: errorMessage, preferredStyle: .alert)
    //Changed to action Sheet
    
    let errorGot = UIAlertAction(title: "了解", style: .default, handler: nil)
    alertController.addAction(errorGot)
    
    self.present(alertController, animated: true, completion: nil)
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

    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
