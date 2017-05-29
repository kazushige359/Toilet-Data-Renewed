//
//  FilterTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 14/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

 //
    @IBOutlet weak var availableSwtichOutlet: UISwitch!
    @IBOutlet weak var japaneseSwitchOutlet: UISwitch!
    @IBOutlet weak var westernSwitchOutlet: UISwitch!
    @IBOutlet weak var onlyFemaleSwitchOutlet: UISwitch!
    @IBOutlet weak var unisexSwitchOutlet: UISwitch!
    
    
    @IBOutlet weak var washletSwitchOutlet: UISwitch!
    @IBOutlet weak var warmSeatSwitchOutlet: UISwitch!
    @IBOutlet weak var autoBenkiOpenSwitchOutlet: UISwitch!
    @IBOutlet weak var noVirusSwitchOutlet: UISwitch!
    @IBOutlet weak var paperForBenkiSwitchOutlet: UISwitch!
    @IBOutlet weak var cleanerForBenkiFilterSwitchOutlet: UISwitch!
    @IBOutlet weak var autoToiletWashSwitchOutlet: UISwitch!
    
    @IBOutlet weak var sensorHandWashSwtichOutlet: UISwitch!
    @IBOutlet weak var handSoapSwitchOutlet: UISwitch!
    @IBOutlet weak var autoHandSoapSwitchOutlet: UISwitch!
    @IBOutlet weak var paperTowelSwitchOutlet: UISwitch!
    @IBOutlet weak var handDrierSwitchOutlet: UISwitch!
    
    
    //others one 
    @IBOutlet weak var fancyToiletSwitchOutlet: UISwitch!
    @IBOutlet weak var goodSmellToiletSwitchOutlet: UISwitch!
    @IBOutlet weak var confortableWideToiletSwitchOutlet: UISwitch!
    @IBOutlet weak var clothesSwitchOutlet: UISwitch!
    @IBOutlet weak var baggageSpaceSwitchOutlet: UISwitch!
    
    
    //others two
    @IBOutlet weak var noNeedAskSwitchOutlet: UISwitch!
    @IBOutlet weak var writtenEnglishSwitchOutlet: UISwitch!
    @IBOutlet weak var parkingSwitchOutlet: UISwitch!
    @IBOutlet weak var airConditionSwitchOutlet: UISwitch!
    @IBOutlet weak var wifiSwitchOutlet: UISwitch!

    
    
    //For ladys 
    
    @IBOutlet weak var otohimeSwitchOutlet: UISwitch!
    @IBOutlet weak var napkinSellingSwtichOutlet: UISwitch!
    @IBOutlet weak var makeRoomSwitchOutlet: UISwitch!
    @IBOutlet weak var ladyOmutu: UISwitch!
    @IBOutlet weak var ladyBabyChairOutlet: UISwitch!
    @IBOutlet weak var ladyBabyChairGoodOutlet: UISwitch!
    @IBOutlet weak var ladyBabyCarAccessOutlet: UISwitch!
    
    //For men
    
    @IBOutlet weak var maleOmutuOutlet: UISwitch!
    @IBOutlet weak var maleBabyChiarOutlet: UISwitch!
    @IBOutlet weak var maleBabyChairGood: UISwitch!
    @IBOutlet weak var maleBabyCarAccessOutlet: UISwitch!
    
    
    //For family 
    
    @IBOutlet weak var wheelchairSwitchOutlet: UISwitch!
    @IBOutlet weak var wheelchairAccessSwitchOutlet: UISwitch!
    @IBOutlet weak var autoDoorSwitchOutlet: UISwitch!
    @IBOutlet weak var callHelpSwitchOutlet: UISwitch!
    @IBOutlet weak var ostomateSwitchOutlet: UISwitch!
    @IBOutlet weak var brailleSwitchOutlet: UISwitch!
    @IBOutlet weak var voiceGuideSwitchOutlet: UISwitch!
    @IBOutlet weak var familyOmutuOutlet: UISwitch!
    @IBOutlet weak var familyBabyChairOutlet: UISwitch!
    
    
    
    
    @IBOutlet weak var milkSpaceSwitchOutlet: UISwitch!
    @IBOutlet weak var babyRoomOnlyFemaleSwitchOutlet: UISwitch!
    @IBOutlet weak var babyRoomMaleEnterSwitchOutlet: UISwitch!
    @IBOutlet weak var babyRoomPersonalSpaceSwitchOutlet: UISwitch!
    @IBOutlet weak var babyRoomPersonalWithLockSwitchOutlet: UISwitch!
    @IBOutlet weak var babyRoomWideSpaceSwitchOutlet: UISwitch!
    
    
    @IBOutlet weak var babyCarRentalSwitchOutlet: UISwitch!
    @IBOutlet weak var babyCarAccessSwitchOutlet: UISwitch!
    @IBOutlet weak var omutuSwitchOutlet: UISwitch!
    @IBOutlet weak var babyHipWashingStuffSwitchOutlet: UISwitch!
    @IBOutlet weak var omutuTrashCanFilter: UISwitch!
    @IBOutlet weak var omutuSellingSwitchOutlet: UISwitch!
    
    @IBOutlet weak var babySinkSwitchOutlet: UISwitch!
    @IBOutlet weak var babyWashstandSwitchOutlet: UISwitch!
    @IBOutlet weak var babyHotWaterSwitchOutlet: UISwitch!
    @IBOutlet weak var babyMicrowaveSwitchOutlet: UISwitch!
    @IBOutlet weak var babySellingWaterSwitchOutlet: UISwitch!
    @IBOutlet weak var babyFoodSellingSwitchOutlet: UISwitch!
    @IBOutlet weak var babyEatingSpaceSwitchOutlet: UISwitch!
    
    
    @IBOutlet weak var babyChairSwitchOutlet: UISwitch!
    @IBOutlet weak var soffaSwitchOutlet: UISwitch!
    @IBOutlet weak var kidsToiletSwitchOutlet: UISwitch!
    @IBOutlet weak var kidsSpaceSwitchOutlet: UISwitch!
    @IBOutlet weak var babyHeightMeasureSwitchOutlet: UISwitch!
    @IBOutlet weak var babyWeightSwitchOutlet: UISwitch!
    @IBOutlet weak var babyToySwitchOutlet: UISwitch!
    @IBOutlet weak var babyRoomFancySwitchOutlet: UISwitch!
    @IBOutlet weak var babyRoomSmellGoodSwitchOutlet: UISwitch!
    
    
    
    @IBOutlet weak var distanceField: UITextField!
    
    @IBOutlet weak var orderField: UITextField!
    
    @IBOutlet weak var typeField: UITextField!
    
    @IBOutlet weak var starSearchField: UITextField!
    
    let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
    
    
    var distanceOption = ["less500".localized,"less1000".localized,"less3000".localized,"less5000".localized]
    
    
    
    var orderOption = [
        "orderedByDistance".localized,
        "orderedByReviewCounts".localized,
        "orderedByStars".localized]
    
//    var typeOption = ["全てのトイレ","公衆トイレ","コンビニ","カフェ","レストラン","商業施設","観光地・スタジアム","仮設トイレ","一般家庭(断水時のみ)"]
    
    var typeOption = ["all_category".localized,
        "public_restroom".localized,
        "convenience_store".localized,
        "restaurant".localized,
        "caffe".localized,
        "shopping_center".localized,
        "tourist_places".localized,
        "stadium".localized,
        "portable_toilet".localized,
        "home_toilet".localized]
    
    
    
    var starOption = ["★","★★","★★★","★★★★"]

    
    var returnCount = Int()
    var returnNumber = Int()
    var pickedOption = String()
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    let pickerView4 = UIPickerView()
    
    
    var search = Search()
    

    var filter = Filter()
    var queryPath = QueryPath()
    var filters: [Filter] = []

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        pickerView4.delegate = self
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FilterTableViewController.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap)
        //Added for dismissing the keyboard 
        
        distanceField.inputView = pickerView1
        orderField.inputView = pickerView2
        typeField.inputView = pickerView3
        starSearchField.inputView = pickerView4
        
        
         print("search.searchOn = \(search.searchOn)")
        
        
        
       
        if filter.distanceSetted == true{
            distanceField.text = "\(filter.distanceFilter)km"
        }else{
            distanceField.placeholder = "3km"
        }
     
        if filter.myOrderSetted == true{
            if filter.orderDistanceFilter == true{
                 orderField.text = "orderedByDistance".localized
            }
            if filter.orderStarFilter == true{
                orderField.text = "orderedByStars".localized
            }
            if filter.orderReviewFilter == true{
                orderField.text = "orderedByReviewCounts".localized
            }
        }else{
            orderField.placeholder = "orderedByDistance".localized
                }
        //orderField.placeholder = "現在地から近い順"
        
        if filter.typeFilterOn == true{
         typeField.text = "\(filter.typeFilter)を検索"
        }else{
            
        typeField.placeholder = "all_category".localized
        
        }
        
        
        
        
        
        if filter.starFilterSetted == true{
            if filter.starFilter == 1.0{
                starSearchField.text = "one_star".localized
            }
            if filter.starFilter == 2.0{
                 starSearchField.text = "two_star".localized
            }
            if filter.starFilter == 3.0{
                 starSearchField.text = "three_star".localized
            }
            if filter.starFilter == 4.0{
                 starSearchField.text = "four_star".localized
            }
        }else {
            starSearchField.placeholder = "starNumber".localized
        }

        
        filterCheck()

    }
    
    func filterCheck(){
        availableSwtichOutlet.isOn = false
        japaneseSwitchOutlet.isOn = false
        westernSwitchOutlet.isOn = false
        onlyFemaleSwitchOutlet.isOn = false
        unisexSwitchOutlet.isOn = false
        
        washletSwitchOutlet.isOn = false
        warmSeatSwitchOutlet.isOn = false
        autoBenkiOpenSwitchOutlet.isOn = false
        noVirusSwitchOutlet.isOn = false
        paperForBenkiSwitchOutlet.isOn = false
        cleanerForBenkiFilterSwitchOutlet.isOn = false
        autoToiletWashSwitchOutlet.isOn = false
        
        sensorHandWashSwtichOutlet.isOn = false
        handSoapSwitchOutlet.isOn = false
        autoHandSoapSwitchOutlet.isOn = false
        paperTowelSwitchOutlet.isOn = false
        handDrierSwitchOutlet.isOn = false
        
        
        
        //Other things one
        
        fancyToiletSwitchOutlet.isOn = false
        goodSmellToiletSwitchOutlet.isOn = false
        confortableWideToiletSwitchOutlet.isOn = false
        clothesSwitchOutlet.isOn = false
        baggageSpaceSwitchOutlet.isOn = false
        
        
        
        //Other things two
        noNeedAskSwitchOutlet.isOn = false
        writtenEnglishSwitchOutlet.isOn = false
        parkingSwitchOutlet.isOn = false
        airConditionSwitchOutlet.isOn = false
        wifiSwitchOutlet.isOn = false

        
        
        //For ladys
        otohimeSwitchOutlet.isOn = false
        napkinSellingSwtichOutlet.isOn = false
        makeRoomSwitchOutlet.isOn = false
        ladyOmutu.isOn = false
        ladyBabyChairOutlet.isOn = false
        ladyBabyChairGoodOutlet.isOn = false
        ladyBabyCarAccessOutlet.isOn = false
        
        //For men
        maleOmutuOutlet.isOn = false
        maleBabyChiarOutlet.isOn = false
        maleBabyChairGood.isOn = false
        maleBabyCarAccessOutlet.isOn = false
        
        
        
        //For Family
        
        wheelchairSwitchOutlet.isOn = false
        wheelchairAccessSwitchOutlet.isOn = false
        autoDoorSwitchOutlet.isOn = false
        callHelpSwitchOutlet.isOn = false
        ostomateSwitchOutlet.isOn = false
        brailleSwitchOutlet.isOn = false
        voiceGuideSwitchOutlet.isOn = false
        familyOmutuOutlet.isOn = false
        familyBabyChairOutlet.isOn = false
       
        
        milkSpaceSwitchOutlet.isOn = false
        babyRoomOnlyFemaleSwitchOutlet.isOn = false
        babyRoomMaleEnterSwitchOutlet.isOn = false
        babyRoomPersonalSpaceSwitchOutlet.isOn = false
        babyRoomPersonalWithLockSwitchOutlet.isOn = false
        babyRoomWideSpaceSwitchOutlet.isOn = false
        
        babyCarRentalSwitchOutlet.isOn = false
        babyCarAccessSwitchOutlet.isOn = false
        omutuSwitchOutlet.isOn = false
        babyHipWashingStuffSwitchOutlet.isOn = false
        omutuTrashCanFilter.isOn = false
        omutuSellingSwitchOutlet.isOn = false
        
        babySinkSwitchOutlet.isOn = false
        babyWashstandSwitchOutlet.isOn = false
        babyHotWaterSwitchOutlet.isOn = false
        babyMicrowaveSwitchOutlet.isOn = false
        babySellingWaterSwitchOutlet.isOn = false
        babyFoodSellingSwitchOutlet.isOn = false
        babyEatingSpaceSwitchOutlet.isOn = false
        
        babyChairSwitchOutlet.isOn = false
        soffaSwitchOutlet.isOn = false
        kidsToiletSwitchOutlet.isOn = false
        kidsSpaceSwitchOutlet.isOn = false
        babyHeightMeasureSwitchOutlet.isOn = false
        babyWeightSwitchOutlet.isOn = false
        babyToySwitchOutlet.isOn = false
        babyRoomFancySwitchOutlet.isOn = false
        babyRoomSmellGoodSwitchOutlet.isOn = false
        
        if filter.availableFilter == true{
            availableSwtichOutlet.isOn = true
        }

        if filter.japaneseFilter == true{
            japaneseSwitchOutlet.isOn = true
        }

        if filter.westernFilter == true{
            westernSwitchOutlet.isOn = true
        }

        if filter.onlyFemaleFilter == true{
            onlyFemaleSwitchOutlet.isOn = true
        }
        if filter.unisexFilter == true{
            unisexSwitchOutlet.isOn = true
        }
        
        
        

        if filter.washletFilter == true{
            washletSwitchOutlet.isOn = true
        }
        
        
        if filter.warmSearFilter == true{
            warmSeatSwitchOutlet.isOn = true
        }
        
        if filter.autoOpen == true{
            autoBenkiOpenSwitchOutlet.isOn = true
        }
        
        if filter.noVirusFilter == true{
            noVirusSwitchOutlet.isOn = true
        }
        
        if filter.paperForBenkiFilter == true{
            paperForBenkiSwitchOutlet.isOn = true
        }
        if filter.cleanerForBenkiFilter == true{
            cleanerForBenkiFilterSwitchOutlet.isOn = true
        }
        
        if filter.autoToiletWashFilter == true{
            autoToiletWashSwitchOutlet.isOn = true
        }

        
        
        
        if filter.sensorHandWashFilter == true{
            sensorHandWashSwtichOutlet.isOn = true
        }
        
        if filter.handSoapFilter == true{
            handSoapSwitchOutlet.isOn = true
        }
        
        if filter.autoHandSoapFilter == true{
            autoHandSoapSwitchOutlet.isOn = true
        }
        
        if filter.paperTowelFilter == true{
            paperTowelSwitchOutlet.isOn = true
        }
        if filter.handDrierFilter == true{
            handDrierSwitchOutlet.isOn = true
        }
        
        
        // For other things one 
        if filter.fancy == true{
            fancyToiletSwitchOutlet.isOn = true
        }
        
        if filter.smell == true{
            goodSmellToiletSwitchOutlet.isOn = true
        }
        
        if filter.confortableWise == true{
            confortableWideToiletSwitchOutlet.isOn = true
        }
        
        if filter.clothes == true{
            clothesSwitchOutlet.isOn = true
        }
        
        if filter.baggageSpaceFilter == true{
            baggageSpaceSwitchOutlet.isOn = true
        }

        
        //For other things two 
        
        
       
        
        if filter.noNeedAsk == true{
            noNeedAskSwitchOutlet.isOn = true
        }
        
        if filter.writtenEnglish == true{
            writtenEnglishSwitchOutlet.isOn = true
        }
        
        
        if filter.parking == true{
            parkingSwitchOutlet.isOn = true
        }
        
        if filter.airConditionFilter == true{
            airConditionSwitchOutlet.isOn = true
        }
        
        
        if filter.wifiFilter == true{
            wifiSwitchOutlet.isOn = true
        }
        

        
        
        //For ladys 
        
        
        if filter.otohime == true{
            otohimeSwitchOutlet.isOn = true
        }
        
        
        if filter.napkinSelling == true{
            napkinSellingSwtichOutlet.isOn = true
        }
        
        if filter.makeroomFilter == true{
            makeRoomSwitchOutlet.isOn = true
        }
        
        if filter.ladyOmutu == true{
            ladyOmutu.isOn = true
        }

        
        if filter.ladyBabyChair == true{
            ladyBabyChairOutlet.isOn = true
        }

        
        if filter.ladyBabyChairGood == true{
            ladyBabyChairGoodOutlet.isOn = true
        }

        
        if filter.ladyBabyCarAccess == true{
            ladyBabyCarAccessOutlet.isOn = true
        }


        
        
        //For males 
        
        
        if filter.maleOmutu == true{
            maleOmutuOutlet.isOn = true
        }

        if filter.maleBabyChair == true{
            maleBabyChiarOutlet.isOn = true
        }

        if filter.maleBabyChairgood == true{
            maleBabyChairGood.isOn = true
        }

        if filter.maleBabyCarAccess == true{
             maleBabyCarAccessOutlet.isOn = true
        }

        
        //For family 
        
        
        
        
        if filter.wheelchairFilter == true{
            wheelchairSwitchOutlet.isOn = true
        }
        
        if filter.wheelchairAccessFilter == true{
            wheelchairAccessSwitchOutlet.isOn = true
        }

        
        
        if filter.autoDoorFilter == true{
            autoDoorSwitchOutlet.isOn = true
        }
        
        if filter.callHelpFilter == true{
            callHelpSwitchOutlet.isOn = true
        }
        
        if filter.ostomateFilter == true{
            ostomateSwitchOutlet.isOn = true
        }
        
        if filter.braille == true{
            brailleSwitchOutlet.isOn = true
        }
        
        if filter.voiceGuideFilter == true{
            voiceGuideSwitchOutlet.isOn = true
        }
        
        if filter.familyOmutu == true{
            familyOmutuOutlet.isOn = true
        }

        if filter.familyBabyChair == true{
            familyBabyChairOutlet.isOn = true
        }


        
        
        
        if filter.milkspaceFilter == true{
            milkSpaceSwitchOutlet.isOn = true
        }
        
        if filter.babyRoomOnlyFemaleFilter == true{
            babyRoomOnlyFemaleSwitchOutlet.isOn = true
        }
        
        if filter.babyRoomMaleCanEnterFilter == true{
            babyRoomMaleEnterSwitchOutlet.isOn = true
        }
        if filter.babyRoomPersonalSpaceFilter == true{
            babyRoomPersonalSpaceSwitchOutlet.isOn = true
        }
        
        if filter.babyRoomPersonalWithLockFilter == true{
            babyRoomPersonalWithLockSwitchOutlet.isOn = true
        }


        if filter.babyRoomWideSpaceFilter == true{
                babyRoomWideSpaceSwitchOutlet.isOn = true
        }
        
        if filter.babyCarRentalFilter == true{
            babyCarRentalSwitchOutlet.isOn = true
        }

        if filter.babyCarAccessFilter == true{
            babyCarAccessSwitchOutlet.isOn = true
        }
        if filter.omutuFilter == true{
            omutuSwitchOutlet.isOn = true
        }
        if filter.babyHipWashingStuffFilter == true{
            babyHipWashingStuffSwitchOutlet.isOn = true
        }
        
        if filter.omutuTrashCanFilter == true{
            omutuTrashCanFilter.isOn = true
        }
        
        if filter.omutuSelling == true{
            omutuSellingSwitchOutlet.isOn = true
        }
        
        
        
        if filter.babySinkFilter == true{
            babySinkSwitchOutlet.isOn = true
        }
        
        if filter.babyWashstandFilter == true{
            babyWashstandSwitchOutlet.isOn = true
        }
        if filter.babyHotWaterFilter == true{
            babyHotWaterSwitchOutlet.isOn = true
        }
        if filter.babyMicrowaveFilter == true{
            babyMicrowaveSwitchOutlet.isOn = true
        }
        
        if filter.babySellingWaterFilter == true{
            babySellingWaterSwitchOutlet.isOn = true
        }
        
        if filter.babyFoodSellingFilter == true{
            babyFoodSellingSwitchOutlet.isOn = true
        }

        if filter.babyEatingSpaceFilter == true{
            babyEatingSpaceSwitchOutlet.isOn = true
        }
        
        if filter.babyChairFilter == true{
            babyChairSwitchOutlet.isOn = true
        }
        if filter.babySoffaFilter == true{
            soffaSwitchOutlet.isOn = true
        }
        if filter.babyToiletFilter == true{
            kidsToiletSwitchOutlet.isOn = true
        }
        
        if filter.babyKidsSpaceFilter == true{
            kidsSpaceSwitchOutlet.isOn = true
        }
        
        if filter.babyHeightMeasureFilter == true{
            babyHeightMeasureSwitchOutlet.isOn = true
        }

        if filter.babyWeightMeasureFilter == true{
            babyWeightSwitchOutlet.isOn = true
        }
        
        if filter.babyToyFilter == true{
            babyToySwitchOutlet.isOn = true
        }
        if filter.babyRoomFancyFilter == true{
            babyRoomFancySwitchOutlet.isOn = true
        }
        if filter.babyRoomSmellGoodFilter == true{
            babyRoomSmellGoodSwitchOutlet.isOn = true
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView == pickerView1 {
            returnNumber = 1
        }
        if pickerView == pickerView2 {
            returnNumber = 1
        }
        if pickerView == pickerView3 {
            returnNumber = 1
        }
        if pickerView == pickerView4 {
            returnNumber = 1
        }
        
        
        return returnNumber
        // return 1
        //I might change this for availableTime
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
            //print("pickerView1")
            returnCount = distanceOption.count
        }
        if pickerView == pickerView2 {
            //print("pickerView2")
            returnCount = orderOption.count
        }
        if pickerView == pickerView3 {
            //print("pickerView3")
            returnCount = typeOption.count
        }
        if pickerView == pickerView4 {
            //print("pickerView3")
            returnCount = starOption.count
        }

        
        
        
        return returnCount
    }
    
   
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            //pickerTextField.text = "待ち時間　\(pickOption[row])分"
            if pickerView == pickerView1 {
                
                distanceField.text = "\(distanceOption[row])"
            }
            
            if pickerView == pickerView2 {
                orderField.text = orderOption[row]
            }
            
            if pickerView == pickerView3 {
                
                typeField.text = typeOption[row]
//                let typeActualSearch = typeOption[row]
//                print("typeActualSearch = \(typeActualSearch)")
                
            }
            
            if pickerView == pickerView4 {
                starSearchField.text = "\(starOption[row])"
            }
        

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            //print("pickerView1")
            pickedOption = distanceOption[row]
            
        }
        if pickerView == pickerView2 {
            //print("pickerView2")
            pickedOption = orderOption[row]
            
        }
        if pickerView == pickerView3 {
            //print("pickerView3")
            pickedOption = typeOption[row]
            
            
        }
        if pickerView == pickerView4 {
            //print("pickerView3")
            pickedOption = starOption[row]
            
        }

        
        return pickedOption
        
        
        
    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        //pickerTextField.text = "待ち時間　\(pickOption[row])分"
//        if pickerView == pickerView1 {
//            
//            distanceField.text = "現在地から\(distanceOption[row])"
//        }
//        
//        if pickerView == pickerView2 {
//            orderField.text = orderOption[row]
//        }
//        
//        if pickerView == pickerView3 {
//            typeField.text = "\(typeOption[row])を検索"
//        }
//        
//        if pickerView == pickerView4 {
//            starSearchField.text = "\(starOption[row])以上を検索"
//        }
//    }
    
    //Moved to viewdidappear

    
    @IBAction func searchButtonTapped(_ sender: Any) {
        print("searchButtonTapped")
        
        print("Query Chekck is gonna be called")

        
        queryPathCheck()
//        if washletLabelSwitch.isOn == true{
//            filter.washletFilter = true
//        }
//        
//        if wheelchairLabelSwitch.isOn == true{
//            filter.wheelchairFilter = true
//        }
//
//        if onlyFemaleSwitch.isOn == true{
//            filter.onlyFemaleFilter = true
//        }
//
//        if unisexLabelSwitch.isOn == true{
//            filter.unisexFilter = true
//        }
//        if makeroomLabelSwtich.isOn == true{
//            filter.makeroomFilter = true
//        }
//
//        if milkspaceLabelSwitch.isOn == true{
//            filter.milkspaceFilter = true
//        }
//
//        if omutuLabelSwitch.isOn == true{
//            filter.omutuFilter = true
//        }
//        if ostomateLabelSwitch.isOn == true{
//            filter.ostomateFilter = true
//        }
//
//        if japaneseLabelSwitch.isOn == true{
//            filter.japaneseFilter = true
//        }
//        
//        if westernLabelSwitch.isOn == true {
//            filter.westernFilter = true
//        }
//        
//        if warmSeatSwitch.isOn == true {
//            filter.warmSearFilter = true
//        }
//        
//        if baggageSpaceLabelSwitch.isOn == true {
//            filter.baggageSpaceFilter = true
//        }
//        
//        if availableLabelSwitch.isOn == true{
//            filter.availableFilter = true
//        }
        
        if pickedOption == distanceOption[0]{
            filter.distanceFilter = 0.5
            filter.distanceSetted = true
        }
        if pickedOption == distanceOption[1]{
            filter.distanceFilter = 1
            filter.distanceSetted = true
        }
        if pickedOption == distanceOption[2]{
            filter.distanceFilter = 3
            filter.distanceSetted = true
        }
        if pickedOption == distanceOption[3]{
            filter.distanceFilter = 5
            filter.distanceSetted = true
        }
               
        if pickedOption == orderOption[0]{
            filter.orderDistanceFilter = true
            filter.orderStarFilter = false
            filter.orderReviewFilter = false
            filter.myOrderSetted = true
        }
        
        if pickedOption == orderOption[1]{
            filter.orderReviewFilter = true
            filter.orderDistanceFilter = false
            filter.orderStarFilter = false
            filter.myOrderSetted = true
        }
        
        if pickedOption == orderOption[2]{
            filter.orderStarFilter = true
            filter.orderDistanceFilter = false
            filter.orderReviewFilter = false
            filter.myOrderSetted = true
        }
//        if pickedOption == orderOption[2]{
//            filter.orderReviewFilter = true
//            filter.orderDistanceFilter = false
//            filter.orderStarFilter = false
//            filter.myOrderSetted = true
//        }
        
        if pickedOption == starOption[0]{
            filter.starFilter = 1.0
            filter.starFilterSetted = true
        }
        
        if pickedOption == starOption[1]{
            filter.starFilter = 2.0
            filter.starFilterSetted = true
        }
        
        if pickedOption == starOption[2]{
            filter.starFilter = 3.0
            filter.starFilterSetted = true
        }
        
        if pickedOption == starOption[3]{
            filter.starFilter = 4.0
            filter.starFilterSetted = true
        }
        
      //  if typeActualSearch
        
                if typeField.text == typeOption[0]{
                    filter.typeFilter = 0
                    filter.typeFilterOn = false
                   // filter.starFilterSetted = true
                }
                if typeField.text == typeOption[1]{
                     filter.typeFilterOn = true
                     filter.typeFilter = 1
                }
                if typeField.text == typeOption[2]{
                    filter.typeFilterOn = true
                    filter.typeFilter = 2
                }
                if typeField.text == typeOption[3]{
                    filter.typeFilterOn = true
                    filter.typeFilter = 3
                }
                if typeField.text == typeOption[4]{
                    filter.typeFilterOn = true
                    filter.typeFilter = 4
                }
                if typeField.text == typeOption[5]{
                    filter.typeFilterOn = true
                    filter.typeFilter = 5
                }
                if typeField.text == typeOption[6]{
                    filter.typeFilterOn = true
                    filter.typeFilter = 6
                }
                if typeField.text == typeOption[7]{
                    filter.typeFilterOn = true
                    filter.typeFilter = 7
                }
          
        print("filter.typeFilter = \(filter.typeFilter)")
        
        
        self.filters.append(filter)
        
        performSegue(withIdentifier: "filterSearchSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "filterSearchSegue"{
            let nextV = segue.destination as! MapViewController
            nextV.filter = filter
            nextV.search = search
            
            if segue.identifier == "CanneltoMapSegue"{
            
            }
            
        }
    }
    
    
    @IBAction func availableSwitchTapped(_ sender: Any) {
        if availableSwtichOutlet.isOn == true{
            filter.availableFilter = true
        }else {
            filter.availableFilter = false
        }
        
        
        
    }
    
    
    @IBAction func japaneseSwitchTapped(_ sender: Any) {
        if japaneseSwitchOutlet.isOn == true{
            filter.japaneseFilter = true
        }else {
            filter.japaneseFilter = false
        }

    }
    
    @IBAction func westernSwitchTapped(_ sender: Any) {
        if westernSwitchOutlet.isOn == true{
            filter.westernFilter = true
        }else {
            filter.westernFilter = false
        }

    }
    
    @IBAction func onlyFemaleSwitchTapped(_ sender: Any) {
        if onlyFemaleSwitchOutlet.isOn == true{
        filter.onlyFemaleFilter = true
        }else {
        filter.onlyFemaleFilter = false
        }
    }
    
    
    @IBAction func unisexSwitchTapped(_ sender: Any) {
        if unisexSwitchOutlet.isOn == true{
            filter.unisexFilter = true
        }else {
            filter.unisexFilter = false
        }

    }
    
    
    //Benki Funtion
    
    
    @IBAction func washletSwitchTapped(_ sender: Any) {
        if washletSwitchOutlet.isOn == true{
            filter.washletFilter = true
        }else {
            filter.washletFilter = false
        }

    }
    
    @IBAction func warmSeatSwitchTapped(_ sender: Any) {
        if warmSeatSwitchOutlet.isOn == true{
            filter.warmSearFilter = true
        }else {
            filter.warmSearFilter = false
        }

    }
    
    @IBAction func autoOpenSwitchTapped(_ sender: Any) {
        if autoBenkiOpenSwitchOutlet.isOn == true{
            filter.autoOpen = true
        }else {
            filter.autoOpen = false
        }

    }
    
    @IBAction func noVirusSwitchTapped(_ sender: Any) {
        if noVirusSwitchOutlet.isOn == true{
            filter.noVirusFilter = true
        }else {
            filter.noVirusFilter = false
        }

    }
    
    @IBAction func paperForBenkiSwitchTapped(_ sender: Any) {
        if paperForBenkiSwitchOutlet.isOn == true{
            filter.paperForBenkiFilter = true
        }else {
            filter.paperForBenkiFilter = false
        }

    }
    
    @IBAction func cleanerBenkiSwitchTapped(_ sender: Any) {
        if cleanerForBenkiFilterSwitchOutlet.isOn == true{
            filter.cleanerForBenkiFilter = true
        }else {
            filter.cleanerForBenkiFilter = false
        }

    }
    
    @IBAction func autoToiletWashSwitchTapped(_ sender: Any) {
        if autoToiletWashSwitchOutlet.isOn == true{
            filter.autoToiletWashFilter = true
        }else {
            filter.autoToiletWashFilter = false
        }

    }
    
    
    //Washstand Funtion
    
    @IBAction func sensorHandWashSwitchTapped(_ sender: Any) {
        if sensorHandWashSwtichOutlet.isOn == true{
            filter.sensorHandWashFilter = true
        }else {
            filter.sensorHandWashFilter = false
        }

    }
    
    
    @IBAction func handSoapSwitchTapped(_ sender: Any) {
        if handSoapSwitchOutlet.isOn == true{
            filter.handSoapFilter = true
        }else {
            filter.handSoapFilter = false
        }

    }
    
    @IBAction func autoHandSoapSwitchTapped(_ sender: Any) {
        if autoHandSoapSwitchOutlet.isOn == true{
            filter.autoHandSoapFilter = true
        }else {
            filter.autoHandSoapFilter = false
        }

    }
    
    
    
    @IBAction func paperTowelSwitchTapped(_ sender: Any) {
        if paperTowelSwitchOutlet.isOn == true{
            filter.paperTowelFilter = true
        }else {
            filter.paperTowelFilter = false
        }

    }
    
    
    @IBAction func handDrierSwitchTapped(_ sender: Any) {
        if handDrierSwitchOutlet.isOn == true{
            filter.handDrierFilter = true
        }else {
            filter.handDrierFilter = false
        }

    }
    
    
    //Others one 
    
    
    @IBAction func fancyToiletSwitchTapped(_ sender: Any) {
        if fancyToiletSwitchOutlet.isOn == true{
            filter.fancy = true
        }else {
            filter.fancy = false
        }
        
    }
    
    
    @IBAction func smellGoodToiletSwitchTapped(_ sender: Any) {
        if goodSmellToiletSwitchOutlet.isOn == true{
            filter.smell = true
        }else {
            filter.smell = false
        }
        
    }
    
    
    @IBAction func confortableWideToiletSwitchTapped(_ sender: Any) {
        if confortableWideToiletSwitchOutlet.isOn == true{
            filter.confortableWise = true
        }else {
            filter.confortableWise = false
        }
        
    }

    
    
    
    @IBAction func clothesSwitchTapped(_ sender: Any) {
        if clothesSwitchOutlet.isOn == true{
            filter.clothes = true
        }else {
            filter.clothes = false
        }
        
    }
    
    @IBAction func baggageSpaceSwitchTapped(_ sender: Any) {
        if baggageSpaceSwitchOutlet.isOn == true{
            filter.baggageSpaceFilter = true
        }else {
            filter.baggageSpaceFilter = false
        }
        
    }
    

    //Others two
    
    
    @IBAction func noNeedAskSwitchTapped(_ sender: Any) {
        if noNeedAskSwitchOutlet.isOn == true{
            filter.noNeedAsk = true
        }else {
            filter.noNeedAsk = false
        }
        
    }
    
    
    @IBAction func writtenEnglishSwitchTapped(_ sender: Any) {
        if writtenEnglishSwitchOutlet.isOn == true{
            filter.writtenEnglish = true
        }else {
            filter.writtenEnglish = false
        }
        
    }
    
    
    
    @IBAction func parkingSwitchTapped(_ sender: Any) {
        if parkingSwitchOutlet.isOn == true{
            filter.parking = true
        }else {
            filter.parking = false
        }
        
    }
    
    
    @IBAction func airConditionSwitchTapped(_ sender: Any) {
        if airConditionSwitchOutlet.isOn == true{
            filter.airConditionFilter = true
        }else {
            filter.airConditionFilter = false
        }
        
    }
    
    
    @IBAction func wifiSwitchTapped(_ sender: Any) {
        if wifiSwitchOutlet.isOn == true{
            filter.wifiFilter = true
        }else {
            filter.wifiFilter = false
        }
        
    }

    
    
    //For ladys 
    
    
    @IBAction func otohimeSwitchTapped(_ sender: Any) {
        if otohimeSwitchOutlet.isOn == true{
            filter.otohime = true
            print("Otohime Tapped")
        }else {
            filter.otohime = false
        }
        
    }
    
    
    @IBAction func napkinSellingSwitchTapped(_ sender: Any) {
        if napkinSellingSwtichOutlet.isOn == true{
            filter.napkinSelling = true
        }else {
            filter.napkinSelling = false
        }
        
    }
    
    
    @IBAction func makeRoomSwitchTapped(_ sender: Any) {
        if makeRoomSwitchOutlet.isOn == true{
            filter.makeroomFilter = true
        }else {
            filter.makeroomFilter = false
        }
        
    }
    
    @IBAction func ladyOmutuSwitchTapped(_ sender: Any) {
        
        if ladyOmutu.isOn == true{
            filter.ladyOmutu = true
        }else {
            filter.ladyOmutu = false
        }

    }
    
    
    @IBAction func ladyBabyChairTapped(_ sender: Any) {
        if ladyBabyChairOutlet.isOn == true{
            filter.ladyBabyChair = true
        }else {
            filter.ladyBabyChair = false
        }
    }
    
    
    @IBAction func ladyBabyChairGoodTapped(_ sender: Any) {
        if ladyBabyChairGoodOutlet.isOn == true{
            filter.ladyBabyChairGood = true
        }else {
            filter.ladyBabyChairGood = false
        }
    }
    
    @IBAction func ladyBabyCarAccessTapped(_ sender: Any) {
        if ladyBabyCarAccessOutlet.isOn == true{
            filter.ladyBabyCarAccess = true
        }else {
            filter.ladyBabyCarAccess = false
        }
    }
    

    
    
    //For men 
    
    
    @IBAction func maleOmutuSwitchTapped(_ sender: Any) {
        if maleOmutuOutlet.isOn == true{
            filter.maleOmutu = true
        }else {
            filter.maleOmutu = false
        }
    }
    
    @IBAction func maleBabyChairTapped(_ sender: Any) {
        if maleBabyChiarOutlet.isOn == true{
            filter.maleBabyChair = true
        }else {
            filter.maleBabyChair = false
        }
    }
    
    @IBAction func maleBabyChairGoodTapped(_ sender: Any) {
        if maleBabyChairGood.isOn == true{
            filter.maleBabyChairgood = true
        }else {
            filter.maleBabyChairgood = false
        }
    }
    
    @IBAction func maleBabyCarAccessTapped(_ sender: Any) {
        if maleBabyCarAccessOutlet.isOn == true{
            filter.maleBabyCarAccess = true
        }else {
            filter.maleBabyCarAccess = false
        }
    }
    
    
    
    
    
    
    //For family
    
    
    
    
    @IBAction func wheelchairSwitchTapped(_ sender: Any) {
        if wheelchairSwitchOutlet.isOn == true{
            filter.wheelchairFilter = true
        }else {
            filter.wheelchairFilter = false
        }

    }
    
    
    @IBAction func wheelchairAccessSwitchTapped(_ sender: Any) {
        if wheelchairAccessSwitchOutlet.isOn == true{
            filter.wheelchairAccessFilter = true
        }else {
            filter.wheelchairAccessFilter = false
        }

    }
    
    
    
    @IBAction func autoDoorSwitchTapped(_ sender: Any) {
        if autoDoorSwitchOutlet.isOn == true{
            filter.autoDoorFilter = true
        }else {
            filter.autoDoorFilter = false
        }
        
    }
    
    //Should be changed this....
    
    
    @IBAction func callHelpSwitchTapped(_ sender: Any) {
        if callHelpSwitchOutlet.isOn == true{
            filter.callHelpFilter = true
        }else {
            filter.callHelpFilter = false
        }

    }
    
    
    @IBAction func ostomateSwitchTapped(_ sender: Any) {
        if ostomateSwitchOutlet.isOn == true{
            filter.ostomateFilter = true
        }else {
            filter.ostomateFilter = false
        }

    }
    

    
    
    @IBAction func brailleSwitchTapped(_ sender: Any) {
        if brailleSwitchOutlet.isOn == true{
            filter.braille = true
        }else {
            filter.braille = false
        }

    }
    
    
    @IBAction func voiceGuideSwitchTapped(_ sender: Any) {
        if voiceGuideSwitchOutlet.isOn == true{
            filter.voiceGuideFilter = true
        }else {
            filter.voiceGuideFilter = false
        }

    }
    
    @IBAction func familyOmutuSwitchTapped(_ sender: Any) {
        if familyOmutuOutlet.isOn == true{
            filter.familyOmutu = true
        }else {
            filter.familyOmutu = false
        }
    }
    
    @IBAction func familyBabySwitchTapped(_ sender: Any) {
        if familyBabyChairOutlet.isOn == true{
            filter.familyBabyChair = true
        }else {
            filter.familyBabyChair = false
        }
    }
    
    
    
    @IBAction func milkSpaceSwitchTapped(_ sender: Any) {
        if milkSpaceSwitchOutlet.isOn == true{
            filter.milkspaceFilter = true
        }else {
            filter.milkspaceFilter = false
        }

    }
    
    @IBAction func milkRoomOnlyFemaleSwitchTapped(_ sender: Any) {
        if babyRoomOnlyFemaleSwitchOutlet.isOn == true{
            filter.babyRoomOnlyFemaleFilter = true
        }else {
            filter.babyRoomOnlyFemaleFilter = false
        }

    }
    
    
    @IBAction func babyRoomManEnterSwitchTapped(_ sender: Any) {
        if babyRoomMaleEnterSwitchOutlet.isOn == true{
            filter.babyRoomMaleCanEnterFilter = true
        }else {
            filter.babyRoomMaleCanEnterFilter = false
        }

    }
    
    
    
    @IBAction func babyRoomPersonalSpaceSwitchTapped(_ sender: Any) {
        if babyRoomPersonalSpaceSwitchOutlet.isOn == true{
            filter.babyRoomPersonalSpaceFilter = true
        }else {
            filter.babyRoomPersonalSpaceFilter = false
        }

    }
    
    @IBAction func babyRoomPrivateWithLock(_ sender: Any) {
        if babyRoomPersonalWithLockSwitchOutlet.isOn == true{
            filter.babyRoomPersonalWithLockFilter = true
        }else {
            filter.babyRoomPersonalWithLockFilter = false
        }

    }
    
    
    @IBAction func babyRoomWideSwitchTapped(_ sender: Any) {
        if babyRoomWideSpaceSwitchOutlet.isOn == true{
            filter.babyRoomWideSpaceFilter = true
        }else {
            filter.babyRoomWideSpaceFilter = false
        }

    }
    
    
    @IBAction func babyCarRentalSwitchTapped(_ sender: Any) {
        if babyCarRentalSwitchOutlet.isOn == true{
            filter.babyCarRentalFilter = true
        }else {
            filter.babyCarRentalFilter = false
        }

    }
    
    @IBAction func babyCarAccessSwitchTapped(_ sender: Any) {
        if babyCarAccessSwitchOutlet.isOn == true{
            filter.babyCarAccessFilter = true
        }else {
            filter.babyCarAccessFilter = false
        }

    }
    
    @IBAction func omutuSwitchTapped(_ sender: Any) {
        if omutuSwitchOutlet.isOn == true{
            filter.omutuFilter = true
        }else {
            filter.omutuFilter = false
        }

    }
    
    
    
    @IBAction func babyHipWashingSwitchTapped(_ sender: Any) {
        if babyHipWashingStuffSwitchOutlet.isOn == true{
            filter.babyHipWashingStuffFilter = true
        }else {
            filter.babyHipWashingStuffFilter = false
        }

    }
    
    
    @IBAction func omutuTrashCanSwitchTapped(_ sender: Any) {
        if omutuTrashCanFilter.isOn == true{
            filter.omutuTrashCanFilter = true
        }else {
            filter.omutuTrashCanFilter = false
        }

    }
    
    @IBAction func omutuSellingSwitchTapped(_ sender: Any) {
        if omutuSellingSwitchOutlet.isOn == true{
            filter.omutuSelling = true
        }else {
            filter.omutuSelling = false
        }

    }
    
    @IBAction func babyRoomSinkSwitchTapped(_ sender: Any) {
        if babySinkSwitchOutlet.isOn == true{
            filter.babySinkFilter = true
        }else {
            filter.babySinkFilter = false
        }

    }
    
    
    @IBAction func babyRoomWashStandSwitchTapped(_ sender: Any) {
        if babyWashstandSwitchOutlet.isOn == true{
            filter.babyWashstandFilter = true
        }else {
            filter.babyWashstandFilter = false
        }

    }
    
    
    @IBAction func babyRoomHotWaterSwitchTapped(_ sender: Any) {
        if babyHotWaterSwitchOutlet.isOn == true{
            filter.babyHotWaterFilter = true
        }else {
            filter.babyHotWaterFilter = false
        }

    }
    
    @IBAction func babyRoomMicrowaveSwitchTapped(_ sender: Any) {
        if babyMicrowaveSwitchOutlet.isOn == true{
            filter.babyMicrowaveFilter = true
        }else {
            filter.babyMicrowaveFilter = false
        }

    }
    
    @IBAction func babyRoomWaterSellingSwitchTapped(_ sender: Any) {
        if babySellingWaterSwitchOutlet.isOn == true{
            filter.babySellingWaterFilter = true
        }else {
            filter.babySellingWaterFilter = false
        }

    }
    
    
    @IBAction func babyRoomFoodSellingSwitchTapped(_ sender: Any) {
        if babyFoodSellingSwitchOutlet.isOn == true{
            filter.babyFoodSellingFilter = true
        }else {
            filter.babyFoodSellingFilter = false
        }

    }
    
    @IBAction func babyRoomEatingSpaceSwitchTapped(_ sender: Any) {
        if babyEatingSpaceSwitchOutlet.isOn == true{
            filter.babyEatingSpaceFilter = true
        }else {
            filter.babyEatingSpaceFilter = false
        }

    }
    
    
    @IBAction func babyChairSwitchTapped(_ sender: Any) {
        if babyChairSwitchOutlet.isOn == true{
            filter.babyChairFilter = true
        }else {
            filter.babyChairFilter = false
        }

    }
    
    @IBAction func soffaSwitchTapped(_ sender: Any) {
        if soffaSwitchOutlet.isOn == true{
            filter.babySoffaFilter = true
        }else {
            filter.babySoffaFilter = false
        }

    }
    
    
    @IBAction func kidsToiletSwitchTapped(_ sender: Any) {
        if kidsToiletSwitchOutlet.isOn == true{
            filter.babyToiletFilter = true
        }else {
            filter.babyToiletFilter = false
        }

    }
    
    
    @IBAction func kidSpaceSwitchTapped(_ sender: Any) {
        if kidsSpaceSwitchOutlet.isOn == true{
            filter.babyKidsSpaceFilter = true
        }else {
            filter.babyKidsSpaceFilter = false
        }

    }
    
    
    @IBAction func heightMeasureSwitchTapped(_ sender: Any) {
        if babyHeightMeasureSwitchOutlet.isOn == true{
            filter.babyHeightMeasureFilter = true
        }else {
            filter.babyHeightMeasureFilter = false
        }

    }
    
    
    @IBAction func weightMeasureSwitchTapped(_ sender: Any) {
        if babyWeightSwitchOutlet.isOn == true{
            filter.babyWeightMeasureFilter = true
        }else {
            filter.babyWeightMeasureFilter = false
        }

    }
    
    @IBAction func babyRoomToySwitchTapped(_ sender: Any) {
        if babyToySwitchOutlet.isOn == true{
            filter.babyToyFilter = true
        }else {
            filter.babyToyFilter = false
        }

    }
    
    @IBAction func babyRoomFancySwitchTapped(_ sender: Any) {
        if babyRoomFancySwitchOutlet.isOn == true{
            filter.babyRoomFancyFilter = true
        }else {
            filter.babyRoomFancyFilter = false
        }

    }
    
    
    @IBAction func babyRoomSmellGoodSwitchTapped(_ sender: Any) {
        if babyRoomSmellGoodSwitchOutlet.isOn == true{
            filter.babyRoomSmellGoodFilter = true
        }else {
            filter.babyRoomSmellGoodFilter = false
        }

    }
    
    func safeBabyChairCondition(){
    
        
        let alertController = UIAlertController (title: "safeBabyChair".localized, message: "safeBabyChairDescription".localized, preferredStyle: .alert)
        
        
        let settingsAction = UIAlertAction(title: "yes".localized , style: .default, handler: nil)
        
                //let settingsAction = UIAlertAction(title: "はい", style: .default, handler: nil)
       // let cancelAction = UIAlertAction(title: "いいえ", style: .default, handler: nil)
       // alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        present(alertController, animated: true, completion: nil)
        
    }
   
    
    @IBAction func ladyBabyChairInfoTapped(_ sender: Any) {
        safeBabyChairCondition()
    }
    
    @IBAction func maleBabyChairInfoTapped(_ sender: Any) {
        safeBabyChairCondition()

        
    }
    
    func queryPathCheck(){
        
        
        if filter.availableFilter || filter.japaneseFilter || filter.westernFilter || filter.onlyFemaleFilter || filter.unisexFilter {
            queryPath.unit1 = true
            queryPath.groupOneMember = true
            
        
        
        }
        
        if filter.washletFilter || filter.warmSearFilter || filter.autoOpen || filter.noVirusFilter || filter.paperForBenkiFilter || filter.cleanerForBenkiFilter || filter.autoToiletWashFilter  {
            queryPath.unit2 = true
            queryPath.groupOneMember = true
            
        }
        if filter.sensorHandWashFilter || filter.handSoapFilter || filter.autoHandSoapFilter || filter.paperTowelFilter || filter.handDrierFilter {
            queryPath.unit3 = true
            queryPath.groupOneMember = true
            
        }
        if filter.fancy || filter.smell || filter.confortableWise || filter.clothes || filter.baggageSpaceFilter {
            queryPath.unit4 = true
            queryPath.groupOneMember = true
            
        }
        if filter.noNeedAsk || filter.writtenEnglish || filter.parking
        || filter.airConditionFilter || filter.wifiFilter {
            queryPath.unit5 = true
            queryPath.groupOneMember = true
            
        }
        if filter.otohime || filter.napkinSelling || filter.makeroomFilter || filter.ladyOmutu || filter.ladyBabyChair || filter.ladyBabyChairGood || filter.ladyBabyCarAccess {
            queryPath.unit6 = true
            queryPath.groupTwoMember = true
            
        }
        if filter.maleOmutu || filter.maleBabyChair || filter.maleBabyChairgood || filter.maleBabyCarAccess  {
            queryPath.unit7 = true
            queryPath.groupTwoMember = true
            
        }
        if filter.wheelchairFilter || filter.wheelchairAccessFilter || filter.autoDoorFilter || filter.callHelpFilter || filter.ostomateFilter || filter.braille || filter.voiceGuideFilter || filter.familyOmutu || filter.familyBabyChair{
            queryPath.unit8 = true
            queryPath.groupTwoMember = true
            
        }
        if filter.milkspaceFilter || filter.babyRoomOnlyFemaleFilter || filter.babyRoomMaleCanEnterFilter || filter.babyRoomPersonalSpaceFilter || filter.babyRoomPersonalWithLockFilter || filter.babyRoomWideSpaceFilter{
            queryPath.unit9 = true
            queryPath.groupThreeMember = true
            
        }
        if filter.babyCarRentalFilter || filter.babyCarAccessFilter || filter.omutuFilter || filter.babyHipWashingStuffFilter || filter.omutuTrashCanFilter || filter.omutuSelling{
            queryPath.unit10 = true
            queryPath.groupThreeMember = true
            
        }
        if filter.babySinkFilter || filter.babyWashstandFilter || filter.babyHotWaterFilter || filter.babyMicrowaveFilter || filter.babySellingWaterFilter || filter.babyFoodSellingFilter || filter.babyEatingSpaceFilter{
            queryPath.unit11 = true
            queryPath.groupThreeMember = true
            
        }
        
        if filter.babyChairFilter || filter.babySoffaFilter || filter.babyToiletFilter || filter.babyKidsSpaceFilter || filter.babyHeightMeasureFilter || filter.babyWeightMeasureFilter || filter.babyToyFilter || filter.babyRoomFancyFilter || filter.babyRoomSmellGoodFilter{
            queryPath.unit12 = true
            queryPath.groupThreeMember = true
            
        }
        
        if  queryPath.unit1 && queryPath.unit2 || queryPath.unit1 && queryPath.unit3 || queryPath.unit1  && queryPath.unit4||queryPath.unit1 && queryPath.unit5 || queryPath.unit2 && queryPath.unit3 || queryPath.unit2  && queryPath.unit4||queryPath.unit2 && queryPath.unit5 || queryPath.unit3  && queryPath.unit4||queryPath.unit3  && queryPath.unit5||queryPath.unit4  && queryPath.unit5 {
            queryPath.group1 = true
        }
        
        if (( queryPath.unit6 && queryPath.unit7) || (queryPath.unit6 && queryPath.unit8) || (queryPath.unit7  && queryPath.unit8)) {
            queryPath.group2 = true
        }
        
        if (( queryPath.unit9 && queryPath.unit10) || (queryPath.unit9 && queryPath.unit11) || (queryPath.unit9  && queryPath.unit12) || (queryPath.unit10 && queryPath.unit11) || (queryPath.unit10 && queryPath.unit12) || (queryPath.unit11 && queryPath.unit12)) {
            queryPath.group3 = true
        }
        
        if ( queryPath.groupOneMember && queryPath.groupTwoMember){
            queryPath.half1 = true

        }
        
        if ( queryPath.groupTwoMember && queryPath.groupThreeMember){
            queryPath.half2 = true
            
        }
        if (queryPath.groupOneMember  && queryPath.groupThreeMember){
            queryPath.all = true
            
        }

        
        if ( queryPath.group1 && queryPath.group2) {
            queryPath.half1 = true
        }
        
        if ( queryPath.group2 && queryPath.group3) {
            queryPath.half2 = true
        }
        
        if ( queryPath.half1 && queryPath.half2 ) || ( queryPath.group1 && queryPath.group3) {
            queryPath.all = true
        }
        
        
        
        print("This is the queryPath  77777 \(decideQueryPath())")
    
    }
    
    func decideQueryPath() -> String{
        
        
        if queryPath.all == true{
           filter.queryPath = "AllFilter"
           return "All"
        } else if queryPath.half1 == true{
           filter.queryPath = "HalfOne"
           return "Half1"
        } else if queryPath.half2 == true{
           filter.queryPath = "HalfTwo"
           return "Half2"
        } else if queryPath.group1 == true{
            filter.queryPath = "GroupOne"
            return "Group1"
        } else if queryPath.group2 == true{
            filter.queryPath = "GroupTwo"
            return "Group2"
        }else if queryPath.group3 == true{
            filter.queryPath = "GroupThree"
            return "Group3"
        } else if queryPath.unit1 == true{
            filter.queryPath = "UnitOne"
            return "Unit1"
        } else if queryPath.unit2 == true{
            filter.queryPath = "UnitTwo"
            return "Unit2"
        } else if queryPath.unit3 == true{
            filter.queryPath = "UnitThree"
            return "Unit3"
        } else if queryPath.unit4 == true{
            filter.queryPath = "UnitFour"
            return "Unit4"
        } else if queryPath.unit5 == true{
            filter.queryPath = "UnitFive"
            return "Unit5"
        } else if queryPath.unit6 == true{
            filter.queryPath = "UnitSix"
            return "Unit6"
        } else if queryPath.unit7 == true{
            filter.queryPath = "UnitSeven"
            return "Unit7"
        } else if queryPath.unit8 == true{
            filter.queryPath = "UnitEight"
            return "Unit8"
        } else if queryPath.unit9 == true{
            filter.queryPath = "UnitNine"
            return "Unit9"
        } else if queryPath.unit10 == true{
            filter.queryPath = "UnitTen"
            return "Unit10"
        } else if queryPath.unit11 == true{
            filter.queryPath = "UnitEleven"
            return "Unit11"
        } else if queryPath.unit12 == true{
            filter.queryPath = "UnitTwelve"
            return "Unit12"
        } else {
            filter.queryPath = "NoFilter"
            return "NoFilter"
        
        }
    
    
    
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
         performSegue(withIdentifier: "CanneltoMapSegue", sender: nil)
    }
    
   
}
