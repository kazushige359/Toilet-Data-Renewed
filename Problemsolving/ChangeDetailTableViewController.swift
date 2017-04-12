//
//  ChangeDetailTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 11/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import Cosmos
import MapKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ChangeDetailTableViewController: UITableViewController,UIPickerViewDelegate, UIPickerViewDataSource,MKMapViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    @IBOutlet weak var placeNameLabel: UITextField!
    
    @IBOutlet weak var placeCategoryLabel: UITextField!
    
    @IBOutlet weak var availableTimeLabel: UITextField!
    
    
    @IBOutlet weak var japaneseToiletSwitch: UISwitch!
    
    @IBOutlet weak var westernToiletSwitch: UISwitch!
    
    @IBOutlet weak var onlyFemalSwitch: UISwitch!
    
    @IBOutlet weak var unisexSwitch: UISwitch!
    
    @IBOutlet weak var washletSwitch: UISwitch!
    
    @IBOutlet weak var warmSeatSwitch: UISwitch!
    
    @IBOutlet weak var autoOpenBenkiSwitch: UISwitch!
    
    @IBOutlet weak var noVirusSwitch: UISwitch!
    
    @IBOutlet weak var paperForBenkiSwitch: UISwitch!
    
    
    @IBOutlet weak var cleanerBenkiSwitch: UISwitch!
    
    @IBOutlet weak var autoToiletWashSwitch: UISwitch!
    
    @IBOutlet weak var sensorHandWashSwitch: UISwitch!
    
    @IBOutlet weak var handSoapSwitch: UISwitch!
    
    
    @IBOutlet weak var autoHandSoapSwitch: UISwitch!
    
    @IBOutlet weak var paperTowelSwitch: UISwitch!
    
    @IBOutlet weak var handDrierSwitch: UISwitch!
    
    
    @IBOutlet weak var otohimeSwitch: UISwitch!
    
    
    @IBOutlet weak var napkinSellingSwitch: UISwitch!
    
    
    @IBOutlet weak var makeRoomSwitch: UISwitch!
    
    
    @IBOutlet weak var clothesSwitch: UISwitch!
    
    
    @IBOutlet weak var baggageSwitch: UISwitch!
    
    
    @IBOutlet weak var wheelChairSwitch: UISwitch!
    
    
    
    @IBOutlet weak var wheelChiarAccess: UISwitch!
    
    
    @IBOutlet weak var handRailSwitch: UISwitch!
    
    
    @IBOutlet weak var callHelpSwitch: UISwitch!
    
    
    @IBOutlet weak var ostomateSwitch: UISwitch!
    
    
    @IBOutlet weak var writtenEnglishSwitch: UISwitch!
    
    
    @IBOutlet weak var brailleSwitch: UISwitch!
    
    @IBOutlet weak var voiceGuideSwitch: UISwitch!
    
    
    @IBOutlet weak var toiletFancySwitch: UISwitch!
    
    
    @IBOutlet weak var toiletSmellGood: UISwitch!
    
    
    @IBOutlet weak var toiletWideSpaceSwitch: UISwitch!
    
    
    @IBOutlet weak var noNeedAskSwitch: UISwitch!
    
    
    @IBOutlet weak var parkingSwitch: UISwitch!
    
    
    @IBOutlet weak var airConditionSwitch: UISwitch!
    
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    
    @IBOutlet weak var milkSpaceSwitch: UISwitch!
    
    
    
    @IBOutlet weak var onlyFamaleBabyRoom: UISwitch!
    
    
    @IBOutlet weak var babyRoomMaleEnterSwitch: UISwitch!
    
    
    @IBOutlet weak var babyRoomPersonalSpace: UISwitch!
    
    
    @IBOutlet weak var babyRoomPersonalWithLock: UISwitch!
    
    
    @IBOutlet weak var babyRoomWideSpaceSwitch: UISwitch!
    
    
    @IBOutlet weak var babyCarRentalSwitch: UISwitch!
    
    
    @IBOutlet weak var babyCarAccessSwitch: UISwitch!
    
    
    @IBOutlet weak var omutuSwitch: UISwitch!
    
    
    @IBOutlet weak var hipWashingStuffSwitch: UISwitch!
    
    @IBOutlet weak var omutuTrashCanSwitch: UISwitch!
    
    @IBOutlet weak var omutuSellingSwitch: UISwitch!
    
    
    @IBOutlet weak var babyRoomSinkSwitch: UISwitch!
    
    @IBOutlet weak var babyWashStandSwitch: UISwitch!
    
    @IBOutlet weak var babyRoomHotWaterSwitch: UISwitch!
    
    @IBOutlet weak var babyRoomMicrowaveSwitch: UISwitch!
    
    @IBOutlet weak var babyRoomSellingWaterSwitch: UISwitch!
    
    @IBOutlet weak var babyRoomFoodSellingSwitch: UISwitch!
    
    
    @IBOutlet weak var babyRoomEatingSpace: UISwitch!
    
    
    @IBOutlet weak var babyChairSwitch: UISwitch!
    
    @IBOutlet weak var soffaSwitch: UISwitch!
    
    
    @IBOutlet weak var kidsToiletSwitch: UISwitch!
    
    @IBOutlet weak var kidsSpaceSwitch: UISwitch!
    
    
    @IBOutlet weak var heightMeasureSwitch: UISwitch!
    
    @IBOutlet weak var weightMeasureSwitch: UISwitch!
    
    
    @IBOutlet weak var babyToySwitch: UISwitch!
    
    @IBOutlet weak var babyRoomFancySwitch: UISwitch!
    
    @IBOutlet weak var babyRoomGoodSmellSwitch: UISwitch!
    
  
    
    @IBOutlet weak var accessTextView: UITextView!
    
    
    @IBOutlet weak var starView: CosmosView!
    
    @IBOutlet weak var waitMinutesLabel: UITextField!
    
    @IBOutlet weak var feedbackTextView: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!

    
    @IBOutlet weak var setPinButton: UIButton!
    
    @IBOutlet weak var addPictureButton: UIButton!
    
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var subImageOne: UIImageView!
    
    @IBOutlet weak var subImageTwo: UIImageView!
    
    
    var pickOption = ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24","25","26", "27", "28","29","30"]
    
    var categoryOption = ["公衆トイレ","コンビニ","カフェ","レストラン","商業施設","観光地・スタジアム","仮設トイレ"]

    
    var availableTimeOption = [
        ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24"],
    ["00", "15","30","45"],
    ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24"],
    ["00", "15","30","45"]
    ]
    
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
    
    var imagePicker = UIImagePickerController()
    
    var mainImageReplace = false
    var subImageReplace1 = false
    var subImageReplace2 = false
    
    
    
//    let availableTimeForDatabase = "\(time1):\(time2)〜\(time3):\(time4)"
    
    var pincoodinate = CLLocationCoordinate2D()
    
    var geoFire: GeoFire!
    var geoFireRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.isUserInteractionEnabled = false
        
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        waitMinutesLabel.inputView = pickerView1
        placeCategoryLabel.inputView = pickerView2
        availableTimeLabel.inputView = pickerView3
       
        imagePicker.delegate = self
        
        mainImageView.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fimage-add-button.png?alt=media&token=3f65b9db-d269-4ea2-aedd-e8f36daa7e8f"))
        subImageOne.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fimage-add-button.png?alt=media&token=3f65b9db-d269-4ea2-aedd-e8f36daa7e8f"))
        subImageTwo.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fimage-add-button.png?alt=media&token=3f65b9db-d269-4ea2-aedd-e8f36daa7e8f"))
        
        //Commneted 4pm 5 Feb
       
//        
//        washletLabelSwitch.isOn = false
//        wheelChairLabelSwitch.isOn = false
//        onlyFemaleLabelSwitch.isOn = false
//        unisexLabelSwitch.isOn = false
//        makeroomLabelSwitch.isOn = false
//        milkspaceLabelSwitch.isOn = false
//        omutuLabelSwitch.isOn = false
//        ostomateLabelSwitch.isOn = false
//        japaneseToiletLabelSwitch.isOn = false
//        westernToiletLabelSwitch.isOn = false
//        warmToiletLabelSwitch.isOn = false
//        baggageSpaceLabelSwitch.isOn = false
        
        starView.rating = 3.0
        starView.settings.filledColor = UIColor.yellow
        starView.settings.emptyBorderColor = UIColor.orange
        starView.settings.filledBorderColor = UIColor.orange

        
        
         let pinAnnotation = MKPointAnnotation()
         pinAnnotation.coordinate = pincoodinate
         mapView.addAnnotation(pinAnnotation)
        
//         let coord = locationManager.location?.coordinate
//        //coord is gonna be the place of pin
         let region = MKCoordinateRegionMakeWithDistance(pincoodinate, 1300, 1300)
        //500 to 300
         mapView.setRegion(region, animated: true)
        
//         washletLabel.textColor = UIColor.gray
//         wheelChairLabel.textColor = UIColor.gray
//         onlyFemaleLabel.textColor = UIColor.gray
//         unisexLabel.textColor = UIColor.gray
//         makeroomLabel.textColor = UIColor.gray
//         milkspaceLabel.textColor = UIColor.gray
//         omutuLabel.textColor = UIColor.gray
//         ostomateLabel.textColor = UIColor.gray
//         japaneseToiletLabel.textColor = UIColor.gray
//         westernToiletLabel.textColor = UIColor.gray
//         warmToiletLabel.textColor = UIColor.gray
//         baggageSpaceLabel.textColor = UIColor.gray
        
       
        
       

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangeDetailTableViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)


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
    }
    
    
    @IBAction func setPinTapped(_ sender: Any) {
        
         performSegue(withIdentifier:"backTopinSegue", sender: nil)
        //I nedd to add here
       
        //Not sure its connected
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

        //print(placeNameLabel.text)
    }
    
    func photoUpload(){
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        
        self.present(self.imagePicker, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        var uploadingPlace = mainImageView
        
        if mainImageReplace == true{
            uploadingPlace = mainImageView
        }
        if subImageReplace1 == true{
            uploadingPlace = subImageOne
        }
        if subImageReplace2 == true{
            uploadingPlace = subImageTwo
        }
        
        uploadingPlace?.image = image
        uploadingPlace?.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }

    
    func updateFirebase(){
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
            
            print("Star ratingggggg \(starView.rating)")
            let date = NSDate()
            let calendar = Calendar.current

            let day = calendar.component(.day, from:date as Date)
            let month = calendar.component(.month, from:date as Date)
            let year = calendar.component(.year, from:date as Date)
            let dateString = "\(year)年\(month)月\(day)日"
            
            let interval = NSDate().timeIntervalSince1970
            
            //maybe when waitminute wasnt written aything then waitminute = 0  
            
            ///tid does not make any sense 
            
//....     ////Copied from Android
            
            
           // let tdata : [String : Any] = [
//            "name":
//            "openAndCloseHours"
//            "type"
//            "urlOne"
//            "urlTwo"
//            "urlThree"
//            "addedBy"
//            "editedBy"
//            "averageStar"
//            "address"
//            "howtoaccess"
        //      "reviewOne"
            //      "reviewTwo"
            
//            
//            "openHours"
//            "closeHours"
//            "reviewCount"
//            "averageWait"
//            "toiletFloor"
//            "latitude"
//            "longitude"
            
            "available": true,
            "japanesetoilet": japaneseToiletSwitch.isOn,
            "westerntoilet":westernToiletSwitch.isOn,
            "onlyFemale":onlyFemalSwitch.isOn,
            "unisex":unisexSwitch.isOn,
            
            "washlet":washletSwitch.isOn,
            "warmSeat":warmSeatSwitch.isOn,
            "autoOpen":autoOpenBenkiSwitch.isOn,
            "noVirus":noVirusSwitch.isOn,
            "paperForBenki":paperForBenkiSwitch.isOn,
            "cleanerForBenki":cleanerBenkiSwitch.isOn,
            "nonTouchWash":autoToiletWashSwitch.isOn,
            
            "sensorHandWash":sensorHandWashSwitch.isOn,
            "handSoap":handSoapSwitch.isOn,
            "nonTouchHandSoap":autoHandSoapSwitch.isOn,
            "paperTowel":paperTowelSwitch.isOn,
            "handDrier":handDrierSwitch.isOn,
            
            "otohime":otohimeSwitch.isOn,
            "napkinSelling":napkinSellingSwitch.isOn,
            "makeuproom":makeRoomSwitch.isOn,
            "clothes":clothesSwitch.isOn,
            "baggageSpace":baggageSwitch.isOn,
            
            "wheelchair":wheelChairSwitch.isOn,
            "wheelchairAccess":wheelChiarAccess.isOn,
            "handrail":handRailSwitch.isOn,
            "callHelp":callHelpSwitch.isOn,
            "ostomate":ostomateSwitch.isOn,
            "english":writtenEnglishSwitch.isOn,
            "braille":brailleSwitch.isOn,
            "voiceGuide":voiceGuideSwitch.isOn,
            
            "fancy":toiletFancySwitch.isOn,
            "smell":toiletSmellGood.isOn,
            "confortable":toiletWideSpaceSwitch.isOn,
            "noNeedAsk":noNeedAskSwitch.isOn,
            "parking":parkingSwitch.isOn,
            "airCondition":airConditionSwitch.isOn,
            "wifi":wifiSwitch.isOn,
            
            "milkspace":milkSpaceSwitch.isOn,
            "babyRoomOnlyFemale":onlyFamaleBabyRoom.isOn,
            "babyRoomMaleEnter":babyRoomMaleEnterSwitch.isOn,
            "babyRoomPersonalSpace":babyRoomPersonalSpace.isOn,
            "babyRoomPersonalSpaceWithLock":babyRoomPersonalWithLock.isOn,
            "babyRoomWideSpace":babyRoomWideSpaceSwitch.isOn,
            
            "babyCarRental":babyCarRentalSwitch.isOn,
            "babyCarAccess":babyCarAccessSwitch.isOn,
            "omutu":omutuSwitch.isOn,
            "hipCleaningStuff":hipWashingStuffSwitch.isOn,
            "omutuTrashCan":omutuTrashCanSwitch.isOn,
            "omutuSelling":omutuSellingSwitch.isOn,
            
            "babySink":babyRoomSinkSwitch.isOn,
            "babyWashstand":babyWashStandSwitch.isOn,
            "babyHotwater":babyRoomHotWaterSwitch.isOn,
            "babyMicrowave":babyRoomMicrowaveSwitch.isOn,
            "babyWaterSelling":babyRoomSellingWaterSwitch.isOn,
            "babyFoodSelling":babyRoomFoodSellingSwitch.isOn,
            "babyEatingSpace":babyRoomEatingSpace.isOn,
            
            "babyChair":babyChairSwitch.isOn,
            "babySoffa":soffaSwitch.isOn,
            "kidsToilet":kidsToiletSwitch.isOn,
            "kidsSpace":kidsSpaceSwitch.isOn,
            "babyHeight":heightMeasureSwitch.isOn,
            "babyWeight":weightMeasureSwitch.isOn,
            "babyToy":babyToySwitch.isOn,
            "babyFancy":babyRoomFancySwitch.isOn,
            "babySmellGood":babyRoomGoodSmellSwitch.isOn,
            
            
            
            
//.....            ////Copied from Android  April 12
//            let tdata : [String : Any] =
//                ["name": name as Any,
//                 "openinghours": availableTimeForDatabase as String,
//                 "type": placeCategoryLabel.text! as String,
//                 "star": starView.rating as Double,
//                 "waitingtime": waitInt! as Int,
//                 //Should be Int
//                    "urlOne": "",
//                    "urlTwo":"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2FFamilyMart.picture.jpg?alt=media&token=0de63d07-fb5e-4534-a423-796d1b5b44af",
//                    "urlThree":"https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2FFamilyMart.picture.jpg?alt=media&token=0de63d07-fb5e-4534-a423-796d1b5b44af",
//                    "tid": "jfiohaiohfj",
//                    "washlet": washletLabelSwitch.isOn,
//                    "wheelchair": wheelChairLabelSwitch.isOn,
//                    "onlyFemale": onlyFemaleLabelSwitch.isOn,
//                    "unisex": unisexLabelSwitch.isOn,
//                    "makeuproom": makeroomLabelSwitch.isOn,
//                    "milkspace" : milkspaceLabelSwitch.isOn,
//                    "omutu": omutuLabelSwitch.isOn,
//                    "ostomate" : ostomateLabelSwitch.isOn,
//                    "japanesetoilet": japaneseToiletLabelSwitch.isOn,
//                    "westerntoilet": westernToiletLabelSwitch.isOn,
//                    "warmSeat": warmToiletLabelSwitch.isOn,
//                    "baggageSpace": baggageSpaceLabelSwitch.isOn,
//                    "howtoaccess": accessTextView.text,
//                    "available": true,
//                    "reviewCount": 1,
//                    "addedBy": FIRAuth.auth()!.currentUser!.uid,
//                    "editedBy": FIRAuth.auth()!.currentUser!.uid,
//                    "averageStar": "\(starView.rating)",
//                        //as Double,
//                    "star1": Int(starView.rating),
//                    "star2": 0,
//                    "star3": 0,
//                    "star4": 0,
//                    "star5": 0,
//                    "star6": 0,
//                    "star7": 0,
//                    "star8": 0,
//                    "star9": 0,
//                    "star10": 0,
//                    "wait1": waitInt! as Int,
//                    "wait2": 0,
//                    "wait3": 0,
//                    "wait4": 0,
//                    "wait5": 0,
//                    "averageWait": waitInt! as Int
//            ]
            
            let rdata : [String : Any] =
                ["star": starView.rating as Double,
                 "waitingtime": waitminute as String,
                    "tid": name! as String,
                    "available": true,
                    "feedback": feedbackTextView.text as String,
                    "uid": FIRAuth.auth()!.currentUser!.uid as String,
                    "likedCount": 0,
                    "time": dateString,
                    "timeNumbers": interval
                    
                                ]

            
            let toiletsRef = FIRDatabase.database().reference().child("Toilets")
            //toiletsRef.child(name!).setValue(tdata)
            
            
            
            
            let reviewsRef = FIRDatabase.database().reference().child("reviews")
            reviewsRef.childByAutoId().setValue(rdata)
            
            FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("youPosted").child(name!).setValue(true)
            //self.toiletsRef.child(location["name"] as! String!).setValue(tdata)
            //print("tdata = \(tdata)")
            print("toiletsRef data is saved!!")
            
            uploadPhotosToDatabase(nameString: name!)
            performSegue(withIdentifier: "addedToiletToNewAcSegue", sender: nil)
            
        }
    
    }
    
    
    func uploadPhotosToDatabase(nameString : String){
        let databaseRef = FIRDatabase.database().reference()
        let imagesFolder = FIRStorage.storage().reference().child("images")
        //FIRDatabase
        
        let mainImageData = UIImageJPEGRepresentation(mainImageView.image!, 0.1)!
        let subImageData1 = UIImageJPEGRepresentation(subImageOne.image!, 0.1)!
        let subImageData2 = UIImageJPEGRepresentation(subImageTwo.image!, 0.1)!
        
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
                
            }
        })
        
    }
    @IBAction func postButtonTapped(_ sender: Any) {
        updateFirebase()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "cancelAndBackToAccountSegue", sender: nil)
    }
    
    @IBAction func postTabTapped(_ sender: Any) {
        updateFirebase()
    }
    
    
    
//    @IBAction func washletButtonTapped(_ sender: Any) {
//        if washletLabelSwitch.isOn == true {
//            washletLabel.textColor = UIColor.black
//        }else{
//            //wheelChairLabelSwitch.isOn == false
//            washletLabel.textColor = UIColor.gray
//        }
//    }
//    
//    @IBAction func wheelChairButtonTapped(_ sender: Any) {
//        if wheelChairLabelSwitch.isOn == true {
//            wheelChairLabel.textColor = UIColor.black
//        }else{
//            //wheelChairLabelSwitch.isOn == false
//             wheelChairLabel.textColor = UIColor.gray
//            
//        }}
//   
//    @IBAction func onlyFemaleButtonTapped(_ sender: Any) {
//        if onlyFemaleLabelSwitch.isOn == true {
//            onlyFemaleLabel.textColor = UIColor.black
//        }
//        else{
//            onlyFemaleLabel.textColor = UIColor.gray
//        }
//    }
//   
//    @IBAction func unisexButtonTapped(_ sender: Any) {
//        if unisexLabelSwitch.isOn == true {
//            unisexLabel.textColor = UIColor.black
//        }else{
//            unisexLabel.textColor = UIColor.gray
//        }
//    }
//    
//   
//    @IBAction func makeroomButtonTapped(_ sender: Any) {
//        if makeroomLabelSwitch.isOn == true {
//            makeroomLabel.textColor = UIColor.black
//        }else{
//            makeroomLabel.textColor = UIColor.gray
//        }
//    }
//    
//    @IBAction func milkspaceButtonTapped(_ sender: Any) {
//        if milkspaceLabelSwitch.isOn == true {
//            milkspaceLabel.textColor = UIColor.black
//        }else{
//            milkspaceLabel.textColor = UIColor.gray
//        }
//    }
//    
//    
//    @IBAction func omutuButtonTapped(_ sender: Any) {
//        if omutuLabelSwitch.isOn == true{
//            omutuLabel.textColor = UIColor.black
//        }else{
//            
//            omutuLabel.textColor = UIColor.gray
//        }
//
//    }
//   
//    @IBAction func ostomateButtonTapped(_ sender: Any) {
//        if ostomateLabelSwitch.isOn == true {
//            ostomateLabel.textColor = UIColor.black
//        }else{
//            ostomateLabel.textColor = UIColor.gray
//        }
//
//    }
//
//    @IBAction func japaneseButtonTapped(_ sender: Any) {
//        if japaneseToiletLabelSwitch.isOn == true{
//            japaneseToiletLabel.textColor = UIColor.black
//        }else{
//            japaneseToiletLabel.textColor = UIColor.gray
//        }
//
//    }
//   
//    @IBAction func westernButtonTapped(_ sender: Any) {
//        if westernToiletLabelSwitch.isOn == true{
//            westernToiletLabel.textColor = UIColor.black
//        }else{
//            
//            westernToiletLabel.textColor = UIColor.gray
//        }
//    }
//  
//    @IBAction func warmSeatButtonTapped(_ sender: Any) {
//        if warmToiletLabelSwitch.isOn == true{
//            warmToiletLabel.textColor = UIColor.black
//        }else{
//            
//            warmToiletLabel.textColor = UIColor.gray
//        }
//    }
//    
//    @IBAction func baggageSpaceButtonTapped(_ sender: Any) {
//        
//        if baggageSpaceLabelSwitch.isOn == true{
//            baggageSpaceLabel.textColor = UIColor.black
//        }else{
//            
//            baggageSpaceLabel.textColor = UIColor.gray
//        }
//
//    }
//    
    
   
    
    

    
}
