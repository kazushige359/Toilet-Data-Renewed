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
    
    
    
    //Other things one
    @IBOutlet weak var toiletFancySwitch: UISwitch!
    @IBOutlet weak var toiletSmellGood: UISwitch!
    @IBOutlet weak var toiletWideSpaceSwitch: UISwitch!
    @IBOutlet weak var clothesSwitch: UISwitch!
    @IBOutlet weak var baggageSwitch: UISwitch!
    
    
    //Other things two 
    
    @IBOutlet weak var noNeedAskSwitch: UISwitch!
    @IBOutlet weak var writtenEnglishSwitch: UISwitch!
    @IBOutlet weak var parkingSwitch: UISwitch!
    @IBOutlet weak var airConditionSwitch: UISwitch!
    @IBOutlet weak var wifiSwitch: UISwitch!

    
    
    //For ladys 
    
    @IBOutlet weak var otohimeSwitch: UISwitch!
    @IBOutlet weak var napkinSellingSwitch: UISwitch!
    @IBOutlet weak var makeRoomSwitch: UISwitch!
    @IBOutlet weak var ladyOmutuSwitch: UISwitch!
    @IBOutlet weak var ladyBabyChairSwitch: UISwitch!
    @IBOutlet weak var ladyBabyChairGoodSwitch: UISwitch!
    @IBOutlet weak var ladyBabyCarAccessSwitch: UISwitch!
    
    
    //For men 
    
    @IBOutlet weak var maleOmutuSwitch: UISwitch!
    @IBOutlet weak var maleBabyChairSwitch: UISwitch!
    @IBOutlet weak var maleBabyChairGoodSwitch: UISwitch!
    @IBOutlet weak var maleBabyCarAccess: UISwitch!
    
    
    
    
    
    //For family 

    
    
    @IBOutlet weak var wheelChairSwitch: UISwitch!
    @IBOutlet weak var wheelChiarAccess: UISwitch!
    @IBOutlet weak var autoDoorSwitch: UISwitch!
    @IBOutlet weak var callHelpSwitch: UISwitch!
    @IBOutlet weak var ostomateSwitch: UISwitch!
    @IBOutlet weak var brailleSwitch: UISwitch!
    @IBOutlet weak var voiceGuideSwitch: UISwitch!
    
    @IBOutlet weak var familyOmutuSwitch: UISwitch!
    
    @IBOutlet weak var familyBabyChairSwitch: UISwitch!
    
    
    
    
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
    
    var mainImageChanged = false
    var subImageOneChanged = false
    var subImageTwoChanged = false
    
    let toiletNewId = UUID().uuidString
    let reviewNewId = UUID().uuidString
    
    
    
    
    var pickOption = ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24","25","26", "27", "28","29","30"]
    
    var categoryOption = ["公衆トイレ","コンビニ","カフェ","レストラン","商業施設","観光地・スタジアム","仮設トイレ","一般家庭(断水時のみ)"]

    
    var availableTimeOption = [
        ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24","25","26", "27", "28","29","30"],
    ["00", "15","30","45"],
    ["0","1", "2", "3","4","5","6", "7", "8","9","10","11", "12", "13","14","15","16", "17", "18","19","20","21", "22", "23","24","25","26", "27", "28","29","30"],
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
    
    let interval = NSDate().timeIntervalSince1970
    let uid = FIRAuth.auth()!.currentUser!.uid
    
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
        
//        mainImageView.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fimage-add-button.png?alt=media&token=3f65b9db-d269-4ea2-aedd-e8f36daa7e8f"))
//        subImageOne.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fimage-add-button.png?alt=media&token=3f65b9db-d269-4ea2-aedd-e8f36daa7e8f"))
//        subImageTwo.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fimage-add-button.png?alt=media&token=3f65b9db-d269-4ea2-aedd-e8f36daa7e8f"))
        
        
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
            mainImageChanged = true
        }
        if subImageReplace1 == true{
            uploadingPlace = subImageOne
            subImageOneChanged = true
        }
        if subImageReplace2 == true{
            uploadingPlace = subImageTwo
            subImageTwoChanged = true
        }
        
        uploadingPlace?.image = image
        uploadingPlace?.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }

    
    func startUpload(){
        
        let lat: CLLocationDegrees = pincoodinate.latitude
        let lon: CLLocationDegrees = pincoodinate.longitude
        
        print("getAddressCalled")
        var addressString = ""
        let location = CLLocation(latitude: lat, longitude: lon) //changed!!!
        print(location)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                print("Problem Reverse geocoder failed with error" + (error?.localizedDescription)!)
                self.toiletDataUpload(Address: "")
                
                //func call??
                
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                //addressString = "\(pm!.thoroughfare)\(pm!.postalCode)\(pm!.locality)\(pm!.country)"
                addressString =  (pm?.locality)! + "/" + (pm?.thoroughfare)! + "/" + (pm?.name)!
                
                //addressString = String(describing: pm?.locality)
                self.toiletDataUpload(Address: addressString)

                
                print("addressStringGetAddress: \(addressString)")
                
                //func call??
                // print(pm?.locality ?? <#default value#>)
            }
            else {
                print("Problem with the data received from geocoder")
                self.toiletDataUpload(Address: "")

                
                //func call??
            }
        })
        
        
    }
    

    
    func toiletDataUpload(Address: String){
        
        
        
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
                feedbackTextView.text = ""
                
            }
           
            let Lat: CLLocationDegrees = pincoodinate.latitude
            let Lon: CLLocationDegrees = pincoodinate.longitude
            
            
            
           
            
            
            
            let waitInt:Int? = Int(waitminute)
            let availableTimeForDatabase = "\(time1):\(time2)〜\(time3):\(time4)"
            print("after geoFire.setLocation")
            
            print("Star ratingggggg \(starView.rating)")
            
            
            let tdata : [String : Any] = ["name":name!,
            "openAndCloseHours": availableTimeForDatabase as String,
            "type": 0,
            "urlOne":"" as String,
            "urlTwo":"" as String,
            "urlThree":"" as String,
            "addedBy":uid,
            "editedBy":uid,
            "averageStar":String(starView.rating) as String,
            "address":Address as String,
            "howtoaccess":"" as String,
            "reviewOne":reviewNewId,
            "reviewTwo":"",
            "openHours":5000 as Int,
            "closeHours":5000 as Int,
            "reviewCount":1,
            "averageWait": waitInt! as Int,
            "toiletFloor": 1,
            "latitude": Lat as Double,
            "longitude": Lon as Double,
            "available": true,
            "japanesetoilet": japaneseToiletSwitch.isOn as Bool,
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
            
            //For other one
                "fancy":toiletFancySwitch.isOn,
                "smell":toiletSmellGood.isOn,
                "confortable":toiletWideSpaceSwitch.isOn,
                "clothes":clothesSwitch.isOn,
                "baggageSpace":baggageSwitch.isOn,
                
            //For other two
                "noNeedAsk":noNeedAskSwitch.isOn,
                "english":writtenEnglishSwitch.isOn,
                "parking":parkingSwitch.isOn,
                "airCondition":airConditionSwitch.isOn,
                "wifi":wifiSwitch.isOn,
                
            //For lady
                "otohime":otohimeSwitch.isOn,
                "napkinSelling":napkinSellingSwitch.isOn,
                "makeuproom":makeRoomSwitch.isOn,
                "ladyOmutu":ladyOmutuSwitch.isOn,
                "ladyBabyChair": ladyBabyChairSwitch.isOn,
                "ladyBabyChairGood": ladyBabyChairGoodSwitch.isOn,
                "ladyBabyCarAccess": ladyBabyCarAccessSwitch.isOn,
            //For male 
                "maleOmutu": maleOmutuSwitch.isOn,
                "maleBabyChair": maleBabyChairSwitch.isOn,
                "maleBabyChairGood": maleBabyChairGoodSwitch.isOn,
                "maleBabyCarAccess": maleBabyCarAccess.isOn,
                
            //For family
            
            
            "wheelchair":wheelChairSwitch.isOn,
            "wheelchairAccess":wheelChiarAccess.isOn,
            "autoDoor":autoDoorSwitch.isOn,
            "callHelp":callHelpSwitch.isOn,
            "ostomate":ostomateSwitch.isOn,
            "braille":brailleSwitch.isOn,
            "voiceGuide":voiceGuideSwitch.isOn,
            "familyOmutu": familyOmutuSwitch.isOn,
            "familyBabyChair": familyBabyChairSwitch.isOn,
            
            
            
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
            "babySmellGood":babyRoomGoodSmellSwitch.isOn] as [String : Any]
           
            
            let toiletsRef = FIRDatabase.database().reference().child("Toilets")
            let uniqueRef = toiletsRef.child(toiletNewId)
            
            uniqueRef.setValue(tdata)
            
//            let generatedTid = uniqueRef.key
            
            
            
        
            //toiletsRef.setValue(post)
            
            
            geoFire!.setLocation(CLLocation(latitude: Lat, longitude: Lon), forKey: toiletNewId){(error) in
                if (error != nil) {
                    print("An error occured: \(String(describing: error))")
                    print("in geoFire.setLocation")
                } else {
                    print("Saved location successfully!")
                    print("in geoFire.setLocation")
                }
            }

            
            reviewDataUpload()
            uploadPhotosToDatabase()
            performSegue(withIdentifier: "addedToiletToNewAcSegue", sender: nil)
            
        }
    
    }
    
    func reviewDataUpload(){
        
        if waitMinutesLabel.text == ""{
            waitminute = "0"
        }
        if feedbackTextView.text == ""{
            feedbackTextView.text = ""
            
        }
        
        
        let date = NSDate()
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from:date as Date)
        let month = calendar.component(.month, from:date as Date)
        let year = calendar.component(.year, from:date as Date)
        
        let dateString = "\(year)-\(month)-\(day)"
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        
        
        let interval = NSDate().timeIntervalSince1970
        
        
        
        let reviewData : [String : Any] = ["uid": uid , "tid": toiletNewId, "star": String(starView.rating) as String, "waitingtime": self.waitminute ,"feedback": feedbackTextView.text as String, "available": true, "time": dateString, "timeNumbers":interval, "likedCount":0
        ]
        
        let reviewRef = FIRDatabase.database().reference().child("ReviewInfo").child(reviewNewId)
        
        reviewRef.setValue(reviewData)
        
        
        //let rid = reviewRef.key
        
        
        let reviewListRef = FIRDatabase.database().reference().child("ReviewList").child(uid)
        
        reviewListRef.child(reviewNewId).setValue(true)
        
        let toiletReviewsRef = FIRDatabase.database().reference().child("ToiletReviews").child(toiletNewId)
        
        toiletReviewsRef.child(reviewNewId).setValue(true)
        
    }
    
    
    func uploadPhotosToDatabase(){
        let databaseRef = FIRDatabase.database().reference()
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
        let photoRef = FIRDatabase.database().reference().child("Images")

        if mainImageChanged == true{
            //upload main image pircute
        
        let mainImageData = UIImageJPEGRepresentation(mainImageView.image!, 0.1)!
        let mainUuid = UUID().uuidString
        
        imagesFolder.child("\(mainUuid).jpg").put(mainImageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(String(describing: error))")
            } else {
                print("uploadPhotosToDatabase1")
                print(metadata?.downloadURL() as Any)
                let downloadURL = metadata!.downloadURL()!.absoluteString
                databaseRef.child("Toilets").child(self.toiletNewId).updateChildValues(["urlOne": downloadURL])
                
            }
        })
            photoRef.child(mainUuid).setValue(uid)
            
        }
        
        if subImageOneChanged == true{
            //upload sub image One pircute

        
         let subImageData1 = UIImageJPEGRepresentation(subImageOne.image!, 0.1)!
         let subOneUuid = UUID().uuidString
        
        imagesFolder.child("\(subOneUuid).jpg").put(subImageData1, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(String(describing: error))")
            } else {
                
                print(metadata?.downloadURL() as Any)
                let downloadURL = metadata!.downloadURL()!.absoluteString
                databaseRef.child("Toilets").child(self.toiletNewId).updateChildValues(["urlTwo": downloadURL])
                
            }
        })
            
            photoRef.child(subOneUuid).setValue(uid)
        }
        
        if subImageTwoChanged == true{
            //upload sub image Two pircute
        
        let subImageData2 = UIImageJPEGRepresentation(subImageTwo.image!, 0.1)!
        let subTwoUuid = UUID().uuidString
        
        imagesFolder.child("\(subTwoUuid).jpg").put(subImageData2, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(String(describing: error))")
            } else {
                
                print(metadata?.downloadURL() as Any)
                let downloadURL = metadata!.downloadURL()!.absoluteString
                databaseRef.child("Toilets").child(self.toiletNewId).updateChildValues(["urlThree": downloadURL])
                
            }
        })
            photoRef.child(subTwoUuid).setValue(uid)
            
        }
        
    }
    
    
    @IBAction func postButtonTapped(_ sender: Any) {
        startUpload()
        //toiletDataUpload()
       // updateFirebase()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "cancelAndBackToAccountSegue", sender: nil)
    }
    
    @IBAction func postTabTapped(_ sender: Any) {
        startUpload()
        //toiletDataUpload()
        //updateFirebase()
    }
    
    

    
}
