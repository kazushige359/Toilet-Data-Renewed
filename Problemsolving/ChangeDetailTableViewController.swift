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
    
    @IBOutlet weak var toiletFloorPickLabel: UITextField!
    
    
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
    
    var toiletNewId = UUID().uuidString
    var reviewNewId = UUID().uuidString
    //changed let to var for caluculating storage cost
    
    
    var floorOption = ["地下3階","地下2階","地下1階","1階","2階","3階","4階","5階","6階","7階","8階","9階","10階","11階","12階","13階","14階","15階","16階","17階","18階"]
    
    
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
    let pickerView4 = UIPickerView()
    
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
    
    var newUrlOne = ""
    var newUrlTwo = ""
    var newUrlThree = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.isUserInteractionEnabled = false
        
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        pickerView4.delegate = self
        waitMinutesLabel.inputView = pickerView1
        placeCategoryLabel.inputView = pickerView2
        availableTimeLabel.inputView = pickerView3
        toiletFloorPickLabel.inputView = pickerView4
        
        imagePicker.delegate = self
        
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
        
        if pickerView == pickerView4{
            returnNumber = 1
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
        
        if pickerView == pickerView4 {
            //print("pickerView2")
            returnCount = floorOption.count
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
        
        if pickerView == pickerView4 {
            //print("pickerView3")
            pickedOption = floorOption[row]
            
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
        
        if pickerView == pickerView4 {
            toiletFloorPickLabel.text = floorOption[row]
        }
        
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
         print("photoUpload 444 called")
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        
        self.present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        var uploadingPlace = mainImageView
        
        print("image picker 444 called")
        
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
        
        uploadPhotosToDatabase()
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
                //self.toiletDataUpload(Address: "")
                
                //Test 100
//                var number = 1
//                while number < 100 {
//                    number = number + 1
//                    self.toiletNewId = String(number)
//                    self.toiletDataUpload(Address: "")
//                    
//                }
                
                 self.toiletDataUpload(Address: "")
                
                //Test 100
                
                //func call??
                
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                //addressString = "\(pm!.thoroughfare)\(pm!.postalCode)\(pm!.locality)\(pm!.country)"
                
                if pm?.locality != nil {
                    addressString = addressString + (pm?.locality!)! + "/"
                }
                if pm?.thoroughfare != nil {
                    addressString = addressString + (pm?.thoroughfare!)! + "/"
                }
                if pm?.name != nil {
                    addressString = addressString + (pm?.name!)!
                }
                
                
                
               // addressString =  (pm?.locality)! + "/" + (pm?.thoroughfare)! + "/" + (pm?.name)!
                
                //This gives me an error
                
                //addressString = String(describing: pm?.locality)
                
                
                
                //Test 100
//                var number = 1
//                while number < 100 {
//                    number = number + 1
//                    self.toiletNewId = String(number)
//                    self.toiletDataUpload(Address: addressString)
//                
//                }
                
                //Test 100
                self.toiletDataUpload(Address: addressString)

                
                
                
                //self.toiletDataUpload(Address: addressString)
                
                
                
                
                
                
                
                print("addressStringGetAddress: \(addressString)")
                
                //func call??
                // print(pm?.locality ?? <#default value#>)
            }
            else {
                print("Problem with the data received from geocoder")
                //self.toiletDataUpload(Address: "")
                
                //Test 100
//                var number = 1
//                while number < 100 {
//                    number = number + 1
//                    self.toiletNewId = String(number)
//                    self.toiletDataUpload(Address: "")
//                    
//                }
                
                self.toiletDataUpload(Address: "")

                //Test 100
                
                
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

            
            let noFilterData: [String : Any] = ["name":name!,
                                                "latitude": Lat as Double,
                                                "longitude": Lon as Double,
                                                "type": 0,
                                                "urlOne":newUrlOne,
                                                "averageStar":String(starView.rating) as String,
                                                "reviewCount":1,
                                                "averageWait": waitInt! as Int,
                                                "toiletFloor": 1,
                                                "available": true]
            
//            let toiletUserListData: [String : Any] = ["name":name!,
//                                                "type": 0,
//                                                "urlOne":newUrlOne,
//                                                "averageStar":String(starView.rating) as String,
//                                                "reviewCount":1,
//                                                "averageWait": waitInt! as Int,
//                                                "toiletFloor": 1,
//                                                "latitude": Lat as Double,
//                                                "longitude": Lon as Double,
//                                                "available": true]
            
            let unitOneData: [String : Any] = ["name":name!,
                                               "latitude": Lat as Double,
                                               "longitude": Lon as Double,
                                               "type": 0,
                                               "urlOne":newUrlOne,
                                               "averageStar":String(starView.rating) as String,
                                               "openHours":5000 as Int,
                                               "closeHours":5000 as Int,
                                               "reviewCount":1,
                                               "averageWait": waitInt! as Int,
                                               "toiletFloor": 1,
                                               "available": true,
                                               "japanesetoilet": japaneseToiletSwitch.isOn as Bool,
                                               "westerntoilet":westernToiletSwitch.isOn,
                                               "onlyFemale":onlyFemalSwitch.isOn,
                                               "unisex":unisexSwitch.isOn
            ]
            
            let unitTwoData: [String : Any] = ["name":name!,
                                               "latitude": Lat as Double,
                                               "longitude": Lon as Double,
                                               "type": 0,
                                               "urlOne":newUrlOne,
                                               "averageStar":String(starView.rating) as String,
                                               "reviewCount":1,
                                               "averageWait": waitInt! as Int,
                                               "toiletFloor": 1,
                                               "available": true,
                                               "washlet":washletSwitch.isOn,
                                               "warmSeat":warmSeatSwitch.isOn,
                                               "autoOpen":autoOpenBenkiSwitch.isOn,
                                               "noVirus":noVirusSwitch.isOn,
                                               "paperForBenki":paperForBenkiSwitch.isOn,
                                               "cleanerForBenki":cleanerBenkiSwitch.isOn,
                                               "nonTouchWash":autoToiletWashSwitch.isOn
                
            ]
            
            let unitThreeData: [String : Any] = ["name":name!,
                                                 "latitude": Lat as Double,
                                                 "longitude": Lon as Double,
                                                 "type": 0,
                                                 "urlOne":newUrlOne,
                                                 "averageStar":String(starView.rating) as String,
                                                 "reviewCount":1,
                                                 "averageWait": waitInt! as Int,
                                                 "toiletFloor": 1,
                                                 "available": true,
                                                 "sensorHandWash":sensorHandWashSwitch.isOn,
                                                 "handSoap":handSoapSwitch.isOn,
                                                 "nonTouchHandSoap":autoHandSoapSwitch.isOn,
                                                 "paperTowel":paperTowelSwitch.isOn,
                                                 "handDrier":handDrierSwitch.isOn
            ]
            
            let unitFourData: [String : Any] = ["name":name!,
                                                "latitude": Lat as Double,
                                                "longitude": Lon as Double,
                                                "type": 0,
                                                "urlOne":newUrlOne,
                                                "averageStar":String(starView.rating) as String,
                                                "reviewCount":1,
                                                "averageWait": waitInt! as Int,
                                                "toiletFloor": 1,
                                                "available": true,
                                                "fancy":toiletFancySwitch.isOn,
                                                "smell":toiletSmellGood.isOn,
                                                "confortable":toiletWideSpaceSwitch.isOn,
                                                "clothes":clothesSwitch.isOn,
                                                "baggageSpace":baggageSwitch.isOn
                
            ]
            
            let unitFiveData: [String : Any] = ["name":name!,
                                                "latitude": Lat as Double,
                                                "longitude": Lon as Double,
                                                "type": 0,
                                                "urlOne":newUrlOne,
                                                "averageStar":String(starView.rating) as String,
                                                "reviewCount":1,
                                                "averageWait": waitInt! as Int,
                                                "toiletFloor": 1,
                                                "available": true,
                                                "noNeedAsk":noNeedAskSwitch.isOn,
                                                "english":writtenEnglishSwitch.isOn,
                                                "parking":parkingSwitch.isOn,
                                                "airCondition":airConditionSwitch.isOn,
                                                "wifi":wifiSwitch.isOn,
                                                
                                                
                                                ]
            
            
            
            let unitSixData: [String : Any] = ["name":name!,
                                               "latitude": Lat as Double,
                                               "longitude": Lon as Double,
                                               "type": 0,
                                               "urlOne":newUrlOne,
                                               "averageStar":String(starView.rating) as String,
                                               "reviewCount":1,
                                               "averageWait": waitInt! as Int,
                                               "toiletFloor": 1,
                                               "available": true,
                                               "otohime":otohimeSwitch.isOn,
                                               "napkinSelling":napkinSellingSwitch.isOn,
                                               "makeuproom":makeRoomSwitch.isOn,
                                               "ladyOmutu":ladyOmutuSwitch.isOn,
                                               "ladyBabyChair": ladyBabyChairSwitch.isOn,
                                               "ladyBabyChairGood": ladyBabyChairGoodSwitch.isOn,
                                               "ladyBabyCarAccess": ladyBabyCarAccessSwitch.isOn
            ]
            
            let unitSevenData: [String : Any] = ["name":name!,
                                                 "latitude": Lat as Double,
                                                 "longitude": Lon as Double,
                                                 "type": 0,
                                                 "urlOne":newUrlOne,
                                                 "averageStar":String(starView.rating) as String,
                                                 "reviewCount":1,
                                                 "averageWait": waitInt! as Int,
                                                 "toiletFloor": 1,
                                                 "available": true,
                                                 "maleOmutu": maleOmutuSwitch.isOn,
                                                 "maleBabyChair": maleBabyChairSwitch.isOn,
                                                 "maleBabyChairGood": maleBabyChairGoodSwitch.isOn,
                                                 "maleBabyCarAccess": maleBabyCarAccess.isOn
                
            ]
            
            let unitEightData: [String : Any] = ["name":name!,
                                                 "latitude": Lat as Double,
                                                 "longitude": Lon as Double,
                                                 "type": 0,
                                                 "urlOne":newUrlOne,
                                                 "averageStar":String(starView.rating) as String,
                                                 "reviewCount":1,
                                                 "averageWait": waitInt! as Int,
                                                 "toiletFloor": 1,
                                                 "available": true,
                                                 "wheelchair":wheelChairSwitch.isOn,
                                                 "wheelchairAccess":wheelChiarAccess.isOn,
                                                 "autoDoor":autoDoorSwitch.isOn,
                                                 "callHelp":callHelpSwitch.isOn,
                                                 "ostomate":ostomateSwitch.isOn,
                                                 "braille":brailleSwitch.isOn,
                                                 "voiceGuide":voiceGuideSwitch.isOn,
                                                 "familyOmutu": familyOmutuSwitch.isOn,
                                                 "familyBabyChair": familyBabyChairSwitch.isOn
                
            ]
            
            let unitNineData: [String : Any] = ["name":name!,
                                                "latitude": Lat as Double,
                                                "longitude": Lon as Double,
                                                "type": 0,
                                                "urlOne":newUrlOne,
                                                "averageStar":String(starView.rating) as String,
                                                "reviewCount":1,
                                                "averageWait": waitInt! as Int,
                                                "toiletFloor": 1,
                                                "available": true,
                                                "milkspace":milkSpaceSwitch.isOn,
                                                "babyRoomOnlyFemale":onlyFamaleBabyRoom.isOn,
                                                "babyRoomMaleEnter":babyRoomMaleEnterSwitch.isOn,
                                                "babyRoomPersonalSpace":babyRoomPersonalSpace.isOn,
                                                "babyRoomPersonalSpaceWithLock":babyRoomPersonalWithLock.isOn,
                                                "babyRoomWideSpace":babyRoomWideSpaceSwitch.isOn,
                                                
                                                ]
            
            
            let unitTenData: [String : Any] = ["name":name!,
                                               "latitude": Lat as Double,
                                               "longitude": Lon as Double,
                                               "type": 0,
                                               "urlOne":newUrlOne,
                                               "averageStar":String(starView.rating) as String,
                                               "reviewCount":1,
                                               "averageWait": waitInt! as Int,
                                               "toiletFloor": 1,
                                               "available": true,
                                               "babyCarRental":babyCarRentalSwitch.isOn,
                                               "babyCarAccess":babyCarAccessSwitch.isOn,
                                               "omutu":omutuSwitch.isOn,
                                               "hipCleaningStuff":hipWashingStuffSwitch.isOn,
                                               "omutuTrashCan":omutuTrashCanSwitch.isOn,
                                               "omutuSelling":omutuSellingSwitch.isOn
                
            ]
            
            let unitElevenData: [String : Any] = ["name":name!,
                                                  "latitude": Lat as Double,
                                                  "longitude": Lon as Double,
                                                  "type": 0,
                                                  "urlOne":newUrlOne,
                                                  "averageStar":String(starView.rating) as String,
                                                  "reviewCount":1,
                                                  "averageWait": waitInt! as Int,
                                                  "toiletFloor": 1,
                                                  "available": true,
                                                  "babySink":babyRoomSinkSwitch.isOn,
                                                  "babyWashstand":babyWashStandSwitch.isOn,
                                                  "babyHotwater":babyRoomHotWaterSwitch.isOn,
                                                  "babyMicrowave":babyRoomMicrowaveSwitch.isOn,
                                                  "babyWaterSelling":babyRoomSellingWaterSwitch.isOn,
                                                  "babyFoodSelling":babyRoomFoodSellingSwitch.isOn,
                                                  "babyEatingSpace":babyRoomEatingSpace.isOn
                
                
            ]
            
            let unitTwelveData: [String : Any] = ["name":name!,
                                                  "latitude": Lat as Double,
                                                  "longitude": Lon as Double,
                                                  "type": 0,
                                                  "urlOne":newUrlOne,
                                                  "averageStar":String(starView.rating) as String,
                                                  "reviewCount":1,
                                                  "averageWait": waitInt! as Int,
                                                  "toiletFloor": 1,
                                                  "available": true,
                                                  "babyChair":babyChairSwitch.isOn,
                                                  "babySoffa":soffaSwitch.isOn,
                                                  "kidsToilet":kidsToiletSwitch.isOn,
                                                  "kidsSpace":kidsSpaceSwitch.isOn,
                                                  "babyHeight":heightMeasureSwitch.isOn,
                                                  "babyWeight":weightMeasureSwitch.isOn,
                                                  "babyToy":babyToySwitch.isOn,
                                                  "babyFancy":babyRoomFancySwitch.isOn,
                                                  "babySmellGood":babyRoomGoodSmellSwitch.isOn
                
                
                
            ]
            
            let groupOneData: [String : Any] =
                ["name":name!,
                 "latitude": Lat as Double,
                 "longitude": Lon as Double,
                 "type": 0,
                 "urlOne":newUrlOne,
                 "averageStar":String(starView.rating) as String,
                 "openHours":5000 as Int,
                 "closeHours":5000 as Int,
                 "reviewCount":1,
                 "averageWait": waitInt! as Int,
                 "toiletFloor": 1,
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
                    
                    
                    ]
            
            let groupTwoData: [String : Any] =
                ["name":name!,
                 "latitude": Lat as Double,
                 "longitude": Lon as Double,
                 "type": 0,
                 "urlOne":newUrlOne,
                 "averageStar":String(starView.rating) as String,
                 "reviewCount":1,
                 "averageWait": waitInt! as Int,
                 "toiletFloor": 1,
                 "available": true,
                 
                 "otohime":otohimeSwitch.isOn,
                 "napkinSelling":napkinSellingSwitch.isOn,
                 "makeuproom":makeRoomSwitch.isOn,
                 "ladyOmutu":ladyOmutuSwitch.isOn,
                 "ladyBabyChair": ladyBabyChairSwitch.isOn,
                 "ladyBabyChairGood": ladyBabyChairGoodSwitch.isOn,
                 "ladyBabyCarAccess": ladyBabyCarAccessSwitch.isOn,
                 
                 "maleOmutu": maleOmutuSwitch.isOn,
                 "maleBabyChair": maleBabyChairSwitch.isOn,
                 "maleBabyChairGood": maleBabyChairGoodSwitch.isOn,
                 "maleBabyCarAccess": maleBabyCarAccess.isOn,
                 
                 "wheelchair":wheelChairSwitch.isOn,
                 "wheelchairAccess":wheelChiarAccess.isOn,
                 "autoDoor":autoDoorSwitch.isOn,
                 "callHelp":callHelpSwitch.isOn,
                 "ostomate":ostomateSwitch.isOn,
                 "braille":brailleSwitch.isOn,
                 "voiceGuide":voiceGuideSwitch.isOn,
                 "familyOmutu": familyOmutuSwitch.isOn,
                 "familyBabyChair": familyBabyChairSwitch.isOn,
                 ]
            
            let groupThreeData: [String : Any] =
                ["name":name!,
                 "latitude": Lat as Double,
                 "longitude": Lon as Double,
                 "type": 0,
                 "urlOne":newUrlOne,
                 "averageStar":String(starView.rating) as String,
                 "reviewCount":1,
                 "averageWait": waitInt! as Int,
                 "toiletFloor": 1,
                 "available": true,
                 
                 
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
                 "babySmellGood":babyRoomGoodSmellSwitch.isOn
                    
                    
            ]
            
            let halfOneData: [String : Any] =
                ["name":name!,
                 "latitude": Lat as Double,
                 "longitude": Lon as Double,
                 "type": 0,
                 "urlOne":newUrlOne,
                 "averageStar":String(starView.rating) as String,
                 "openHours":5000 as Int,
                 "closeHours":5000 as Int,
                 "reviewCount":1,
                 "averageWait": waitInt! as Int,
                 "toiletFloor": 1,
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
                    
                    "otohime":otohimeSwitch.isOn,
                    "napkinSelling":napkinSellingSwitch.isOn,
                    "makeuproom":makeRoomSwitch.isOn,
                    "ladyOmutu":ladyOmutuSwitch.isOn,
                    "ladyBabyChair": ladyBabyChairSwitch.isOn,
                    "ladyBabyChairGood": ladyBabyChairGoodSwitch.isOn,
                    "ladyBabyCarAccess": ladyBabyCarAccessSwitch.isOn,
                    
                    "maleOmutu": maleOmutuSwitch.isOn,
                    "maleBabyChair": maleBabyChairSwitch.isOn,
                    "maleBabyChairGood": maleBabyChairGoodSwitch.isOn,
                    "maleBabyCarAccess": maleBabyCarAccess.isOn,
                    
                    "wheelchair":wheelChairSwitch.isOn,
                    "wheelchairAccess":wheelChiarAccess.isOn,
                    "autoDoor":autoDoorSwitch.isOn,
                    "callHelp":callHelpSwitch.isOn,
                    "ostomate":ostomateSwitch.isOn,
                    "braille":brailleSwitch.isOn,
                    "voiceGuide":voiceGuideSwitch.isOn,
                    "familyOmutu": familyOmutuSwitch.isOn,
                    "familyBabyChair": familyBabyChairSwitch.isOn,
                    
                    
                    ]
            
            let halfTwoData: [String : Any] =
                ["name":name!,
                 "latitude": Lat as Double,
                 "longitude": Lon as Double,
                 "type": 0,
                 "urlOne":newUrlOne,
                 "averageStar":String(starView.rating) as String,
                 "reviewCount":1,
                 "averageWait": waitInt! as Int,
                 "toiletFloor": 1,
                 "available": true,
                 
                 "otohime":otohimeSwitch.isOn,
                 "napkinSelling":napkinSellingSwitch.isOn,
                 "makeuproom":makeRoomSwitch.isOn,
                 "ladyOmutu":ladyOmutuSwitch.isOn,
                 "ladyBabyChair": ladyBabyChairSwitch.isOn,
                 "ladyBabyChairGood": ladyBabyChairGoodSwitch.isOn,
                 "ladyBabyCarAccess": ladyBabyCarAccessSwitch.isOn,
                 
                 "maleOmutu": maleOmutuSwitch.isOn,
                 "maleBabyChair": maleBabyChairSwitch.isOn,
                 "maleBabyChairGood": maleBabyChairGoodSwitch.isOn,
                 "maleBabyCarAccess": maleBabyCarAccess.isOn,
                 
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
                 "babySmellGood":babyRoomGoodSmellSwitch.isOn
            ]
            
            
            let allFilterData: [String : Any] =
                ["name":name!,
                 "latitude": Lat as Double,
                 "longitude": Lon as Double,
                 "type": 0,
                 "urlOne":newUrlOne,
                 "averageStar":String(starView.rating) as String,
                 "openHours":5000 as Int,
                 "closeHours":5000 as Int,
                 "reviewCount":1,
                 "averageWait": waitInt! as Int,
                 "toiletFloor": 1,
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
                    
                    "otohime":otohimeSwitch.isOn,
                    "napkinSelling":napkinSellingSwitch.isOn,
                    "makeuproom":makeRoomSwitch.isOn,
                    "ladyOmutu":ladyOmutuSwitch.isOn,
                    "ladyBabyChair": ladyBabyChairSwitch.isOn,
                    "ladyBabyChairGood": ladyBabyChairGoodSwitch.isOn,
                    "ladyBabyCarAccess": ladyBabyCarAccessSwitch.isOn,
                    
                    "maleOmutu": maleOmutuSwitch.isOn,
                    "maleBabyChair": maleBabyChairSwitch.isOn,
                    "maleBabyChairGood": maleBabyChairGoodSwitch.isOn,
                    "maleBabyCarAccess": maleBabyCarAccess.isOn,
                    
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
                    "babySmellGood":babyRoomGoodSmellSwitch.isOn
                    
                    
            ]
            
           
            let reviewData : [String : Any] = ["uid": uid , "tid": toiletNewId, "star": String(starView.rating) as String, "waitingtime": self.waitminute ,"feedback": feedbackTextView.text as String, "available": true, "time": dateString, "timeNumbers":interval, "likedCount":0
            ]

            
            
            
            let tdata : [String : Any] = [
                "name":name!,
                "openAndCloseHours": availableTimeForDatabase as String,
                "type": 0,
                "urlOne":newUrlOne,
                "urlTwo":newUrlTwo,
                "urlThree":newUrlThree,
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
            
         
           
            
//            GeoHash geoHash = new GeoHash(new GeoLocation(latitude, longitude));
//            Map<String, Object> updates = new HashMap<>();
//            updates.put("items/" + itemId, item);
//            updates.put("items_location/" + itemId + "/g", geoHash.getGeoHashString());
//            updates.put("items_location/" + itemId + "/l", Arrays.asList(latitude, longitude));
//            ref.updateChildren(updates);
            //let toiletsRef = FIRDatabase.database().reference().child("Toilets")
            //let uniqueRef = toiletsRef.child(toiletNewId)
            
            print("groupOneData 333 = \(groupOneData)")
            
            let firebaseRef = FIRDatabase.database().reference()
            
            //uniqueRef.setValue(tdata)
            
            let mutipleData = ["NoFilter/\(toiletNewId)": noFilterData,
                               "UnitOne/\(toiletNewId)": unitOneData,
                               "UnitTwo/\(toiletNewId)": unitTwoData,
                               "UnitThree/\(toiletNewId)": unitThreeData,
                               "UnitFour/\(toiletNewId)": unitFourData,
                               "UnitFive/\(toiletNewId)": unitFiveData,
                               "UnitSix/\(toiletNewId)": unitSixData,
                               "UnitSeven/\(toiletNewId)": unitSevenData,
                               "UnitEight/\(toiletNewId)": unitEightData,
                               "UnitNine/\(toiletNewId)": unitNineData,
                               "UnitTen/\(toiletNewId)": unitTenData,
                               "UnitEleven/\(toiletNewId)": unitElevenData,
                               "UnitTwelve/\(toiletNewId)": unitTwelveData,
                               "GroupOne/\(toiletNewId)": groupOneData,
                               "GroupTwo/\(toiletNewId)": groupTwoData,
                               "GroupThree/\(toiletNewId)": groupThreeData,
                               "HalfOne/\(toiletNewId)": halfOneData,
                               "HalfTwo/\(toiletNewId)": halfTwoData,
                               "AllFilter/\(toiletNewId)": allFilterData,
                               "ToiletView/\(toiletNewId)": tdata,
                               "ReviewInfo/\(reviewNewId)": reviewData,
                               "ReviewList/\(uid)/\(reviewNewId)": true,
                               "ToiletReview/\(toiletNewId)/\(reviewNewId)": true,
                               ] as [String : Any]
            
            firebaseRef.updateChildValues(mutipleData, withCompletionBlock: { (error, FIRDatabaseReference) in
                if error != nil{
                    print("Error = \(String(describing: error))")

                    
                }else{
                    //Success
                    geoFire!.setLocation(CLLocation(latitude: Lat, longitude: Lon), forKey: self.toiletNewId){(error) in
                        if (error != nil) {
                            print("An error occured: \(String(describing: error))")
                        } else {
                            print("Saved location successfully!")
                            
                            
                            
                        }
                    }
                    
                }
            })
            
            
            
            
            
            //reviewDataUpload()
            //uploadPhotosToDatabase()
            
            
            performSegue(withIdentifier: "addedToiletToNewAcSegue", sender: nil)
            
        }
        
    }
    
//    func reviewDataUpload(){
//        
//        if waitMinutesLabel.text == ""{
//            waitminute = "0"
//        }
//        if feedbackTextView.text == ""{
//            feedbackTextView.text = ""
//            
//        }
//        
//        
//        let date = NSDate()
//        let calendar = Calendar.current
//        
//        let day = calendar.component(.day, from:date as Date)
//        let month = calendar.component(.month, from:date as Date)
//        let year = calendar.component(.year, from:date as Date)
//        
//        let dateString = "\(year)-\(month)-\(day)"
//        
//        let uid = FIRAuth.auth()!.currentUser!.uid
//        
//        
//        let interval = NSDate().timeIntervalSince1970
//        
//        
//        
//        let reviewData : [String : Any] = ["uid": uid , "tid": toiletNewId, "star": String(starView.rating) as String, "waitingtime": self.waitminute ,"feedback": feedbackTextView.text as String, "available": true, "time": dateString, "timeNumbers":interval, "likedCount":0
//        ]
//        
//        let reviewRef = FIRDatabase.database().reference().child("ReviewInfo").child(reviewNewId)
//        
//        reviewRef.setValue(reviewData)
//        
//        
//        //let rid = reviewRef.key
//        
//        
//        let reviewListRef = FIRDatabase.database().reference().child("ReviewList").child(uid)
//        
//        reviewListRef.child(reviewNewId).setValue(true)
//        
//        let toiletReviewsRef = FIRDatabase.database().reference().child("ToiletReviews").child(toiletNewId)
//        
//        toiletReviewsRef.child(reviewNewId).setValue(true)
//        
//    }
    //Commented this because there are multiple updates above
    
    
    func uploadPhotosToDatabase(){
        
         print("uploadPhotosToDatabase 444 called")
        //let databaseRef = FIRDatabase.database().reference()
        let imagesFolder = FIRStorage.storage().reference().child("ToiletPhoto")
        
        //let photoRef = FIRDatabase.database().reference().child("Images")
        
        if mainImageChanged == true{
            //upload main image pircute
            
            let mainImageData = UIImageJPEGRepresentation(mainImageView.image!, 0.1)!
            let mainUuid = UUID().uuidString
            
            imagesFolder.child(toiletNewId).child("\(mainUuid).jpg").put(mainImageData, metadata: nil, completion: {(metadata, error) in
                print("We tried to upload!")
                if error != nil {
                    print("We had an error:\(String(describing: error))")
                } else {
                    print("uploadPhotosToDatabase1")
                    print(metadata?.downloadURL() as Any)
                    let downloadURL = metadata!.downloadURL()!.absoluteString
                    self.newUrlOne = downloadURL
                    
                     print("photoUrl Upload Before call 444")
                    
                    self.photoUrlMultipleUpdate(placeNumber: 0, photoUrl: downloadURL)
                    
                    print("photoUrl Upload After call 444")
                    
                    
                    //Multiple Update...
                    
                    
                    //databaseRef.child("Toilets").child(self.toiletNewId).updateChildValues(["urlOne": downloadURL])
                    
                }
            })
            //photoRef.child(mainUuid).setValue(uid)
            
        }
        
        if subImageOneChanged == true{
            //upload sub image One pircute
            
            
            let subImageData1 = UIImageJPEGRepresentation(subImageOne.image!, 0.1)!
            let subOneUuid = UUID().uuidString
            
            imagesFolder.child(toiletNewId).child("\(subOneUuid).jpg").put(subImageData1, metadata: nil, completion: {(metadata, error) in
                print("We tried to upload! 444")
                if error != nil {
                    print("We had an error:\(String(describing: error))")
                } else {
                    
                    print(metadata?.downloadURL() as Any)
                    let downloadURL = metadata!.downloadURL()!.absoluteString
                    self.newUrlTwo = downloadURL
                    
                    print("photoUrl Upload Before call 444")
                    
                    self.photoUrlMultipleUpdate(placeNumber: 1, photoUrl: downloadURL)
                    
                    print("photoUrl Upload After call 444")


                    //databaseRef.child("Toilets").child(self.toiletNewId).updateChildValues(["urlTwo": downloadURL]
                    
                    
                }
            })
            
            //photoRef.child(subOneUuid).setValue(uid)
        }
        
        if subImageTwoChanged == true{
            //upload sub image Two pircute
            
            let subImageData2 = UIImageJPEGRepresentation(subImageTwo.image!, 0.1)!
            let subTwoUuid = UUID().uuidString
            
            imagesFolder.child(toiletNewId).child("\(subTwoUuid).jpg").put(subImageData2, metadata: nil, completion: {(metadata, error) in
                print("We tried to upload!")
                if error != nil {
                    print("We had an error:\(String(describing: error))")
                } else {
                    
                    print(metadata?.downloadURL() as Any)
                    let downloadURL = metadata!.downloadURL()!.absoluteString
                    self.newUrlThree = downloadURL
                    
                    self.photoUrlMultipleUpdate(placeNumber: 2, photoUrl: downloadURL)

                    //databaseRef.child("Toilets").child(self.toiletNewId).updateChildValues(["urlThree": downloadURL])
                    
                }
            })
            //photoRef.child(subTwoUuid).setValue(uid)
            
        }
        
    }
    
    
    func photoUrlMultipleUpdate(placeNumber: Int, photoUrl: String){
        
        print("photoUrlMultipleUpdate called 444")
        let firebaseRef = FIRDatabase.database().reference()
        
        if placeNumber == 0{
           // placeString = "urlOne"
            
            
            
            //uniqueRef.setValue(tdata)
            
            let mutipleData = ["NoFilter/\(toiletNewId)/urlOne": photoUrl,
                               "UnitOne/\(toiletNewId)/urlOne": photoUrl,
                               "UnitTwo/\(toiletNewId)/urlOne": photoUrl,
                               "UnitThree/\(toiletNewId)/urlOne": photoUrl,
                               "UnitFour/\(toiletNewId)/urlOne": photoUrl,
                               "UnitFive/\(toiletNewId)/urlOne": photoUrl,
                               "UnitSix/\(toiletNewId)/urlOne": photoUrl,
                               "UnitSeven/\(toiletNewId)/urlOne": photoUrl,
                               "UnitEight/\(toiletNewId)/urlOne": photoUrl,
                               "UnitNine/\(toiletNewId)/urlOne": photoUrl,
                               "UnitTen/\(toiletNewId)/urlOne": photoUrl,
                               "UnitEleven/\(toiletNewId)/urlOne": photoUrl,
                               "UnitTwelve/\(toiletNewId)/urlOne": photoUrl,
                               "GroupOne/\(toiletNewId)/urlOne": photoUrl,
                               "GroupTwo/\(toiletNewId)/urlOne": photoUrl,
                               "GroupThree/\(toiletNewId)/urlOne": photoUrl,
                               "HalfOne/\(toiletNewId)/urlOne": photoUrl,
                               "HalfTwo/\(toiletNewId)/urlOne": photoUrl,
                               "AllFilter/\(toiletNewId)/urlOne": photoUrl,
                               "ToiletView/\(toiletNewId)/urlOne": photoUrl,
                               ] as [String : Any]
            
            
            firebaseRef.updateChildValues(mutipleData, withCompletionBlock: { (error, FIRDatabaseReference) in
                if error != nil{
                    print("Error 444= \(String(describing: error))")
                }else{
                    print(" No Error Url One CHanged 444")

                }
            })
            
        
        } else if placeNumber == 1{
            
            firebaseRef.child("ToiletView").child(toiletNewId).updateChildValues(["urlTwo": photoUrl])
            
        } else if placeNumber == 2{
            firebaseRef.child("ToiletView").child(toiletNewId).updateChildValues(["urlThree": photoUrl])
        
        }
        
        
    
    }
    
    func safeBabyChairCondition(){
        
        let alertController = UIAlertController (title: "安全なベビーチェア", message: "安全なベビーチェアとは、ドアの鍵やボタンから十分に距離がある位置に設置されているものです。", preferredStyle: .alert)
        
        
        let settingsAction = UIAlertAction(title: "はい", style: .default, handler: nil)
        
        
        alertController.addAction(settingsAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func ladyBabyChairTapped(_ sender: Any) {
        safeBabyChairCondition()
    }
    
    
    @IBAction func maleBabyChairTapped(_ sender: Any) {
        safeBabyChairCondition()
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
        
//        var number = 1
//        while number < 100 {
//            number = number + 1
//            toiletNewId = String(number)
//            
            startUpload()
//        }
        
        //toiletDataUpload()
        //updateFirebase()
    }
    
    
    
    
}
