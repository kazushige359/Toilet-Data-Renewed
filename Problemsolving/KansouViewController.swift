//
//  KansouViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 3/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import Cosmos
import FirebaseAuth
import FirebaseDatabase

class KansouViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    
    @IBOutlet weak var starRated: CosmosView!
    
    @IBOutlet weak var pickerTextField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var kansouButton: UIButton!
    
    @IBOutlet weak var availableLabel: UILabel!
    
    @IBOutlet weak var availableSwitch: UISwitch!
    
//    let date = NSDate()
//    let calendar = NSCalendar.current
    
    var interval = NSDate().timeIntervalSince1970
    var starUpdated = false
    var reviewUpdated = false
    var manuallyAverageStar = Double()
    var manuallyAverageWait = Int()
    var manuallyReviewCount = Int()
    
    
   // var interval = NSDate().timeIntervalSince1970
    
    //var date = NSDate(timeIntervalSince1970: interval)
    
//    NSDateFormatter dateFormat = [NSDateFormatter new];
//    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"];
//    
//    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
//    
//    NSLog(@"%@",dateString);
    
    //let stringForm =
//    let stringForm = data.base64EncodedStringWithOptions([])
   // let dataOption = NSData(base64EncodedString: stringForm, options: [])
    
    var waitminute = ""
    
    var toilets: [Toilet] = []
    var toilet = Toilet()
    var search = Search()
    var filter = Filter()

    var key = ""
    var available = true
    var numberPicked = false
    
    var pickOption = ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24","25","26", "27", "28","29","30"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        pickerTextField.inputView = pickerView
        
        
        starRated.settings.filledColor = UIColor.yellow
        starRated.settings.emptyBorderColor = UIColor.orange
        starRated.settings.filledBorderColor = UIColor.orange
        

        
      kansouButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        textView.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 5, alpha: 0.25)
        textView.textColor = UIColor.gray
        textView.isScrollEnabled = false
        print("viewdidload")
        textView.delegate = self
        starRated.rating = 3
        print("self.starUpdated = \(self.starUpdated)")
        print("self.reviewUpdated = \(self.reviewUpdated)")
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        
        print("Kansou Toilet.key = \(toilet.key)")
//        let userRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("userPhoto")
//        userRef.queryOrderedByKey().observe(.value, with: { snapshot in
//            
//            let userPhoto = snapshot.value as? String
//            print("userPhoto = \(userPhoto)")
//        }
//        )
        
        // Do any additional setup after loading the view.
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
        
        
    
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //pickerTextField.text = "待ち時間　\(pickOption[row])分"
        
        pickerTextField.text = "待ち時間　\(pickOption[row])分"
        print("pickOption[row] = \(pickOption[row])")
        numberPicked = true
        
      
        
        waitminute = pickOption[row]
    
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            print("\n")
        textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
               if(textView.text == "トイレがとても綺麗でした。いつもお掃除ありがとうございます。"){
        print("textView.text == トイレがとても綺麗でした。いつもお掃除ありがとうございます。")
        textView.text = ""
        textView.textColor = UIColor.black
                //UIColor to gray 
        }
        textView.becomeFirstResponder()
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if(textView.text == ""){
            print("textView.text == !!!")
            textView.text = "トイレがとても綺麗でした。いつもお掃除ありがとうございます。"
            textView.textColor = UIColor.gray
            textView.resignFirstResponder()
            
    }
    }
    
    func kansouPosting(){
        
        
          print("kansouPostingCalled")
          let originalAvStar = Double(toilet.averageStar)
          let originalAvWait = toilet.averageWait
          let originalReviewCount = toilet.reviewCount
        
        
          let newReviewCount = originalReviewCount + 1
          var newAvStar = Double()
          var newWaitingTime = Int()
        
        if self.waitminute == ""{
         self.waitminute = "0"
        
        }
         
        
        
        
        if (newReviewCount > 9){
            
            let x = self.starRated.rating - originalAvStar!
            let changeingValue = x / 10
            
            newAvStar = originalAvStar! + changeingValue
            
        } else{
            
            let y = self.starRated.rating - originalAvStar!
            let changeValue = y / Double(newReviewCount)
            newAvStar = originalAvStar! + changeValue
            
            
        }
        
        //I gotta round av star 
        
        let roundAvStar = Double(round(10*newAvStar)/10)
        
        
        if (newReviewCount > 4){
            
            let c = Int(self.waitminute)! - originalAvWait
            let changeingValue = c / 5
            newWaitingTime = originalAvWait + changeingValue
            
            
        } else{
            
            let d = Int(self.waitminute)! - originalAvWait
            let changeingValue = d / newReviewCount
            newWaitingTime = originalAvWait + changeingValue
            
        }
        
        

//....................        add reviewInfo in reviews child
        if self.numberPicked == false{
            self.waitminute = "0"}
        
        let date = NSDate()
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from:date as Date)
        let month = calendar.component(.month, from:date as Date)
        let year = calendar.component(.year, from:date as Date)
        
        let dateString = "\(year)-\(month)-\(day)"
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        //print("yearmonthday = \(year)年\(month)月\(day)日")
        
        let interval = NSDate().timeIntervalSince1970
        
        let reviewData : [String : Any] = ["uid": uid , "tid": self.toilet.key, "star": String(self.starRated.rating) , "waitingtime": self.waitminute ,"feedback": self.textView.text, "available": self.available, "time": dateString, "timeNumbers":interval, "likedCount":0
        ]

        
          let reviewRef = FIRDatabase.database().reference().child("ReviewInfo").childByAutoId()
        
          reviewRef.setValue(reviewData)
        
        
        
          let rid = reviewRef.key
        
        
        
         print("this is the new rid = \(rid) Print ")
        
        let reviewListRef = FIRDatabase.database().reference().child("ReviewList").child(uid)
        
          reviewListRef.child(rid).setValue(true)
        
        let toiletReviewsRef = FIRDatabase.database().reference().child("ToiletReviews").child(toilet.key)
        
          toiletReviewsRef.child(rid).setValue(true)
        
        let toiletRef = FIRDatabase.database().reference().child("Toilets").child(toilet.key)
        
        //toiletRef.updateChildValues("averageStar": "3.0")
        
        //let newAvStar =
        
        let tdata : [String : Any] = ["averageStar": String(roundAvStar),
                                      "averageWait": newWaitingTime,
                                      "reviewCount": newReviewCount,
                                      "available": self.available,
                                      "reviewOne": rid,
                                      "reviewTwo": toilet.reviewOne
                                            ]
        
        
        toiletRef.updateChildValues(tdata)
        
        print("kansouPosting()Ended")
        
        moveBackToPlaceDetailVeiwController()
        
        
        
        
    }





    @IBAction func kansouButtonTapped(_ sender: Any) {
        kansouPosting()
        
        
               }
    
    
    
    
    
    @IBAction func availableButtonTapped(_ sender: Any) {
        if availableSwitch.isOn {
        availableLabel.text = "利用可能"
        available = true}
        
        else {
            availableLabel.text = "利用不可"
            available = false
            
            let alertController = UIAlertController (title: "確認", message: "このトイレが利用できませんでしたか？", preferredStyle: .actionSheet)
            //Changed to action Sheet
            
            let noAction = UIAlertAction(title: "利用できなかった", style: .default, handler: {(alert:
                UIAlertAction!) in
                let nextAlertController = UIAlertController (title: "お願い", message: "トイレが利用できなかった理由を教えてください", preferredStyle: .actionSheet)
                
                let notfound = UIAlertAction(title: "トイレが見つからなかったから", style: .default, handler: nil)
                let noWater = UIAlertAction(title: "断水していたから", style: .default, handler: nil)
                let noFlash = UIAlertAction(title: "トイレがつまっていたから", style: .default, handler: nil)
                let noToiletPaper = UIAlertAction(title: "トイレットペーパーが無かったから", style: .default, handler: nil)
                let stillYes = UIAlertAction(title: "いいえ、利用することができた", style: .default, handler: {(alert:
                    UIAlertAction!) in
                    self.availableSwitch.isOn = true
                    self.availableLabel.text = "利用可能"
                    self.available = true
                })

                            nextAlertController.addAction(notfound)
                            nextAlertController.addAction(noToiletPaper)
                            nextAlertController.addAction(noFlash)
                            nextAlertController.addAction(noWater)
                            nextAlertController.addAction(stillYes)
                
   
                self.present(nextAlertController, animated: true, completion: nil)
                  })
            
            let yesAction = UIAlertAction(title: "利用できた", style: .default, handler: {(alert:
                UIAlertAction!) in
            self.availableSwitch.isOn = true
            self.availableLabel.text = "利用可能"
            self.available = true
            
                
            })

            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            present(alertController, animated: true, completion: nil)
            

        }
    }
    
    @IBAction func backBarButtonTapped(_ sender: Any) {
        moveBackToPlaceDetailVeiwController()
        
    }
    
    func moveBackToPlaceDetailVeiwController(){
    
    
        
        let storyboard = UIStoryboard(name: "PlaceDetailViewController", bundle: nil)
        let navigationContoller = storyboard.instantiateViewController(withIdentifier: "PlaceNavigationController") as! UINavigationController
        let nextVC = navigationContoller.topViewController as! PlaceDetailViewController
        
        
        nextVC.toilet.key = toilet.key
        nextVC.filter = filter
        nextVC.search = search
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(navigationContoller, animated: false, completion: nil)

    }
    
    @IBAction func kansouPostButtonTapped(_ sender: Any) {
        kansouPosting()
        
    }


}



