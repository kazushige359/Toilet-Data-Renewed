//
//  AccountTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 24/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AccountTableViewController: UITableViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var helpedPeopleLabel: UILabel!
    
    var firebaseRef = FIRDatabase.database().reference()
    var filter = Filter()
    var search = Search()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userImageView.sd_setImage(with: URL(string:"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fdefault%20picture.png?alt=media&token=b407a188-5a9d-4b0f-8b43-3bf6c2060573"))
        
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = 50.0
        let myColor : UIColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.3)
        userImageView.layer.borderColor = myColor.cgColor
        userImageView.layer.borderWidth = 3
        
        userInfo()
       
    }
    
    func userInfo(){
     let userRef = firebaseRef.child("Users").child(FIRAuth.auth()!.currentUser!.uid)
        userRef.observe(FIRDataEventType.value, with: {(snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            let userName = snapshotValue?["userName"] as? String
            self.userNameLabel.text = userName
            
            let userPhoto = snapshotValue?["userPhoto"] as? String
            self.userImageView.sd_setImage(with: URL(string:userPhoto!))
            
            let totalLikedCount = snapshotValue?["totalLikedCount"] as? Int
            self.likeCountLabel.text = "\(totalLikedCount!)"
            
            let totalHelpedCount = snapshotValue?["totalHelpedCount"] as? Int
            self.helpedPeopleLabel.text = "\(totalHelpedCount!)"
            
            let totalFavoriteCount = snapshotValue?["totalFavoriteCount"] as? Int
            self.favoriteCountLabel.text = "\(totalFavoriteCount!)"
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("indexPath.row == 0")
            self.performSegue(withIdentifier: "acTVtoAddSegue", sender: nil)

        }
        if indexPath.row == 1 {
            print("indexPath.row == 1")
            self.performSegue(withIdentifier: "acTVtoFVSegue", sender: nil)
        }
        
        if indexPath.row == 2 {
            print("indexPath.row == 2")
            self.performSegue(withIdentifier: "acTVtoYoubeenSegue", sender: nil)
        }
        
        if indexPath.row == 3 {
            print("indexPath.row == 3")
            self.performSegue(withIdentifier:"acTVtoPostedListSegue", sender: nil)
        }
}
  
    @IBAction func mapButtonTapped(_ sender: Any) {
        print("mapButtonTapped")
        self.performSegue(withIdentifier:"acTVtoMapSegue", sender: nil)
    }
    
    @IBAction func settingButtonTapped(_ sender: Any) {
         self.performSegue(withIdentifier:"acTVtoSettingSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "acTVtoMapSegue"{
            let nextVC = segue.destination as! MapViewController
            nextVC.filter = filter
            nextVC.search = search
        }
    }

}
