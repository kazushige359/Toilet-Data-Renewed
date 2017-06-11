//
//  UserPrivateAccountViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 7/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class UserPrivateAccountViewController: UIViewController {

    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var helpedCountLabel: UILabel!
    
    @IBOutlet weak var buttonAddToiletOutlet: UIButton!
    
    
    @IBOutlet weak var buttonFavoriteListOutlet: UIButton!
    
    
    @IBOutlet weak var buttonYouHaveBeenOutlet: UIButton!
    
    @IBOutlet weak var buttonPostedKansou: UIButton!
    
    
    var firebaseRef = FIRDatabase.database().reference()
    var filter = Filter()
    var search = Search()
    
    var userAlreadyLogin = false
    
    let currentUserId = FIRAuth.auth()?.currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
        
//        self.userImageView.sd_setImage(with: URL(string:"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fdefault%20picture.png?alt=media&token=b407a188-5a9d-4b0f-8b43-3bf6c2060573"))
        
//        userImageView.layer.masksToBounds = true
//        userImageView.layer.cornerRadius = 40.0
        let myColor : UIColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.3)
        userImageView.layer.borderColor = myColor.cgColor
        userImageView.layer.borderWidth = 2
        
        
        buttonAddToiletOutlet.layer.cornerRadius = 7.0
        buttonAddToiletOutlet.layer.shadowRadius = 2.0
        buttonAddToiletOutlet.layer.backgroundColor = primaryColor.cgColor
        
        buttonFavoriteListOutlet.layer.cornerRadius = 7.0
        buttonFavoriteListOutlet.layer.shadowRadius = 2.0
        buttonFavoriteListOutlet.layer.backgroundColor = primaryColor.cgColor
        
        buttonYouHaveBeenOutlet.layer.cornerRadius = 7.0
        buttonYouHaveBeenOutlet.layer.shadowRadius = 2.0
        buttonYouHaveBeenOutlet.layer.backgroundColor = primaryColor.cgColor
        
        buttonPostedKansou.layer.cornerRadius = 7.0
        buttonPostedKansou.layer.shadowRadius = 2.0
        buttonPostedKansou.layer.backgroundColor = primaryColor.cgColor
        
        
        
        userLoginCheck()
        
        userImageView.isUserInteractionEnabled = true
        
        let userPictureTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserPrivateAccountViewController.imageTappedAction(_:)))
        userImageView.addGestureRecognizer(userPictureTap)
        
        
        //userInfo()
        
        
//        print("PassingData.sharedInstance.welcomeMessage = \(PassingData.sharedInstance.welcomeMessage)")
//         print("PassingData.sharedInstance.filterOn = \(PassingData.sharedInstance.filterOn)")

        
        
    }
    
    func userLoginCheck(){
    
        let userRef = firebaseRef.child("Users")
        
        userRef.child(currentUserId!).observe(.value, with: { snapshot in
                
                if ( snapshot.value is NSNull ) {
                    print("(User did not found)")
                    
                } else {
                    print(snapshot.value!)
                    print("User Find")
                    self.userInfo()
                    self.userAlreadyLogin = true
                }
        })
        
    
    
    }
    
    func userInfo(){
        let userRef = firebaseRef.child("Users").child(FIRAuth.auth()!.currentUser!.uid)
        userRef.observe(FIRDataEventType.value, with: {(snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            let userName = snapshotValue?["userName"] as? String
            self.userNameLabel.text = userName
            
            let userPhoto = snapshotValue?["userPhoto"] as? String
            
            if userPhoto != ""{
            self.userImageView.sd_setImage(with: URL(string:userPhoto!))
            }
            
            let totalLikedCount = snapshotValue?["totalLikedCount"] as? Int
            self.likeCountLabel.text = "\(totalLikedCount!)"
            
            let totalHelpedCount = snapshotValue?["totalHelpedCount"] as? Int
            self.helpedCountLabel.text = "\(totalHelpedCount!)"
            
            let totalFavoriteCount = snapshotValue?["totalFavoriteCount"] as? Int
            self.favoriteCountLabel.text = "\(totalFavoriteCount!)"
        })
    }
    
    
//    
//    @IBAction func mapButtonTapped(_ sender: Any) {
//        print("mapButtonTapped")
//        self.performSegue(withIdentifier:"acTVtoMapSegue", sender: nil)
//    }
//    
//    @IBAction func settingButtonTapped(_ sender: Any) {
//        self.performSegue(withIdentifier:"acTVtoSettingSegue", sender: nil)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "acTVtoMapSegue"{
//            let nextVC = segue.destination as! MapViewController
//            nextVC.filter = filter
//            nextVC.search = search
//        }
//    }
    
    
    func imageTappedAction(_ sender: UITapGestureRecognizer) {
        print("Image Tapped Action Called 333")
        
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = UIColor.groupTableViewBackground
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "newAcaddToiletSegue"{
//            
//            let nextVC = segue.destination as! AddPinViewController
//            
//            //nextVC.toilet = toilet
//            nextVC.filter = filter
//            nextVC.search = search
//        }
        
        
        if segue.identifier == "newAcToFavoriteList"{
            
            let nextVC = segue.destination as! FavoriteTableViewController
            
            //nextVC.toilet = toilet
            nextVC.filter = filter
            nextVC.search = search
        }
        
        if segue.identifier == "youHaveBeenSegue"{
            
            let nextVC = segue.destination as! YouWentTableViewController
            
            //nextVC.toilet = toilet
            nextVC.filter = filter
            nextVC.search = search
        }
        
        if segue.identifier == "newAcToYouHaveAddSegue"{
            
            let nextVC = segue.destination as! PostedTableViewController
            
            nextVC.filter = filter
            nextVC.search = search
        }
//
//        if segue.identifier == "youHaveBeenSegue"{
//            
//            let nextVC = segue.destination as! YouWentTableViewController
//            
//            //nextVC.toilet = toilet
//            nextVC.filter = filter
//            nextVC.search = search
//        }
//        
//        if segue.identifier == "youHaveBeenSegue"{
//            
//            let nextVC = segue.destination as! YouWentTableViewController
//            
//            //nextVC.toilet = toilet
//            nextVC.filter = filter
//            nextVC.search = search
//        }
    }
    
        
    func showPleaseLogin(){
        let alertController = UIAlertController (title: "pleaseLoginMyPage".localized, message: "", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "login".localized, style: .default) { (_) -> Void in
            
            print("Move to first time view controller")
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UserFirstTimeViewController") as! UserFirstTimeViewController
            //self.(vc, sender: self)
            print("Move to first time view controller Over")
            self.present(vc, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "ignoreLogin".localized, style: .default, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

    
    
    }
    
    @IBAction func buttonAddToiletTapped(_ sender: Any) {
        if userAlreadyLogin == true{
        self.performSegue(withIdentifier: "newAcaddToiletSegue", sender: nil)
        } else{
        
            showPleaseLogin()
        }
        
    }
    
    @IBAction func buttonFavoriteListTapped(_ sender: Any) {
        if userAlreadyLogin == true{
        self.performSegue(withIdentifier: "newAcToFavoriteList", sender: nil)
        }else{
            showPleaseLogin()
                
            }
        
    }
    
    @IBAction func buttonYouWentList(_ sender: Any) {
        if userAlreadyLogin == true{
        self.performSegue(withIdentifier: "youHaveBeenSegue", sender: nil)
    }else{
    showPleaseLogin()
    
    }
    
    
    }

    @IBAction func buttonYourKansouTapped(_ sender: Any) {
        if userAlreadyLogin == true{
             self.performSegue(withIdentifier: "newAcToYouHaveAddSegue", sender: nil)
        }else{
            showPleaseLogin()
            
        }
       
        
    }
    
    @IBAction func buttonBackToMapTapped(_ sender: Any) {
        
        
            self.performSegue(withIdentifier: "userAccountBackToMapSegue", sender: nil)
        
        
            
        
        
        
        
    }
    
    @IBAction func buttonSettingTapped(_ sender: Any) {
        if userAlreadyLogin == true{
             self.performSegue(withIdentifier: "userAccountToSettingSegue", sender: nil)
            
        }else{
            showPleaseLogin()
            
        }

       
        
    }
    
    
    

    
}
