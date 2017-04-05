//
//  AccountViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 28/12/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AccountViewController: UIViewController {
    
    @IBOutlet weak var userPicture: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var addToiletButton: UIButton!
    
    @IBOutlet weak var favoriteToiletButton: UIButton!
    
    @IBOutlet weak var toiletBeforeButton: UIButton!
    
    @IBOutlet weak var toiletYouAddedButton: UIButton!
    
    var firebaseRef = FIRDatabase.database().reference()
    var filter = Filter()
    var search = Search()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).child("userPhoto").queryOrderedByKey().observe(FIRDataEventType.value, with: { snapshot in
            //g to l at 2pm 20th
           
            print("snapshot = \(snapshot)")
            if snapshot.value == nil{
                self.userPicture.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fdefault%20picture.png?alt=media&token=b407a188-5a9d-4b0f-8b43-3bf6c2060573"))
                
            }else{
            self.userPicture.sd_setImage(with: URL(string:snapshot.value as! String))
            }
//            if snapshot.value == nil{
//                 self.userPicture.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fdefault%20picture.png?alt=media&token=b407a188-5a9d-4b0f-8b43-3bf6c2060573"))
//            
//            }
        })
    
        
        
//        userPicture.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fme.jpg?alt=media&token=2ed9d37d-4f22-4c58-9df8-60abc0663aae"))
        userPicture.layer.masksToBounds = true
        userPicture.layer.cornerRadius = 75.0
        let myColor : UIColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.3)
        userPicture.layer.borderColor = myColor.cgColor
        userPicture.layer.borderWidth = 3
        //userPicture.layer.borderColor = UIColor.white
        
        

        addToiletButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        favoriteToiletButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        toiletBeforeButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        toiletYouAddedButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func addToiletButtonTapped(_ sender: Any) {
         self.performSegue(withIdentifier: "acToaddpinSegue", sender: nil)
    }
    @IBAction func favoriteToiletButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "FavoriteSegue", sender: nil)
        
        
        
    }
    @IBAction func toiletyouwentTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "YouWentSegue", sender: nil)
    }
    
    @IBAction func toiletsyouaddedButton(_ sender: Any) {
    }
    
    @IBAction func settingButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "SettingSegue", sender: nil)
        print("settingBUttonnnn")
    }
    
    @IBAction func mapButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "actomapSegue", sender: nil)
        print("mapButtonTapped")
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "actomapSegue"{
            let nextVC = segue.destination as! MapViewController
            nextVC.filter = filter
            nextVC.search = search
        }
    }
   
  

}
