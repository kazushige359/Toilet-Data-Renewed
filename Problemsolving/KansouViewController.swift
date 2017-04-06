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
//        let userRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid)
//        print("kansouPosting")
//        userRef.queryOrderedByKey().observe(FIRDataEventType.value, with: { snapshot in
//            //This code above will be called when the value change i guess
//            
//            let snapshotValue = snapshot.value as? NSDictionary
//            
//            let userName = snapshotValue?["userName"] as? String
//            let userPhoto = snapshotValue?["userPhoto"] as? String
        
            if self.numberPicked == false{
                self.waitminute = "0"}
            
            let date = NSDate()
            let calendar = Calendar.current
            
            let day = calendar.component(.day, from:date as Date)
            let month = calendar.component(.month, from:date as Date)
            let year = calendar.component(.year, from:date as Date)
            
            let dateString = "\(year)年\(month)月\(day)日"
            //print("yearmonthday = \(year)年\(month)月\(day)日")
            
            let interval = NSDate().timeIntervalSince1970
            
            
            print("kansouPosting1")
//            
//            let toiletsRef = FIRDatabase.database().reference().child("Toilets")
//            toiletsRef.child(self.key).observe(FIRDataEventType.value, with: { snapshot in
            let toiletsRef = FIRDatabase.database().reference().child("Toilets")
                 toiletsRef.child(self.toilet.key).observe(FIRDataEventType.value, with: { snapshot in

            
                //This code above will be called when the value change i guess
                 print("kansouPosting2")
                print("snapshot = \(snapshot)")
                 print("snapshot = \(snapshot.key)")
                 print("snapshot = \(snapshot.value)")
                
                if self.starUpdated == false {
                    
//                    print("snapshot = \(snapshot)")
//                    print("star0")
//                    let star0 = self.starRated.rating
//                    self.toilet.star1 = Int(star0)
//                    print("star1")
//                    let snapshotValue = snapshot.value as? NSDictionary
//                    
//                    let star1 = snapshotValue?["star1"] as? Int
//                    print("star1  = \(star1)")
//                    self.toilet.star2 = star1!
//                    
//                    
//                    let star2 = snapshotValue?["star2"] as? Int
//                    self.toilet.star3 = star2!
//                    
//                    let star3 = snapshotValue?["star3"] as? Int
//                    self.toilet.star4 = star3!
//                    
//                    let star4 = snapshotValue?["star4"] as? Int
//                    self.toilet.star5 = star4!
//                    
//                    let star5 = snapshotValue?["star5"] as? Int
//                    self.toilet.star6 = star5!
//                    
//                    let star6 = snapshotValue?["star6"] as? Int
//                    self.toilet.star7 = star6!
//                    
//                    let star7 = snapshotValue?["star7"] as? Int
//                    self.toilet.star8 = star7!
//                    
//                    let star8 = snapshotValue?["star8"] as? Int
//                    self.toilet.star9 = star8!
//                    
//                    let star9 = snapshotValue?["star9"] as? Int
//                    self.toilet.star10 = star9!
//                    
//                    
//                    //
//                    let wait1 = snapshotValue?["wait1"] as? Int
//                    self.toilet.wait2 = wait1!
//                    
//                    let wait2 = snapshotValue?["wait2"] as? Int
//                    self.toilet.wait3 = wait2!
//                    
//                    let wait3 = snapshotValue?["wait3"] as? Int
//                    self.toilet.wait4 = wait3!
//                    
//                    let wait4 = snapshotValue?["wait4"] as? Int
//                    self.toilet.wait5 = wait4!
//                    
//                    //                    let wait5 = snapshotValue?["wait1"] as? Int
//                    //                    self.toilet.wait2 = wait1
//                    print("reviewCount")
//                    let reviewCount = snapshotValue?["reviewCount"] as? Int
//                    print("reviewCount = \(reviewCount)")
//                    self.toilet.reviewCount = reviewCount! + 1
//                    self.manuallyReviewCount = reviewCount! + 1
//                    print("total Star")
//                    
//                    var sum = Int()
//                    let starArray:Array<Int> = [self.toilet.star1,star1!,star2!,star3!,star4!,star5!,star6!,star7!,star8!,star9!]
//                    for number in starArray {
//                        sum += number
//                    }
//                    let totalStar = sum
//                    let totalDouble = Double(totalStar)
//                    let reviewCountDouble = Double(self.toilet.reviewCount)
                    //Commeted for very slow building
//                    
//                    print("AVEStar")
//                    var avStar = Double()
//                    if self.toilet.reviewCount >= 10{
//                        avStar = totalDouble/10
//                        print("totalDouble = \(totalDouble)")
//                        print("avStar = \(avStar)")
//                    }else{
//                        avStar = totalDouble/reviewCountDouble
//                        print("totalDouble = \(totalDouble)")
//                        print("totalDouble = \(reviewCountDouble)")
//                        print("avStar = \(avStar)")
//                        
//                        
//                        
//                    }
//                    //round(0.01*avStar)/0.01
//                    //let td1 = round(0.01*toilets[indexPath.row].distance)/0.01/1000
//                    print("0.01*avStar = \(0.01*avStar)")
//                    print("round(0.01*avStar)/0.01 = \(round(0.01*avStar)/0.01)")
//                    //(round(1000*x)/1000)
//                    self.toilet.averageStar = "\(round(10*avStar)/10)"
//                    self.manuallyAverageStar = round(10*avStar)/10
//                    // self.toilet.averageStar = round(0.01*avStar)/0.01
//                    //self.toilet.averageStar = avStar
//                    
//                    let waitInt = Int(self.waitminute)
//                    var waitSum = Int()
//                    
//                    //wait minute to int()
//                    let waitArray:Array<Int> = [waitInt!,wait1!,wait2!,wait3!,wait4!]
//                    for number in waitArray {
//                        waitSum += number
//                    }
//                    let totalWait = waitSum
//                    var avWait = Int()
//                    if self.toilet.reviewCount >= 5{
//                        avWait = totalWait/5
//                        print("totalWait = \(totalWait)")
//                        print("avWait = \(avWait)")
//                    }else{
//                        avWait = totalWait/self.toilet.reviewCount
//                        print("totalWait = \(totalWait)")
//                        print("reviewCount = \(reviewCount)")
//                        print("avWait = \(avWait)")
//                    }
//                    self.toilet.averageWait = avWait
//                    self.manuallyAverageWait = avWait
//                    
//                    
//                    
//                    
//                    
//                    
//                    
//                    
//                    
//                    
//                    let addingData: [String : Any] = [
//                        "reviewCount": self.toilet.reviewCount as Int,
//                        "averageStar": "\(self.toilet.averageStar)" as String,
//                        "star1": self.toilet.star1 as Int,
//                        "star2": self.toilet.star2 as Int,
//                        "star3": self.toilet.star3 as Int,
//                        "star4": self.toilet.star4 as Int,
//                        "star5": self.toilet.star5 as Int,
//                        "star6": self.toilet.star6 as Int,
//                        "star7": self.toilet.star7 as Int,
//                        "star8": self.toilet.star8 as Int,
//                        "star9": self.toilet.star9 as Int,
//                        "star10": self.toilet.star10 as Int,
//                        "wait1": Int(self.waitminute)! as Int,
//                        "wait2": self.toilet.wait2 as Int,
//                        "wait3": self.toilet.wait3 as Int,
//                        "wait4": self.toilet.wait4 as Int,
//                        "wait5": self.toilet.wait5 as Int,
//                        "averageWait": self.toilet.averageWait as Int
//                    ]
//                    
                    //"wait1": self.toilet.wait1 as Int
                    
                    //Commeted for the super slow building
                    
//                    
//                    toiletsRef.child(self.toilet.key).updateChildValues(addingData)
//                    print("starUpdated = \(self.starUpdated)")
//                    self.starUpdated = true
//                    print("self.starUpdated = \(self.starUpdated)")
//                    //This code creates a lot of mess
//                   
                    
                    
                    
                }
                // firebaseUpdated = true
                //(["yourKey": yourValue])
                
                
                
                
                
                let data : [String : Any] = ["uid": FIRAuth.auth()!.currentUser!.uid , "tid": self.toilet.key, "star": self.starRated.rating , "waitingtime": self.waitminute ,"feedback": self.textView.text, "available": self.available, "time": dateString, "timeNumbers":interval, "likedCount":0
                ]
                
                
                
                
                let databaseRef = FIRDatabase.database().reference()
                //databaseRef.child("reviews").child(key).setValue(data)
                if self.reviewUpdated == false{
                    databaseRef.child("reviews").childByAutoId().setValue(data)
                    
                    
                    //databaseRef.child("Toilets").child(self.key).child("reviews").setValue(data)
                    //Commented above code bacuase i dont think its neccesarry
                    
                    self.reviewUpdated = true
                    print("self.reviewUpdated = \(self.reviewUpdated)")
                    
                }})
            //child(FIRAuth.auth()!.currentUser!.uid).child("youwent").child(toilet.key).setValue(toilet.key)
            
            if self.available == false {
                print("unavailable")
                
            }
        
//            toilet.averageStar = manuallyAverageStar
//            toilet.averageWait = manuallyAverageWait
//            toilet.reviewCount = manuallyReviewCount
        
        
        
//            _ = self.navigationController?.popViewController(animated: true)
       // }
       // )

    
    
    
    }
    @IBAction func kansouButtonTapped(_ sender: Any) {
        kansouPosting()
        performSegue(withIdentifier: "backToDetail", sender: nil)
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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToDetail", sender: nil)
        
    }
    
    @IBAction func kansouPostButtonTapped(_ sender: Any) {
        kansouPosting()
        performSegue(withIdentifier: "backToDetail", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToDetail"{
            let nextVC = segue.destination as! DetailViewController
            nextVC.toilet = toilet
            nextVC.filter = filter
            nextVC.search = search
        }

    
    
            
    }}



