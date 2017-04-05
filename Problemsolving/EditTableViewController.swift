//
//  EditTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 12/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import Cosmos
import MapKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class EditTableViewController: UITableViewController,UIPickerViewDelegate, UIPickerViewDataSource,MKMapViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

   
    
    
    @IBOutlet weak var placeNameLabel: UITextField!
    
    @IBOutlet weak var placeCategoryLabel: UITextField!
    
    @IBOutlet weak var availableTimeLabel: UITextField!
    
    @IBOutlet weak var washletLabel: UILabel!
    
    @IBOutlet weak var washletLabelSwitch: UISwitch!
    
    @IBOutlet weak var wheelChairLabel: UILabel!
    
    @IBOutlet weak var wheelChairLabelSwitch: UISwitch!
    
    @IBOutlet weak var onlyFemaleLabel: UILabel!
    
    @IBOutlet weak var onlyFemaleLabelSwitch: UISwitch!
    
    @IBOutlet weak var unisexLabel: UILabel!
    
    @IBOutlet weak var unisexLabelSwitch: UISwitch!
    
    @IBOutlet weak var makeroomLabel: UILabel!
    
    @IBOutlet weak var makeroomLabelSwitch: UISwitch!
    
    @IBOutlet weak var milkspaceLabel: UILabel!
    
    @IBOutlet weak var milkspaceLabelSwitch: UISwitch!
    
    @IBOutlet weak var omutuLabel: UILabel!
    
    @IBOutlet weak var omutuLabelSwitch: UISwitch!
    
    
    @IBOutlet weak var ostomateLabel: UILabel!
    
    @IBOutlet weak var ostomateLabelSwitch: UISwitch!
    
    
    @IBOutlet weak var japaneseToiletLabel: UILabel!
    
    @IBOutlet weak var japaneseToiletLabelSwitch: UISwitch!
    
    @IBOutlet weak var westernToiletLabel: UILabel!
    
    @IBOutlet weak var westernToiletLabelSwitch: UISwitch!
    
    @IBOutlet weak var warmSeatLabel: UILabel!
    
    @IBOutlet weak var warmSeatLabelSwitch: UISwitch!
    
    @IBOutlet weak var baggageSpaceLabel: UILabel!
    
    @IBOutlet weak var baggageSpaceLabelSwitch: UISwitch!
    
    @IBOutlet weak var accessTextView: UITextView!
    
    
    @IBOutlet weak var starView: CosmosView!
    
    @IBOutlet weak var waitMinutesLabel: UITextField!
    
    @IBOutlet weak var feedbackTextView: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var setPinButton: UIButton!
    
    @IBOutlet weak var addPictureButton: UIButton!
    
    @IBOutlet weak var postButton: UIButton!
    
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var subImage1: UIImageView!
    
    @IBOutlet weak var subImage2: UIImageView!
    
    
    var pickOption = ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24","25","26", "27", "28","29","30"]
    
    var categoryOption = ["全てのトイレ","公衆トイレ","コンビニ","カフェ","レストラン","商業施設","観光地・スタジアム","仮設トイレ"]

    
    var availableTimeOption = [
        ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24"],
        ["00", "15","30","45"],
        ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24"],
        ["00", "15","30","45"]
    ]
    
    var toilet = Toilet()
    
    var waitminute = ""
    // String to Int
    
    var numberPicked = false
    
    var returnCount = Int()
    var returnNumber = Int()
    var pickedOption = String()
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    
    var time1 = "0"
    var time2 = "00"
    var time3 = "0"
    var time4 = "00"
    var pincoodinate = CLLocationCoordinate2D()
    var imagePicker = UIImagePickerController()
    
    var mainImageReplace = false
    var subImageReplace1 = false
    var subImageReplace2 = false

    var mainImageChanged = false
    var subImageOneChanged = false
    var subImageTwoChanged = false
    
    var geoFire: GeoFire!
    var geoFireRef: FIRDatabaseReference!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("toilet.key = \(toilet.key)")
        print("toilet.url = \(toilet.urlOne)")
        
        mapView.delegate = self
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        waitMinutesLabel.inputView = pickerView1
        placeCategoryLabel.inputView = pickerView2
        availableTimeLabel.inputView = pickerView3
       
        mainImage.sd_setImage(with: URL(string: toilet.urlOne))
        subImage1.sd_setImage(with: URL(string: toilet.urlTwo))
        subImage2.sd_setImage(with: URL(string: toilet.urlThree))
        
        imagePicker.delegate = self
        
        starView.rating = 3.0
        
        //Because its difficult to change int to double.....
        
        starView.settings.filledColor = UIColor.yellow
        starView.settings.emptyBorderColor = UIColor.orange
        starView.settings.filledBorderColor = UIColor.orange

        
        mapView.isUserInteractionEnabled = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditTableViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

        
        if toilet.washlet == true{
            washletLabelSwitch.isOn = true
            washletLabel.textColor = UIColor.black
            
        }else{
            washletLabelSwitch.isOn = false
            washletLabel.textColor = UIColor.gray
            //Added at 6pm
        }
        
        if toilet.wheelchair == true{
             wheelChairLabelSwitch.isOn = true
             wheelChairLabel.textColor = UIColor.black
        }else{
             wheelChairLabelSwitch.isOn = false
             wheelChairLabel.textColor = UIColor.gray
        }
        
        if toilet.onlyFemale == true{
           onlyFemaleLabelSwitch.isOn = true
           onlyFemaleLabel.textColor = UIColor.black

        }
        else{
            onlyFemaleLabelSwitch.isOn = false
            onlyFemaleLabel.textColor = UIColor.gray
        }
       
        
        if toilet.unisex == true{
            unisexLabelSwitch.isOn = true
            unisexLabel.textColor = UIColor.black
        }else{
            unisexLabelSwitch.isOn = false
            unisexLabel.textColor = UIColor.gray
        }
        
        if toilet.makeuproom == true{
             makeroomLabelSwitch.isOn = true
            makeroomLabel.textColor = UIColor.black
        }else{
            makeroomLabelSwitch.isOn = false
            makeroomLabel.textColor = UIColor.gray
        }
        
        if toilet.milkspace == true{
            milkspaceLabelSwitch.isOn = true
            milkspaceLabel.textColor = UIColor.black
        }else{
            milkspaceLabelSwitch.isOn = false
            milkspaceLabel.textColor = UIColor.gray
        }
      
        
        if toilet.omutu == true{
            omutuLabelSwitch.isOn = true
            omutuLabel.textColor = UIColor.black

        }else{
            omutuLabelSwitch.isOn = false
            omutuLabel.textColor = UIColor.gray

        }
       
        if toilet.ostomate == true{
            ostomateLabelSwitch.isOn = true
            ostomateLabel.textColor = UIColor.black
        }else{
            ostomateLabelSwitch.isOn = false
            ostomateLabel.textColor = UIColor.gray

        }
        
        if toilet.japanesetoilet == true{
            japaneseToiletLabelSwitch.isOn = true
            japaneseToiletLabel.textColor = UIColor.black
        }else{
            japaneseToiletLabelSwitch.isOn = false
            japaneseToiletLabel.textColor = UIColor.gray

        }
        
        
        if toilet.westerntoilet == true{
           westernToiletLabelSwitch.isOn = true
            westernToiletLabel.textColor = UIColor.black
        }else{
             westernToiletLabelSwitch.isOn = false
           westernToiletLabel.textColor = UIColor.gray
        }
        
        if toilet.warmSeat == true{
            warmSeatLabelSwitch.isOn = true
            warmSeatLabel.textColor = UIColor.black
        }else{
            warmSeatLabelSwitch.isOn = false
            warmSeatLabel.textColor = UIColor.gray
        }
        
        if toilet.baggageSpace == true{
            baggageSpaceLabelSwitch.isOn = true
            baggageSpaceLabel.textColor = UIColor.black
        }else{
            baggageSpaceLabelSwitch.isOn = false
            baggageSpaceLabel.textColor = UIColor.gray
        }
        
        placeNameLabel.text = toilet.key
        placeCategoryLabel.text = toilet.type
        availableTimeLabel.text = toilet.openinghours
        
        let pinAnnotation = MKPointAnnotation()
        pinAnnotation.coordinate = pincoodinate
        mapView.addAnnotation(pinAnnotation)
        
       
        let region = MKCoordinateRegionMakeWithDistance(pincoodinate, 1300, 1300)
        //500 to 300
        mapView.setRegion(region, animated: true)
       
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView == pickerView1 {
            returnNumber = 1
        }
        if pickerView == pickerView2 {
            returnNumber = 1
        }
        if pickerView == pickerView3 {
            returnNumber = availableTimeOption.count
        }
        
        return returnNumber
        // return 1
        //I might change this for availableTime
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
            //print("pickerView1")
            returnCount = pickOption.count
        }
        if pickerView == pickerView2 {
            //print("pickerView2")
            returnCount = categoryOption.count
        }
        if pickerView == pickerView3 {
            //print("pickerView3")
            returnCount = availableTimeOption[component].count
        }
        
        
        
        return returnCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            //print("pickerView1")
            pickedOption = pickOption[row]
            
        }
        if pickerView == pickerView2 {
            //print("pickerView2")
            pickedOption = categoryOption[row]
            
        }
        if pickerView == pickerView3 {
            //print("pickerView3")
            pickedOption = availableTimeOption[component][row]
            
        }
        
        return pickedOption
        
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //pickerTextField.text = "待ち時間　\(pickOption[row])分"
        if pickerView == pickerView1 {
            
            waitMinutesLabel.text = "待ち時間　\(pickOption[row])分"
            numberPicked = true
            waitminute = pickOption[row]
        }
        
        if pickerView == pickerView2 {
            placeCategoryLabel.text = categoryOption[row]
        }
        
        if pickerView == pickerView3 {
            
            switch (component) {
            case 0:
                time1 = availableTimeOption[component][row]
                availableTimeLabel.text = "利用可能時間  \(time1):\(time2)〜\(time3):\(time4)"
            case 1:
                time2 = availableTimeOption[component][row]
                availableTimeLabel.text = "利用可能時間  \(time1):\(time2)〜\(time3):\(time4)"
            case 2:
                time3 = availableTimeOption[component][row]
                availableTimeLabel.text = "利用可能時間  \(time1):\(time2)〜\(time3):\(time4)"
            case 3:
                time4 = availableTimeOption[component][row]
                availableTimeLabel.text = "利用可能時間  \(time1):\(time2)〜\(time3):\(time4)"
                
            default: break
                
            }}
        
        //Do i need something after this?
        
    }
    
    
    
    func switchIsChanged(_: UISwitch) {
        if wheelChairLabelSwitch.isOn == true {
            wheelChairLabel.textColor = UIColor.black
        }else{
            //wheelChairLabelSwitch.isOn == false
            wheelChairLabel.textColor = UIColor.gray
        }
    }
    
    
    @IBAction func setPinTapped(_ sender: Any) {
 
        
        
        //Experiment
        performSegue(withIdentifier: "EdittoEditPinSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EdittoEditPinSegue"{
            let nextVC = segue.destination as! EditPinViewController
            
            nextVC.toilet = toilet
            
            //toilet.key
            nextVC.toiletLocation = pincoodinate

        }
        
        if segue.identifier == "editTabletoDetailSegue"{
            let nextV = segue.destination as! DetailViewController
            
            nextV.toilet = toilet
            print("toilet.key = \(toilet.key)")
        }

    }
    
    @IBAction func addPictureTapped(_ sender: Any) {
        let alertController = UIAlertController (title: "どの写真を追加・変更しますか", message: "以下の選択肢からお選びください", preferredStyle: .actionSheet)
        
            let mainImageOption = UIAlertAction(title: "メインイメージ", style: .default) { (_) -> Void in
            self.mainImageReplace = true
            self.subImageReplace1 = false
            self.subImageReplace2 = false
            self.photoUpload()
            
        }
        let subImage1 = UIAlertAction(title: "サブイメージ1", style: .default) { (_) -> Void in
            self.mainImageReplace = false
            self.subImageReplace1 = true
            self.subImageReplace2 = false
            self.photoUpload()

                   }
        let subImage2 = UIAlertAction(title: "サブイメージ2", style: .default) { (_) -> Void in
            self.mainImageReplace = false
            self.subImageReplace1 = false
            self.subImageReplace2 = true
            self.photoUpload()
            
        }
            let cancelOption = UIAlertAction(title: "キャンセル", style: .default)
        alertController.addAction(mainImageOption)
        alertController.addAction(subImage1)
        alertController.addAction(subImage2)
        alertController.addAction(cancelOption)
        

        
        present(alertController, animated: true, completion: nil)
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = true
//        
//        present(imagePicker, animated: true, completion: nil)
        //print(placeNameLabel.text)
    }
    func photoUpload(){
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        
        self.present(self.imagePicker, animated: true, completion: nil)
   
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "editTabletoDetailSegue", sender: nil)
        
    }
    
    @IBAction func postButtonBarTapped(_ sender: Any) {
        editdataExecution()
    }
    @IBAction func postButtonTapped(_ sender: Any) {
        editdataExecution()
      
    }
    
    func editdataExecution(){
        let date = NSDate()
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from:date as Date)
        let month = calendar.component(.month, from:date as Date)
        let year = calendar.component(.year, from:date as Date)
        
        let dateString = "\(year)年\(month)月\(day)日"
        let interval = NSDate().timeIntervalSince1970
        
        
        
        let name = placeNameLabel.text
        if name == "" {
            print("name == nil")
            let alertController = UIAlertController (title: "お願い", message: "施設の名前を記入してください", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "OK!", style: .default, handler: nil)
            
            alertController.addAction(yesAction)
            
            
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            
            
            
            let locationsRef = FIRDatabase.database().reference().child("ToiletLocations")
            let geoFire = GeoFire(firebaseRef: locationsRef)
            
            
            
            if placeCategoryLabel.text == ""{
                placeCategoryLabel.text = "未設定"
            }
            if availableTimeLabel.text == ""{
                availableTimeLabel.text = "未設定"
            }
            if accessTextView.text == ""{
                accessTextView.text = "アクセス情報"
            }
            if waitMinutesLabel.text == ""{
                waitminute = "0"
            }
            if feedbackTextView.text == ""{
                feedbackTextView.text = "未記入"
                //未記入？？
            }
            let Lat: CLLocationDegrees = pincoodinate.latitude
            let Lon: CLLocationDegrees = pincoodinate.longitude
            
            let waitInt:Int? = Int(waitminute)
            let availableTimeForDatabase = "\(time1):\(time2)〜\(time3):\(time4)"
            
            
            
            
            geoFire!.setLocation(CLLocation(latitude: Lat, longitude: Lon), forKey: name){(error) in
                if (error != nil) {
                    print("An error occured: \(error)")
                    print("in geoFire.setLocation")
                } else {
                    print("Saved location successfully!")
                    print("in geoFire.setLocation")
                }
            }
            print("after geoFire.setLocation")
            
            // let newReviewCountDouble = Double(toilet.reviewCount + 1)
            //Maybe count endlessly
            
            //Array removed for the super slow building
            var sum = Int()
            let starArray:Array<Int> = [Int(starView.rating),toilet.star1,toilet.star2,toilet.star3,toilet.star4,toilet.star5,toilet.star6,toilet.star7,toilet.star8,toilet.star9]
            for number in starArray {
                sum += number
            }
            
            let totalStar = sum
            let totalDouble = Double(totalStar)
            let reviewCountDouble = Double(self.toilet.reviewCount)
            let newReviewCount = toilet.reviewCount + 1
            let newReviewCountDouble = Double(self.toilet.reviewCount + 1)
            
            var avStar = Double()
            if self.toilet.reviewCount >= 9{
                //Considerd reviewCount will be added one because of this edition
                avStar = totalDouble/10
                print("totalDouble = \(totalDouble)")
                print("avStar = \(avStar)")
            }else{
                avStar = totalDouble/newReviewCountDouble
                //avStar = totalDouble/reviewCountDouble
                print("totalDouble = \(totalDouble)")
                print("totalDouble = \(reviewCountDouble)")
                print("avStar = \(avStar)")
            }
            let newAvStar = round(10*avStar)/10
            ///
            
            var waitSum = Int()
            let waitArray:Array<Int> = [waitInt!,toilet.wait1,toilet.wait2,toilet.wait3,toilet.wait4]
            for number in waitArray {
                waitSum += number
            }
            let totalWait = waitSum
            
            var avWait = Int()
            if self.toilet.reviewCount >= 4{
                //Considerd reviewCount will be added one because of this edition
                avWait = totalWait/5
                print("totalWait = \(totalWait)")
                print("avWait = \(avWait)")
            }else{
                avWait = totalWait/newReviewCount
                //avStar = totalDouble/reviewCountDouble
                print("totalWait = \(totalWait)")
                print("newReviewCount = \(newReviewCount)")
                print("avWait = \(avWait)")
            }
            
            let tdata : [String : Any] =
                ["name": name as Any,
                 "openinghours": availableTimeForDatabase as String,
                 "type": placeCategoryLabel.text! as String,
                 "star": starView.rating as Double,
                 "waitingtime": waitInt! as Int,
                 //Should be Int
                    "urlOne":"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2FFamilyMart.picture.jpg?alt=media&token=0de63d07-fb5e-4534-a423-796d1b5b44af",
                    "urlTwo":"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2FFamilyMart.picture.jpg?alt=media&token=0de63d07-fb5e-4534-a423-796d1b5b44af",
                    "urlThree":"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2FFamilyMart.picture.jpg?alt=media&token=0de63d07-fb5e-4534-a423-796d1b5b44af",
                    "tid": "jfiohaiohfj",
                    "washlet": washletLabelSwitch.isOn,
                    "wheelchair": wheelChairLabelSwitch.isOn,
                    "onlyFemale": onlyFemaleLabelSwitch.isOn,
                    "unisex": unisexLabelSwitch.isOn,
                    "makeuproom": makeroomLabelSwitch.isOn,
                    "milkspace" : milkspaceLabelSwitch.isOn,
                    "omutu": omutuLabelSwitch.isOn,
                    "ostomate" : ostomateLabelSwitch.isOn,
                    "japanesetoilet": japaneseToiletLabelSwitch.isOn,
                    "westerntoilet": westernToiletLabelSwitch.isOn,
                    "warmSeat": warmSeatLabelSwitch.isOn,
                    "baggageSpace": baggageSpaceLabelSwitch.isOn,
                    "howtoaccess": accessTextView.text,
                    "available": true,
                    "reviewCount": newReviewCount,
                    "addedBy": toilet.addedBy as String,
                    //"addedBy": FIRAuth.auth()!.currentUser!.uid,
                    //Addedby is not goona be this one
                    "editedBy": FIRAuth.auth()!.currentUser!.uid,
                    
                    "averageStar": "\(newAvStar)" as String,
                    "star1": Int(starView.rating),
                    "star2": toilet.star1 as Int,
                    "star3": toilet.star2 as Int,
                    "star4": toilet.star3 as Int,
                    "star5": toilet.star4 as Int,
                    "star6": toilet.star5 as Int,
                    "star7": toilet.star6 as Int,
                    "star8": toilet.star7 as Int,
                    "star9": toilet.star8 as Int,
                    "star10": toilet.star9 as Int,
                    "wait1": waitInt! as Int,
                    "wait2": toilet.wait1 as Int,
                    "wait3": toilet.wait2 as Int,
                    "wait4": toilet.wait3 as Int,
                    "wait5": toilet.wait4 as Int,
                    "averageWait": avWait as Int
            ]
            
            //"star1": starView.rating as Double, Not sure
            
            let toiletsRef = FIRDatabase.database().reference().child("Toilets")
            toiletsRef.child(name!).updateChildValues(tdata)
            //Firebase updating at 1 pm
            
            
            //Class information changes as well
            toilet.openinghours = availableTimeForDatabase as String
            toilet.type = placeCategoryLabel.text! as String
            toilet.star = starView.rating as Double
            toilet.reviewCount = newReviewCount as Int
            toilet.averageStar = "\(newAvStar)" as String
            toilet.averageWait = avWait as Int
            
            
            
            print("tdata = \(tdata)")
            print("toiletsRef data is saved!!")
            
            
            print("star=\(starView.rating as Double)")
            print("waitingtime=\(waitInt! as Int)")
            print("feedback =\(feedbackTextView.text as String)")
//            print("=\()")
//            print("=\()")
//            print("=\()")
//            print("=\()")
//            print("=\()")
            
            let rdata : [String : Any] = ["uid": FIRAuth.auth()!.currentUser!.uid , "tid": name as Any, "star": starView.rating as Double , "waitingtime": "\(waitInt! as Int)" ,"feedback": feedbackTextView.text as String, "available": true, "time": dateString, "timeNumbers":interval, "likedCount":0
            ]
            
            let databaseRef = FIRDatabase.database().reference()
            databaseRef.child("reviews").childByAutoId().setValue(rdata)
            
            uploadPhotosToDatabase(nameString: name!)

            performSegue(withIdentifier: "editTabletoDetailSegue", sender: nil)
            
        }
        

    
    
    
    
    
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "editPintoEditDetailSegue"{
//            let nextV = segue.destination as! EditTableViewController
//            
//            nextV.toilet.key = toilet.key
//            print("toilet.key = \(toilet.key)")
//        }
//    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        var uploadingPlace = mainImage
        
        if mainImageReplace == true{
            uploadingPlace = mainImage
        }
        if subImageReplace1 == true{
            uploadingPlace = subImage1
        }
        if subImageReplace2 == true{
            uploadingPlace = subImage2
        }
        
        uploadingPlace?.image = image
        uploadingPlace?.backgroundColor = UIColor.clear
        
       //        imageView.image = image
//        
//        imageView.backgroundColor = UIColor.clear
//        
        //nextButton.isEnabled = true
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    func uploadPhotosToDatabase(nameString : String){
        let databaseRef = FIRDatabase.database().reference()
        let imagesFolder = FIRStorage.storage().reference().child("images")
        //FIRDatabase
        
        let mainImageData = UIImageJPEGRepresentation(mainImage.image!, 0.1)!
        let subImageData1 = UIImageJPEGRepresentation(subImage1.image!, 0.1)!
        let subImageData2 = UIImageJPEGRepresentation(subImage2.image!, 0.1)!
        
        //this explicit value triggers some error!!
        
        print("uploadPhotosToDatabase")
      
        imagesFolder.child("\(nameString).urlOne.jpg").put(mainImageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(error)")
            } else {
                print("uploadPhotosToDatabase1")
                print(metadata?.downloadURL() as Any)
                let downloadURL = metadata!.downloadURL()!.absoluteString
                databaseRef.child("Toilets").child(nameString).updateChildValues(["urlOne": downloadURL])
                self.toilet.urlOne = downloadURL
  
            }
        })
        
        imagesFolder.child("\(nameString).urlTwo.jpg").put(subImageData1, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(error)")
            } else {
                
                print(metadata?.downloadURL() as Any)
                let downloadURL = metadata!.downloadURL()!.absoluteString
                databaseRef.child("Toilets").child(nameString).updateChildValues(["urlTwo": downloadURL])
                self.toilet.urlTwo = downloadURL
                
            }
        })

        
        imagesFolder.child("\(nameString).urlThree.jpg").put(subImageData2, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(error)")
            } else {
                
                print(metadata?.downloadURL() as Any)
                let downloadURL = metadata!.downloadURL()!.absoluteString
                databaseRef.child("Toilets").child(nameString).updateChildValues(["urlThree": downloadURL])
                self.toilet.urlThree = downloadURL

            }
        })
  
    }

    
    
    
    @IBAction func washletSwitchTapped(_ sender: Any) {
        if washletLabelSwitch.isOn == true {
            washletLabel.textColor = UIColor.black
            toilet.washlet = true
        }else{
            //wheelChairLabelSwitch.isOn == false
            washletLabel.textColor = UIColor.gray
            toilet.washlet = false
        }
    }
    
    @IBAction func wheelChairSwitchTapped(_ sender: Any) {
        if wheelChairLabelSwitch.isOn == true {
            wheelChairLabel.textColor = UIColor.black
            toilet.wheelchair = true
        }else{
            //wheelChairLabelSwitch.isOn == false
            wheelChairLabel.textColor = UIColor.gray
            toilet.wheelchair = false
        }
    }
    
    
    @IBAction func onlyFemaleSwitchTapped(_ sender: Any) {
        if onlyFemaleLabelSwitch.isOn == true {
            onlyFemaleLabel.textColor = UIColor.black
            toilet.onlyFemale = true
        }
        else{
            onlyFemaleLabel.textColor = UIColor.gray
            toilet.onlyFemale = false
        }
    }
    
    
    @IBAction func unisexSwitchTapped(_ sender: Any) {
        if unisexLabelSwitch.isOn == true {
            unisexLabel.textColor = UIColor.black
            toilet.unisex = true
        }else{
            unisexLabel.textColor = UIColor.gray
            toilet.unisex = false
        }

    }
   
    @IBAction func makeroomSwitchTapped(_ sender: Any) {
        if makeroomLabelSwitch.isOn == true {
            makeroomLabel.textColor = UIColor.black
            toilet.makeuproom = true
        }else{
            makeroomLabel.textColor = UIColor.gray
            toilet.makeuproom = false
        }
    }
    
    @IBAction func milkspaceSwitchTappd(_ sender: Any) {
        if milkspaceLabelSwitch.isOn == true {
            milkspaceLabel.textColor = UIColor.black
             toilet.milkspace = true
        }else{
            milkspaceLabel.textColor = UIColor.gray
            toilet.milkspace = false
        }
    }
    
    @IBAction func omutuSwitchTapped(_ sender: Any) {
        if omutuLabelSwitch.isOn == true{
            omutuLabel.textColor = UIColor.black
            toilet.omutu = true
        }else{
            
            omutuLabel.textColor = UIColor.gray
             toilet.omutu = false
        }
    }
    
   
    @IBAction func ostomateSwitchTapped(_ sender: Any) {
        if ostomateLabelSwitch.isOn == true {
            ostomateLabel.textColor = UIColor.black
             toilet.ostomate = true
        }else{
            ostomateLabel.textColor = UIColor.gray
            toilet.ostomate = false
        }
    }
   
    @IBAction func japaneseSwtichTapped(_ sender: Any) {
        if japaneseToiletLabelSwitch.isOn == true{
            japaneseToiletLabel.textColor = UIColor.black
            toilet.japanesetoilet = true
        }else{
            japaneseToiletLabel.textColor = UIColor.gray
            toilet.japanesetoilet = false

        }
    }
   
    
    @IBAction func westernSwtichTapped(_ sender: Any) {
        if westernToiletLabelSwitch.isOn == true{
            westernToiletLabel.textColor = UIColor.black
            toilet.westerntoilet = true

        }else{
            
            westernToiletLabel.textColor = UIColor.gray
            toilet.westerntoilet = false

        }
    }

    @IBAction func warmSeatSwitchTapped(_ sender: Any) {
        if warmSeatLabelSwitch.isOn == true{
            warmSeatLabel.textColor = UIColor.black
            toilet.warmSeat = true
        }else{
            
            warmSeatLabel.textColor = UIColor.gray
            toilet.warmSeat = false
        }
    }
    
    @IBAction func baggageSpaceSwitchTapped(_ sender: Any) {
        if baggageSpaceLabelSwitch.isOn == true{
            baggageSpaceLabel.textColor = UIColor.black
            toilet.baggageSpace = true
        }else{
            
            baggageSpaceLabel.textColor = UIColor.gray
            toilet.baggageSpace = false

        }
    }
}




