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
    var firebaseOnceLoaded = false
    var toiletReportOnceUploaded = false
    
    
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
        textView.delegate = self
        starRated.rating = 3
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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

        
        
         // let reviewRef = FIRDatabase.database().reference().child("ReviewInfo").childByAutoId()
        
       // reviewRef.updateChildValues(reviewData)
        
        //May 19 changed set() to update()....
        //  reviewRef.setValue(reviewData)
        
        let rid = UUID().uuidString
        
        
        
        let mutipleData = ["ReviewInfo/\(rid)": reviewData,
                           "ReviewList/\(uid)/\(rid)": true,
                           "ToiletReview/\(toilet.key)/\(rid)": true,
                           "ToiletView/\(toilet.key)/available": true,
                           "ToiletView/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "ToiletView/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "ToiletView/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "ToiletView/\(toilet.key)/reviewOne": rid as String,
                           "ToiletView/\(toilet.key)/reviewTwo": toilet.reviewOne as String,
                           "NoFilter/\(toilet.key)/averageStar": String(roundAvStar),
                           "NoFilter/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "NoFilter/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "NoFilter/\(toilet.key)/available": true,
                           "UnitOne/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitOne/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitOne/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitOne/\(toilet.key)/available": true,
                           "UnitTwo/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitTwo/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitTwo/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitTwo/\(toilet.key)/available": true,

                           "UnitThree/\(toilet.key)/averageStar": String(roundAvStar)as String,
                           "UnitThree/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitThree/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitThree/\(toilet.key)/available": true,

                           "UnitFour/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitFour/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitFour/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitFour/\(toilet.key)/available": true,

                           "UnitFive/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitFive/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitFive/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitFive/\(toilet.key)/available": true,

                           "UnitSix/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitSix/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitSix/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitSix/\(toilet.key)/available": true,

                           "UnitSeven/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitSeven/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitSeven/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitSeven/\(toilet.key)/available": true,

                           "UnitEight/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitEight/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitEight/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitEight/\(toilet.key)/available": true,

                           "UnitNine/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitNine/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitNine/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitNine/\(toilet.key)/available": true,

                           "UnitTen/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitTen/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitTen/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitTen/\(toilet.key)/available": true,

                           "UnitEleven/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitEleven/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitEleven/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitEleven/\(toilet.key)/available": true,

                           "UnitTwelve/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "UnitTwelve/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "UnitTwelve/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "UnitTwelve/\(toilet.key)/available": true,

                           "GroupOne/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "GroupOne/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "GroupOne/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "GroupOne/\(toilet.key)/available": true,

                           "GroupTwo/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "GroupTwo/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "GroupTwo/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "GroupTwo/\(toilet.key)/available": true,

                           "GroupThree/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "GroupThree/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "GroupThree/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "GroupThree/\(toilet.key)/available": true,

                           "HalfOne/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "HalfOne/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "HalfOne/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "HalfOne/\(toilet.key)/available": true,

                           "HalfTwo/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "HalfTwo/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "HalfTwo/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "HalfTwo/\(toilet.key)/available": true,

                           "AllFilter/\(toilet.key)/averageStar": String(roundAvStar) as String,
                           "AllFilter/\(toilet.key)/averageWait": newWaitingTime as Int,
                           "AllFilter/\(toilet.key)/reviewCount": newReviewCount as Int,
                           "AllFilter/\(toilet.key)/available": true,

                           ] as [String : Any]
        
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.updateChildValues(mutipleData, withCompletionBlock: { (error, FIRDatabaseReference) in
            if error != nil{
                print("Error = \(String(describing: error))")

                
            }else{
                //Success
                
            }
        })

        moveBackToPlaceDetailVeiwController()
    }





    @IBAction func kansouButtonTapped(_ sender: Any) {
        kansouPosting()
        
    }
    
    
    
    
    
    @IBAction func availableButtonTapped(_ sender: Any) {
        if availableSwitch.isOn {
        availableLabel.text = "利用可能"
        available = true} else {
            availableLabel.text = "利用不可"
            available = false
            
            self.isThereProblem()
            
        }
    }
    
    func isThereProblem(){
        let alertController = UIAlertController (title: "確認", message: "このトイレが利用できませんでしたか？", preferredStyle: .actionSheet)
        
        
        let noAction = UIAlertAction(title: "利用できなかった", style: .default, handler: {(alert:
            UIAlertAction!) in
            self.whatIsTheProblem()

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

    func whatIsTheProblem(){
        
        var problemString = ""
        
        
    
        let nextAlertController = UIAlertController (title: "お願い", message: "トイレが利用できなかった理由を教えてください", preferredStyle: .actionSheet)
        
        
        let notfound = UIAlertAction(title: "トイレが見つからなかったから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "Could not find the Toilet"
            self.problemUpload(problemString: problemString)
        })
        
        let waterLeakage =  UIAlertAction(title: "漏水していたから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "Water Leakage"
            self.problemUpload(problemString: problemString)

        })

        let waterOutage = UIAlertAction(title: "断水していたから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "Water Outage"
            self.problemUpload(problemString: problemString)

        })
    
        
        let noFlash = UIAlertAction(title: "トイレがつまっていたから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "No Flush"
            self.problemUpload(problemString: problemString)

        })
        

        let noToiletPaper = UIAlertAction(title: "トイレットペーパーが無かったから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "No Toilet Paper"
            self.problemUpload(problemString: problemString)

        })
        
        
        
        
        let stillYes = UIAlertAction(title: "いいえ、利用することができた", style: .default, handler: {(alert:
            UIAlertAction!) in
            self.availableSwitch.isOn = true
            self.availableLabel.text = "利用可能"
            self.available = true
            return
        })
        
        nextAlertController.addAction(notfound)
        nextAlertController.addAction(noToiletPaper)
        nextAlertController.addAction(noFlash)
        nextAlertController.addAction(waterLeakage)
        nextAlertController.addAction(waterOutage)
        nextAlertController.addAction(stillYes)
        
        
        self.present(nextAlertController, animated: true, completion: nil)
    }
    
    func problemUpload(problemString: String){
        
        print("problemUpload 777")
    
        let toiletProblemsRef = FIRDatabase.database().reference().child("ToiletProblems")
        let tpid = UUID().uuidString
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
        
        
        
        let tpData : [String : Any] = ["uid": uid,
                                       "tid": toilet.key,
                                       "time": timeString,
                                       "timeNumbers": interval,
                                       "problem": problemString
            
        ]
        
        
        
        
        let firebaseRef = FIRDatabase.database().reference()
        
        
        
        

        
        let mutipleData = ["ToiletProblems/\(toilet.key)": tpData,
                           "NoFilter/\(toilet.key)/available": false,
                           "UnitOne/\(toilet.key)/available": false,
                           "UnitTwo/\(toilet.key)/available": false,
                           "UnitThree/\(toilet.key)/available": false,
                           "UnitFour/\(toilet.key)/available": false,
                           "UnitFive/\(toilet.key)/available": false,
                           "UnitSix/\(toilet.key)/available": false,
                           "UnitSeven/\(toilet.key)/available": false,
                           "UnitEight/\(toilet.key)/available": false,
                           "UnitNine/\(toilet.key)/available": false,
                           "UnitTen/\(toilet.key)/available": false,
                           "UnitEleven/\(toilet.key)/available": false,
                           "UnitTwelve/\(toilet.key)/available": false,
                           "GroupOne/\(toilet.key)/available": false,
                           "GroupTwo/\(toilet.key)/available": false,
                           "GroupThree/\(toilet.key)/available": false,
                           "HalfOne/\(toilet.key)/available": false,
                           "HalfTwo/\(toilet.key)/available": false,
                           "AllFilter/\(toilet.key)/available": false,
                           "ToiletView/\(toilet.key)/available": false,
                           
                           ] as [String : Any]
        
        
        firebaseRef.updateChildValues(mutipleData, withCompletionBlock: { (error, FIRDatabaseReference) in
            if error != nil{
                print("Error 777 = \(String(describing: error))")
                
            }})
            
            

        
        

        //toiletProblemsRef.child(tpid).setValue(tpData)
        
        toiletWarningListUpload()
        
    }
    
    
    ////
    func toiletWarningListUpload(){
        let toiletWarningsRef = FIRDatabase.database().reference().child("ToiletWarningList")
        let uid = FIRAuth.auth()!.currentUser!.uid
        toiletWarningsRef.child(toilet.key).child(uid).setValue(true)
        
    }
    

    func showYourReviewPostedMessage(){
        
        let alertController = UIAlertController (title: "ありがとうございます", message: "あなたの感想が投稿されました", preferredStyle: .alert)
        
    
        let yesAction = UIAlertAction(title: "はい", style: .default, handler: {(alert:
            UIAlertAction!) in
            self.moveBackToPlaceDetailVeiwController()
           
        })
        alertController.addAction(yesAction)
        
        present(alertController, animated: true, completion: nil)
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
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(navigationContoller, animated: false, completion: nil)

    }
    
    @IBAction func kansouPostButtonTapped(_ sender: Any) {
        kansouPosting()
        
    }


}



