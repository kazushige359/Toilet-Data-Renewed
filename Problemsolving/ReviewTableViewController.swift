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
    var filter = Filter()
    var search = Search()
    var review = Review()
    var reviewsSet = Set<String>()
    var thumbsUpSet = Set<String>()
    var firebaseLoaded = false
    
    let firebaseRef = FIRDatabase.database().reference()
    let currentUserId = FIRAuth.auth()?.currentUser?.uid
    
    var userAlreadyLogin = false
    let imageColored = UIImage(named:"like_colored_25")
    let imageBlack = UIImage(named:"thumbsUp_black_image_25")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("ReviewTableViewController Loaded")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 255
        
        userLoginCheck()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func userLoginCheck(){
        
        let userRef = firebaseRef.child("Users")
        
        userRef.child(currentUserId!).observe(.value, with: { snapshot in
            
            if ( snapshot.value is NSNull ) {
                print("(User did not found)")
                self.reviewQuery()
               
                
            } else {
                print("User Find")
                self.thumbsUpQuery()

                self.userAlreadyLogin = true
            }
        })
        
    }


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return reviews.count
//    }
    
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
//        cell.nextLikedCountLabel.isHidden = true
//        cell.nextUserLikedCount.isHidden = true
//        cell.userFavoritedCount.text = "\(reviews[indexPath.row].totalFavoriteCount)"
        cell.userHelpedCount.text = "\(reviews[indexPath.row].totalHelpedCount)"
        cell.userLikedCount.text = "\(reviews[indexPath.row].totalLikedCount)"
        
        cell.starRatedLabel.settings.filledColor = UIColor.yellow
        cell.starRatedLabel.settings.emptyBorderColor = UIColor.orange
        cell.starRatedLabel.settings.filledBorderColor = UIColor.orange
        
        cell.likedCountLabel.isHidden = false
        cell.userLikedCount.isHidden = false
        cell.nextLikedCountLabel.isHidden = true
        cell.nextUserLikedCount.isHidden = true
       
        
        
        
        if reviews[indexPath.row].userLiked == true{
         
         cell.likeButton.setImage(imageColored, for: .normal)
            
         
         cell.likeButton.tag = indexPath.row
            
//         reviews[indexPath.row].totalLikedCount = reviews[indexPath.row].totalLikedCount - 1
//         reviews[indexPath.row].likedCount = reviews[indexPath.row].likedCount - 1
            
            
         
         cell.nextUserLikedCount.text = "\(reviews[indexPath.row].totalLikedCount - 1)"
         cell.nextLikedCountLabel.text = "いいね\(reviews[indexPath.row].likedCount - 1)件"
            
         cell.likeButton.addTarget(self, action: #selector(ReviewTableViewController.reviewLikeButtonTapped(sender:)), for: .touchUpInside)
            
        } else{
        
          
            cell.likeButton.setImage(imageBlack, for: .normal)
            
//            reviews[indexPath.row].totalLikedCount = reviews[indexPath.row].totalLikedCount + 1
//             reviews[indexPath.row].likedCount = reviews[indexPath.row].likedCount + 1
            cell.likeButton.tag = indexPath.row
            cell.nextUserLikedCount.text = "\(reviews[indexPath.row].totalLikedCount + 1)"
            cell.nextLikedCountLabel.text = "いいね\(reviews[indexPath.row].likedCount + 1)件"
            
            cell.likeButton.addTarget(self, action: #selector(ReviewTableViewController.reviewLikeButtonTapped(sender:)), for: .touchUpInside)
            
        
        
        }
        
        
//        if reviews[indexPath.row].userLiked == true {
//            cell.likeButton.setImage(UIImage(named: "like1"), for: UIControlState.normal)
//            let nextNumber = reviews[indexPath.row].likedCount - 1
//            let nextLikedNumber = reviews[indexPath.row].totalLikedCount - 1
////            cell.nextLikedCountLabel.text = "いいね\(nextNumber)件"
////            cell.nextUserLikedCount.text = "\(nextLikedNumber)"
//        } else{
//            let nextNumber = reviews[indexPath.row].likedCount + 1
//            let nextLikedNumber = reviews[indexPath.row].totalLikedCount + 1
////            cell.nextLikedCountLabel.text = "いいね\(nextNumber)件"
////            cell.nextUserLikedCount.text = "\(nextLikedNumber)"
//        }
        
        if reviews[indexPath.row].waitingtime == "0"{
            cell.waitingMinuteLabel.text = "待ちなし"
        }else {
            let waitminutes = "\(reviews[indexPath.row].waitingtime)分待ち"
            cell.waitingMinuteLabel.text = waitminutes}
        return cell
    }

    
    func reviewLikeButtonTapped(sender: UIButton) {
        
        let buttonRow = sender.tag
        print("ButtonRow = \(buttonRow)")
        self.firebaseLoaded = true
        
       // let a = reviews[buttonRow].likedCount
//        var totalUserThumbsUpCount = reviews[buttonRow].totalLikedCount
//        var reviewLikeCount = reviews[buttonRow].likedCount
        
        
        print("reviews[buttonRow].rid = \(reviews[buttonRow].rid)")
       // print("reviews[buttonRow].likedCount = \(a)")
        
        let thumbsUpRef = FIRDatabase.database().reference().child("ThumbsUpList").child(FIRAuth.auth()!.currentUser!.uid)
        let userRef = FIRDatabase.database().reference().child("Users").child(reviews[buttonRow].uid)
        let reviewInfoRef = FIRDatabase.database().reference().child("ReviewInfo").child(reviews[buttonRow].rid)
        
        if userAlreadyLogin == false{
            //showPleaseLogin()
            
        }else{
            
            if reviews[buttonRow].userLiked == false{
                
                               //Tap

               sender.setImage(imageColored, for: .normal)
               reviews[buttonRow].userLiked = true
                
                
                
                
                
                

               // reviews[buttonRow].userLiked = true
                
//                let totalUserThumbsUpCount = reviews[buttonRow].totalLikedCount
//                let reviewLikeCount = reviews[buttonRow].likedCount
                
                
                
                
//.............
                let totalUserThumbsUpCount = reviews[buttonRow].totalLikedCount + 1
                let reviewLikeCount = reviews[buttonRow].likedCount + 1
                thumbsUpRef.child(reviews[buttonRow].rid).setValue(true)
                self.thumbsUpSet.insert(reviews[buttonRow].rid)
                let userInfoUpdate: [String : Any] = ["totalLikedCount": totalUserThumbsUpCount]
                userRef.updateChildValues(userInfoUpdate)
                
                let reviewInfoUpdate: [String : Any] = ["likedCount": reviewLikeCount]
                reviewInfoRef.updateChildValues(reviewInfoUpdate)
//............. April 24
                
                

                
                
                
//                
//                (sender as AnyObject).setImage(imageColored, for: .normal)
//                self.reviewTwoLikeAlreadyTapped = true
//                
              
//
//                self.reviewTwoUserTotalLikeOriginalCount = self.reviewTwoUserTotalLikeOriginalCount + 1
//                self.reviewTwoThumbOriginalCount = self.reviewTwoThumbOriginalCount + 1
//
//                
                
//                self.reviewTwoUserLikeCount.text = String(totalUserThumbsUpCount)
//                self.reviewTwoThumbUpCountLabel.text = "いいね" + String(self.reviewTwoThumbOriginalCount) + "件"
//
//                
//                //update firebase data
//                
//                
//                
              //
//                
          }else{
                
               // sender.setImage(imageBlack, for: .normal)
                //reviews[buttonRow].userLiked = false

//                
//                
//                UnTap
//                
//                self.reviewTwoUserTotalLikeOriginalCount = self.reviewTwoUserTotalLikeOriginalCount - 1
//                self.reviewTwoThumbOriginalCount = self.reviewTwoThumbOriginalCount - 1
//                
                sender.setImage(imageBlack, for: .normal)
                reviews[buttonRow].userLiked = false
                
                let totalUserThumbsUpCount = reviews[buttonRow].totalLikedCount - 1
                let reviewLikeCount = reviews[buttonRow].likedCount - 1
                
                thumbsUpRef.child(reviews[buttonRow].rid).removeValue()
                self.thumbsUpSet.remove(reviews[buttonRow].rid)
                //self.thumbsUpSet.insert(reviews[buttonRow].rid)
                
                let userInfoUpdate: [String : Any] = ["totalLikedCount": totalUserThumbsUpCount]
                userRef.updateChildValues(userInfoUpdate)
                
                let reviewInfoUpdate: [String : Any] = ["likedCount": reviewLikeCount]
                reviewInfoRef.updateChildValues(reviewInfoUpdate)

//                
//                thumbsUpRef.child(self.toilet.reviewTwo).removeValue()
//                
//                self.reviewTwoUserLikeCount.text = String(self.reviewTwoUserTotalLikeOriginalCount)
//                self.reviewTwoThumbUpCountLabel.text = "いいね" + String(self.reviewTwoThumbOriginalCount) + "件"
//                
//                let userInfoUpdate: [String : Any] = ["totalLikedCount": self.reviewTwoUserTotalLikeOriginalCount]
//                userRef.updateChildValues(userInfoUpdate)
//                
//                let reviewInfoUpdate: [String : Any] = ["likedCount": self.reviewTwoThumbOriginalCount]
//                reviewInfoRef.updateChildValues(reviewInfoUpdate)
//                
//                self.reviewTwoLikeAlreadyTapped = false
//                
           }
            
        }
    }


//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 255
//        
//    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviews.count
    }
    
    
    
    func reviewQuery(){
        
        print("review Query TV Called")
        
       // let reviewsRef = FIRDatabase.database().reference().child("ReviewInfo")
        
        let toiletReviewsRef = FIRDatabase.database().reference().child("ToiletReviews").child(toilet.key)
        
        let reviewsRef = FIRDatabase.database().reference().child("ReviewInfo")
        toiletReviewsRef.observe(.childAdded, with: { snapshot in
            
            //get rid key 
            
            
            
            let ridKey = snapshot.key
            
            reviewsRef.child(ridKey).observe(FIRDataEventType.value, with: { snapshot in
                
                if self.firebaseLoaded == false{
               
        
//        reviewsRef.queryOrdered(byChild: "tid").queryEqual(toValue: toilet.key).observe(.childAdded, with: { snapshot in
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
                
               
                
                
                let userRef = FIRDatabase.database().reference().child("Users")
                userRef.child(uid!).queryOrderedByKey().observe(FIRDataEventType.value, with: {(snapshot) in
                    //if self.firebaseLoadedOnce == false
                    //{
                     if self.firebaseLoaded == false{
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
                        
                        print("review Query TV End")
                        
                        //I moved codes above here because review tableview could not be loaded 26th
                        //when the value is changed, tableveiw loads again and again
                    
                       if self.thumbsUpSet.contains(review.rid){
                          print("thummbUPSet contails\(review.rid)")
                          review.userLiked = true
                       }
                    }//Firebase Loaded Once == false
                    }
        
                )
                }//Firebase Loaded Once == false
                
                
                }
            )
            }
            
   )
}

    
    func thumbsUpQuery(){
        
        print("thumbsUpQuery( Called")
        let thumbsUpRef = FIRDatabase.database().reference().child("ThumbsUpList").child(FIRAuth.auth()!.currentUser!.uid)
        thumbsUpRef.observe(FIRDataEventType.childAdded, with: {(snapshot) in
            self.thumbsUpSet.insert(snapshot.key)
            
            
        })
        
        reviewQuery()

        
    }
    
//    func likedQuery(){
//        
//        print("liked Query Called")
//        let youLikedRef = FIRDatabase.database().reference().child("Users").child(FIRAuth.auth()!.currentUser!.uid).child("youLiked")
//        youLikedRef.observe(FIRDataEventType.childAdded, with: {(snapshot) in
//            self.likedSet.insert(snapshot.key)
//            print("likedSet = \(self.likedSet)")
//            print("liked Query End")
//            
//        })
//        
//    }


    @IBAction func backReviewsToPlaceDetailTapped(_ sender: Any) {
        print("back to place detail")
        performSegue(withIdentifier:"backReviewsToPlaceDetailSegue", sender: nil)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backReviewsToPlaceDetailSegue"{
            let nextVC = segue.destination as! PlaceDetailViewController
            nextVC.toilet = toilet
            nextVC.filter = filter
            nextVC.search = search
            
            
        }
        

        
    }
    
    
    
}
