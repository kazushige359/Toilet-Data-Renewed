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
    
    var firebaseOnceLoaded = false
    var postRid = ""
    var reviewReportOnceUploaded = false
    var userReportOnceUploaded = false
    var suspiciosUserId = ""
    
    
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

        cell.userHelpedCount.text = "\(reviews[indexPath.row].totalHelpedCount)"
        cell.userLikedCount.text = "\(reviews[indexPath.row].totalLikedCount)"
        
        cell.starRatedLabel.settings.filledColor = UIColor.yellow
        cell.starRatedLabel.settings.emptyBorderColor = UIColor.orange
        cell.starRatedLabel.settings.filledBorderColor = UIColor.orange
        
        cell.likedCountLabel.isHidden = false
        cell.userLikedCount.isHidden = false
        cell.nextLikedCountLabel.isHidden = true
        cell.nextUserLikedCount.isHidden = true
        
        
        cell.reviewReportButton.tag = indexPath.row
        cell.reviewReportButton.addTarget(self, action: #selector(reviewReportButtonTapped(sender:)), for: .allTouchEvents)
        
        
        
//        cell.reviewReportButton.addTarget(self, action: #selector(ReviewTableViewController.reviewReportButtonTapped(sender:)), for:.touchUpInside)
       
        
        
        
        if reviews[indexPath.row].userLiked == true{
         
         cell.likeButton.setImage(imageColored, for: .normal)
            
         
         cell.likeButton.tag = indexPath.row
            
         cell.nextUserLikedCount.text = "\(reviews[indexPath.row].totalLikedCount - 1)"
         cell.nextLikedCountLabel.text = "いいね\(reviews[indexPath.row].likedCount - 1)件"
            
         cell.likeButton.addTarget(self, action: #selector(ReviewTableViewController.reviewLikeButtonTapped(sender:)), for: .touchUpInside)
            
        } else{
        
          
            cell.likeButton.setImage(imageBlack, for: .normal)
           
            cell.likeButton.tag = indexPath.row
            cell.nextUserLikedCount.text = "\(reviews[indexPath.row].totalLikedCount + 1)"
            cell.nextLikedCountLabel.text = "いいね\(reviews[indexPath.row].likedCount + 1)件"
            
            cell.likeButton.addTarget(self, action: #selector(ReviewTableViewController.reviewLikeButtonTapped(sender:)), for: .touchUpInside)
            
        
        
        }
        
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
        
        
        
        print("reviews[buttonRow].rid = \(reviews[buttonRow].rid)")
       
        
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
                
                

                let totalUserThumbsUpCount = reviews[buttonRow].totalLikedCount + 1
                let reviewLikeCount = reviews[buttonRow].likedCount + 1
                thumbsUpRef.child(reviews[buttonRow].rid).setValue(true)
                self.thumbsUpSet.insert(reviews[buttonRow].rid)
                let userInfoUpdate: [String : Any] = ["totalLikedCount": totalUserThumbsUpCount]
                userRef.updateChildValues(userInfoUpdate)
                
                let reviewInfoUpdate: [String : Any] = ["likedCount": reviewLikeCount]
                reviewInfoRef.updateChildValues(reviewInfoUpdate)
  
          }else{
                
                
//                UnTap
         
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
           }
            
        }
    }
    
    
    func reviewReportButtonTapped(sender: UIButton){
        print("ReviewReport Tapped 777")
        let buttonRow = sender.tag
        let rid = reviews[buttonRow].rid
        postRid = rid
        suspiciosUserId = reviews[buttonRow].uid
        print("ButtonRow = \(buttonRow)")
        
        let alertController = UIAlertController (title: "この感想に問題がありますか？", message: "Oh well", preferredStyle: .actionSheet)
        
        
        //let settingsAction = UIAlertAction(title: "はい", style: .default, handler: nil)
        
        let yesAction = UIAlertAction(title: "はい", style: .default, handler: {(alert:
            UIAlertAction!) in
            
            self.whatIsTheProblem()
            
            
        })

        let cancelAction = UIAlertAction(title: "いいえ", style: .default, handler: nil)
        
        
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }

    
    func whatIsTheProblem(){
        
        var problemString = ""
        
        
        let nextAlertController = UIAlertController (title: "お願い", message: "問題だと思う点を教えてください", preferredStyle: .actionSheet)
        
        
        let wrongInfo = UIAlertAction(title: "感想の内容に誤りがあるから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "The content of the review is not correct"
            self.problemUpload(problemString: problemString)
        })
        
        let reviewNotRelevent =  UIAlertAction(title: "感想の内容に不適切な表現があるから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "The content of the review is not relevent"
            self.problemUpload(problemString: problemString)
            
        })
        
        let pictureNotAppropriate = UIAlertAction(title: "感想を投稿したユーザーの写真が適切ではないから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "The picture of the user is not appropriate"
            self.problemUpload(problemString: problemString)
            
        })
        
        
        let nameNotAppropriate = UIAlertAction(title: "感想を投稿したユーザーの名前が適切ではないから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "The name of the user is not appropriate"
            self.problemUpload(problemString: problemString)
            
        })
        
       
        
        let stillYes = UIAlertAction(title: "いいえ、問題はありません", style: .default, handler: {(alert:
            UIAlertAction!) in
            return
        })
        
        nextAlertController.addAction(wrongInfo)
        nextAlertController.addAction(reviewNotRelevent)
        nextAlertController.addAction(pictureNotAppropriate)
        nextAlertController.addAction(nameNotAppropriate)
        nextAlertController.addAction(stillYes)
        
        
        self.present(nextAlertController, animated: true, completion: nil)
    }
    
    
    func problemUpload(problemString: String){
        
        let toiletProblemsRef = FIRDatabase.database().reference().child("ReviewProblems")
        let rpid = UUID().uuidString
        let uid = FIRAuth.auth()!.currentUser!.uid
        let date = NSDate()
        let calendar = Calendar.current
        
        let minute = calendar.component(.minute, from:date as Date)
        let hour = calendar.component(.hour, from:date as Date)
        let day = calendar.component(.day, from:date as Date)
        let month = calendar.component(.month, from:date as Date)
        let year = calendar.component(.year, from:date as Date)
        
        let timeString = "\(year)/\(month)/\(day)-\(hour):\(minute)"
        
        let interval = NSDate().timeIntervalSince1970
        
        if postRid != ""{
        
        
        
        
        let rpData : [String : Any] = ["uid": uid,
                                       "rid": postRid,
                                       "time": timeString,
                                       "timeNumbers": interval,
                                       "problem": problemString
            
        ]
        
        toiletProblemsRef.child(rpid).setValue(rpData)
        
        reviewWarningListUpload()
        userWarningListUpload()
        }
        
    }
    
    
    
    
    ///
    func reviewWarningListUpload(){
    let reviewWarningsRef = FIRDatabase.database().reference().child("ReviewWarningList")
    let uid = FIRAuth.auth()!.currentUser!.uid
    reviewWarningsRef.child(postRid).child(uid).setValue(true)
    
    reviewWarningListCount()
    
    
     }

    func reviewWarningListCount(){
    let reviewWarningsRef = FIRDatabase.database().reference().child("ReviewWarningList")
    
    reviewWarningsRef.child(postRid).observe(FIRDataEventType.value, with: { snapshot in
        
        if self.reviewReportOnceUploaded == false{
            self.reviewReportOnceUploaded = true
            
            let countNumber = snapshot.childrenCount
            self.reviewWarningCountUploadToDatabase(countNumber: Int(countNumber))
            
            
            
        }
    })
    }

func reviewWarningCountUploadToDatabase(countNumber: Int){
    let reviewWarningCountRef = FIRDatabase.database().reference().child("ReviewWarningCount")
    
    reviewWarningCountRef.child(postRid).setValue(countNumber)
    
    showYourReviewPostedMessage()
    
    
    
}
    
    func userWarningListUpload(){
        let userWarningsRef = FIRDatabase.database().reference().child("UserWarningList")
        let uid = FIRAuth.auth()!.currentUser!.uid
        userWarningsRef.child(suspiciosUserId).child(uid).setValue(true)
        
        userWarningListCount()
        
        
    }
    
    func userWarningListCount(){
        let userWarningsRef = FIRDatabase.database().reference().child("UserWarningList")
        
        userWarningsRef.child(suspiciosUserId).observe(FIRDataEventType.value, with: { snapshot in
            
            if self.userReportOnceUploaded == false{
                self.userReportOnceUploaded = true
                
                let countNumber = snapshot.childrenCount
                self.userWarningCountUploadToDatabase(countNumber: Int(countNumber))
                
                
                
            }
        })
    }
    
    func userWarningCountUploadToDatabase(countNumber: Int){
        let userWarningCountRef = FIRDatabase.database().reference().child("UserWarningCount")
        
        userWarningCountRef.child(suspiciosUserId).setValue(countNumber)
        
        
        
    }

    
    


    ////

//    func countReviewWarning(){
//        let reviewWarningsRef = FIRDatabase.database().reference().child("ReviewWarnings")
//        
//        reviewWarningsRef.child(postRid).observe(FIRDataEventType.value, with: { snapshot in
//            
//            if self.firebaseOnceLoaded == false{
//                self.firebaseOnceLoaded = true
//                
//                if snapshot.exists(){
//                    
//                    let getValue = snapshot.value as! Int
//                    print("getValue = \(getValue)")
//                    let newNumber = getValue + 1
//                    print("newNumber = \(newNumber)")
//                    
//                    reviewWarningsRef.child(self.postRid).setValue(newNumber)
//                    
//                    self.showYourReviewPostedMessage()
//                    //go Back to previos navigation
//                    
//                } else {
//                    self.showYourReviewPostedMessage()
//                    
//                    
//                    reviewWarningsRef.child(self.postRid).setValue(1)
//                    
//                }
//            }
//        })
//    }
    
    func showYourReviewPostedMessage(){
        
        let alertController = UIAlertController (title: "ありがとうございます", message: "あなたの報告が完了しました", preferredStyle: .alert)
        
        
        let yesAction = UIAlertAction(title: "はい", style: .default, handler: nil);  alertController.addAction(yesAction)
        
        present(alertController, animated: true, completion: nil)
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
