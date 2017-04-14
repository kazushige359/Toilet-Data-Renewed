//
//  ReviewTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 14/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Cosmos


class ReviewTableViewController: UITableViewController {

    
    var reviews: [Review] = []
    var toilet = Toilet()
    var review = Review()
    var reviewsSet = Set<String>()
    var likedSet = Set<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return reviews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ReviewTableViewCell", owner: self, options: nil)?.first as! ReviewTableViewCell
        
        cell.feedbackTextView.backgroundColor = UIColor.white
        cell.feedbackTextView.isUserInteractionEnabled = false
        
        cell.userPhotoImage.sd_setImage(with: URL(string: reviews[indexPath.row].userPhoto))
        cell.userPhotoImage.layer.masksToBounds = true
        cell.userPhotoImage.layer.cornerRadius = 25.5
        ////////////// 5 to 25.5
        
        let myColor : UIColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.1)
        cell.userPhotoImage.layer.borderColor = myColor.cgColor
        cell.userPhotoImage.layer.borderWidth = 1
        cell.starRatedLabel.rating = reviews[indexPath.row].star
        cell.feedbackTextView.text = reviews[indexPath.row].feedback
        cell.userNameLabel.text = reviews[indexPath.row].userName
        cell.dateLabel.text = reviews[indexPath.row].time
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.likedCountLabel.text = "いいね\(reviews[indexPath.row].likedCount)件"
        cell.nextLikedCountLabel.isHidden = true
        cell.nextUserLikedCount.isHidden = true
        cell.userFavoritedCount.text = "\(reviews[indexPath.row].totalFavoriteCount)"
        cell.userHelpedCount.text = "\(reviews[indexPath.row].totalHelpedCount)"
        cell.userLikedCount.text = "\(reviews[indexPath.row].totalLikedCount)"
        
        cell.starRatedLabel.settings.filledColor = UIColor.yellow
        cell.starRatedLabel.settings.emptyBorderColor = UIColor.orange
        cell.starRatedLabel.settings.filledBorderColor = UIColor.orange
        
        
        cell.likeButton.addTarget(self, action: #selector(DetailViewController.buttonClicked), for: .touchUpInside)
        
        if reviews[indexPath.row].userLiked == true {
            cell.likeButton.setImage(UIImage(named: "like1"), for: UIControlState.normal)
            let nextNumber = reviews[indexPath.row].likedCount - 1
            let nextLikedNumber = reviews[indexPath.row].totalLikedCount - 1
            cell.nextLikedCountLabel.text = "いいね\(nextNumber)件"
            cell.nextUserLikedCount.text = "\(nextLikedNumber)"
        } else{
            let nextNumber = reviews[indexPath.row].likedCount + 1
            let nextLikedNumber = reviews[indexPath.row].totalLikedCount + 1
            cell.nextLikedCountLabel.text = "いいね\(nextNumber)件"
            cell.nextUserLikedCount.text = "\(nextLikedNumber)"
        }
        
        if reviews[indexPath.row].waitingtime == "0"{
            cell.waitingMinuteLabel.text = "待ちなし"
        }else {
            let waitminutes = "\(reviews[indexPath.row].waitingtime)分待ち"
            cell.waitingMinuteLabel.text = waitminutes}
        return cell
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    func reviewQuery(){
        
        print("review Query Called")
        
        let reviewsRef = FIRDatabase.database().reference().child("reviews")
        
        reviewsRef.queryOrdered(byChild: "tid").queryEqual(toValue: toilet.key).observe(.childAdded, with: { snapshot in
            //if self.firebaseLoadedOnce == false
            //{
                print("snapshot = \(snapshot)")
                print("snapshot.key = \(snapshot.key)")
                print("snapshot.value = \(String(describing: snapshot.value))")
                let review = Review()
                
                let snapshotValue = snapshot.value as? NSDictionary
                
                let star = snapshotValue?["star"] as? String
                print("star = \(String(describing: star))!!!")
                review.star = Double(star!)!
                let feedback = snapshotValue?["feedback"] as? String
                review.feedback = feedback!
                
                let time = snapshotValue?["time"] as? String
                review.time = time!
                print("review.time = \(review.time)")
                
                let waitingtime = snapshotValue?["waitingtime"] as? String
                review.waitingtime = waitingtime!
                
                let timeNumbers = snapshotValue?["timeNumbers"] as? Double
                review.timeNumbers = timeNumbers!
                
                let likedCount = snapshotValue?["likedCount"] as? Int
                review.likedCount = likedCount!
                
                let uid = snapshotValue?["uid"] as? String
                review.uid = uid!
                
                review.rid = snapshot.key
                
                if self.likedSet.contains(review.rid){
                    print("self.likedSet.contains(review.rid)")
                    review.userLiked = true
                }
                
                
                let userRef = FIRDatabase.database().reference().child("users")
                userRef.child(uid!).queryOrderedByKey().observe(FIRDataEventType.value, with: {(snapshot) in
                    //if self.firebaseLoadedOnce == false
                    //{
                        print("userRef.child(uid!).observe(.childAdded, with: { snapshot in")
                        print("snapshot = \(snapshot)")
                        
                        let snapshotValue = snapshot.value as? NSDictionary
                        
                        let userName = snapshotValue?["userName"] as? String
                        review.userName = userName!
                        print("review.userName = \(review.userName)")
                        
                        let userPhoto = snapshotValue?["userPhoto"] as? String
                        review.userPhoto = userPhoto!
                        print("review.userPhoto = \(review.userPhoto)")
                        
                        let totalFavoriteCount = snapshotValue?["totalFavoriteCount"] as? Int
                        review.totalFavoriteCount = totalFavoriteCount!
                        
                        let totalHelpedCount = snapshotValue?["totalHelpedCount"] as? Int
                        review.totalHelpedCount = totalHelpedCount!
                        
                        let totalLikedCount = snapshotValue?["totalLikedCount"] as? Int
                        review.totalLikedCount = totalLikedCount!
                        
                        self.reviews.append(review)
                        self.reviewsSet.insert(snapshot.key)
                        self.reviews.sort(){$0.timeNumbers > $1.timeNumbers}
                        self.tableView.reloadData()
                        
                        print("review Query End")
                        
                        //I moved codes above here because review tableview could not be loaded 26th
                        //when the value is changed, tableveiw loads again and again
                    }
        //}
        )}
    //    }
    )
    }

    
    func likedQuery(){
        
        print("liked Query Called")
        let youLikedRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("youLiked")
        youLikedRef.observe(FIRDataEventType.childAdded, with: {(snapshot) in
            self.likedSet.insert(snapshot.key)
            print("likedSet = \(self.likedSet)")
            print("liked Query End")
            
        })
        
    }


   
    
    
    
}
