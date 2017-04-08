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
    
    @IBOutlet weak var otohimeSwitchOutlet: UISwitch!
    @IBOutlet weak var napkinSellingSwtichOutlet: UISwitch!
    @IBOutlet weak var makeRoomSwitchOutlet: UISwitch!
    @IBOutlet weak var clothesSwitchOutlet: UISwitch!
    @IBOutlet weak var baggageSpaceSwitchOutlet: UISwitch!
    
    
    @IBOutlet weak var wheelchairSwitchOutlet: UISwitch!
    @IBOutlet weak var wheelchairAccessSwitchOutlet: UISwitch!
    @IBOutlet weak var handrailSwitchOutlet: UISwitch!
    @IBOutlet weak var callHelpSwitchOutlet: UISwitch!
    @IBOutlet weak var ostomateSwitchOutlet: UISwitch!
    @IBOutlet weak var writtenEnglishSwitchOutlet: UISwitch!
    @IBOutlet weak var brailleSwitchOutlet: UISwitch!
    @IBOutlet weak var voiceGuideSwitchOutlet: UISwitch!
    
    
    @IBOutlet weak var fancyToiletSwitchOutlet: UISwitch!
    @IBOutlet weak var goodSmellToiletSwitchOutlet: UISwitch!
    @IBOutlet weak var confortableWideToiletSwitchOutlet: UISwitch!
    @IBOutlet weak var noNeedAskSwitchOutlet: UISwitch!
    @IBOutlet weak var parkingSwitchOutlet: UISwitch!
    @IBOutlet weak var airConditionSwitchOutlet: UISwitch!
    @IBOutlet weak var wifiSwitchOutlet: UISwitch!
    
    
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
    
    
    var distanceOption = ["0.5km以内","1km以内","3km以内","5km以内","10km以内"]
    
    var orderOption = ["現在地から近い順","評価が高い順","感想が多い順"]
    
    var typeOption = ["全てのトイレ","公衆トイレ","コンビニ","カフェ","レストラン","商業施設","観光地・スタジアム","仮設トイレ"]
    
    
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
            distanceField.text = "現在地から\(filter.distanceFilter)km以内"
        }else{
            distanceField.placeholder = "現在地から3km以内"
        }
     
        if filter.myOrderSetted == true{
            if filter.orderDistanceFilter == true{
                 orderField.text = "現在地から近い順"
            }
            if filter.orderStarFilter == true{
                orderField.text = "評価が高い順"
            }
            if filter.orderReviewFilter == true{
                orderField.text = "感想が多い順"
            }
        }else{
            orderField.placeholder = "現在地から近い順"
                }
        //orderField.placeholder = "現在地から近い順"
        
        if filter.typeFilterOn == true{
         typeField.text = "\(filter.typeFilter)を検索"
        }else{
        typeField.placeholder = "すべてのトイレを検索"}
        
        
        
        
        if filter.starFilterSetted == true{
            if filter.starFilter == 1.0{
                starSearchField.text = "★以上を検索"
            }
            if filter.starFilter == 2.0{
                 starSearchField.text = "★★以上を検索"
            }
            if filter.starFilter == 3.0{
                 starSearchField.text = "★★★以上を検索"
            }
            if filter.starFilter == 4.0{
                 starSearchField.text = "★★★★以上を検索"
            }
        }else {starSearchField.placeholder = "星の数を検索"}
//        
        
        filterCheck()
//        washletLabelSwitch.isOn = false
//        wheelchairLabelSwitch.isOn = false
//        onlyFemaleSwitch.isOn = false
//        unisexLabelSwitch.isOn = false
//        makeroomLabelSwtich.isOn = false
//        milkspaceLabelSwitch.isOn = false
//        omutuLabelSwitch.isOn = false
//        ostomateLabelSwitch.isOn = false
//        japaneseLabelSwitch.isOn = false
//        westernLabelSwitch.isOn = false
//        warmSeatSwitch.isOn = false
//        baggageSpaceLabelSwitch.isOn = false
//        availableLabelSwitch.isOn = false
//        
//        
//        if filter.washletFilter == true{
//        washletLabelSwitch.isOn = true
//        }
//        if filter.wheelchairFilter == true{
//            wheelchairLabelSwitch.isOn = true
//        }
//        if filter.onlyFemaleFilter == true{
//            onlyFemaleSwitch.isOn = true
//        }
//        if filter.unisexFilter == true{
//            unisexLabelSwitch.isOn = true
//        }
//        if filter.makeroomFilter == true{
//            makeroomLabelSwtich.isOn = true
//        }
//        if filter.milkspaceFilter == true{
//            milkspaceLabelSwitch.isOn = true
//        }
//        if filter.omutuFilter == true{
//            omutuLabelSwitch.isOn = true
//        }
//        if filter.ostomateFilter == true{
//            ostomateLabelSwitch.isOn = true
//        }
//        if filter.japaneseFilter == true{
//            japaneseLabelSwitch.isOn = true
//        }
//        if filter.westernFilter == true{
//            westernLabelSwitch.isOn = true
//        }
//        if filter.warmSearFilter == true{
//            warmSeatSwitch.isOn = true
//        }
//        if filter.baggageSpaceFilter == true{
//            baggageSpaceLabelSwitch.isOn = true
//        }
//        if filter.availableFilter == true{
//            availableLabelSwitch.isOn = true
//        }
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
        
        otohimeSwitchOutlet.isOn = false
        napkinSellingSwtichOutlet.isOn = false
        makeRoomSwitchOutlet.isOn = false
        clothesSwitchOutlet.isOn = false
        baggageSpaceSwitchOutlet.isOn = false
        
        wheelchairSwitchOutlet.isOn = false
        wheelchairAccessSwitchOutlet.isOn = false
        handrailSwitchOutlet.isOn = false
        callHelpSwitchOutlet.isOn = false
        ostomateSwitchOutlet.isOn = false
        writtenEnglishSwitchOutlet.isOn = false
        brailleSwitchOutlet.isOn = false
        voiceGuideSwitchOutlet.isOn = false
        
        fancyToiletSwitchOutlet.isOn = false
        goodSmellToiletSwitchOutlet.isOn = false
        confortableWideToiletSwitchOutlet.isOn = false
        noNeedAskSwitchOutlet.isOn = false
        parkingSwitchOutlet.isOn = false
        airConditionSwitchOutlet.isOn = false
        wifiSwitchOutlet.isOn = false
        
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
        
        
        
        if filter.otohime == true{
            otohimeSwitchOutlet.isOn = true
        }

        
        
        if filter.napkinSelling == true{
            napkinSellingSwtichOutlet.isOn = true
        }
        
        if filter.makeroomFilter == true{
            makeRoomSwitchOutlet.isOn = true
        }
        
        if filter.clothes == true{
            clothesSwitchOutlet.isOn = true
        }
        
        if filter.baggageSpaceFilter == true{
            baggageSpaceSwitchOutlet.isOn = true
        }
        if filter.wheelchairFilter == true{
            wheelchairSwitchOutlet.isOn = true
        }
        
        if filter.wheelchairAccessFilter == true{
            wheelchairAccessSwitchOutlet.isOn = true
        }

        
        
        if filter.handrailFilter == true{
            handrailSwitchOutlet.isOn = true
        }
        
        if filter.callHelpFilter == true{
            callHelpSwitchOutlet.isOn = true
        }
        
        if filter.ostomateFilter == true{
            ostomateSwitchOutlet.isOn = true
        }
        
        if filter.writtenEnglish == true{
            writtenEnglishSwitchOutlet.isOn = true
        }
        if filter.braille == true{
            brailleSwitchOutlet.isOn = true
        }
        
        if filter.voiceGuideFilter == true{
            voiceGuideSwitchOutlet.isOn = true
        }

        
        
        if filter.fancy == true{
            fancyToiletSwitchOutlet.isOn = true
        }
        
        if filter.smell == true{
            goodSmellToiletSwitchOutlet.isOn = true
        }
        
        if filter.confortableWise == true{
            confortableWideToiletSwitchOutlet.isOn = true
        }
        
        if filter.noNeedAsk == true{
            noNeedAskSwitchOutlet.isOn = true
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
                
                distanceField.text = "現在地から\(distanceOption[row])"
            }
            
            if pickerView == pickerView2 {
                orderField.text = orderOption[row]
            }
            
            if pickerView == pickerView3 {
                
                typeField.text = typeOption[row]
//                let typeActualSearch = typeOption[row]
//                print("typeActualSearch = \(typeActualSearch)")
                print("\(typeOption[row])を検索")
            }
            
            if pickerView == pickerView4 {
                starSearchField.text = "\(starOption[row])以上を検索"
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
            print("pickedOption = \(pickedOption)")
            
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
        if pickedOption == distanceOption[4]{
            filter.distanceFilter = 10
            filter.distanceSetted = true
        }
        
        if pickedOption == orderOption[0]{
            filter.orderDistanceFilter = true
            filter.orderStarFilter = false
            filter.orderReviewFilter = false
            filter.myOrderSetted = true
        }
        if pickedOption == orderOption[1]{
            filter.orderStarFilter = true
            filter.orderDistanceFilter = false
            filter.orderReviewFilter = false
            filter.myOrderSetted = true
        }
        if pickedOption == orderOption[2]{
            filter.orderReviewFilter = true
            filter.orderDistanceFilter = false
            filter.orderStarFilter = false
            filter.myOrderSetted = true
        }
        
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
                    filter.typeFilterOn = false
                   // filter.starFilterSetted = true
                }
                if typeField.text == typeOption[1]{
                     filter.typeFilterOn = true
                     filter.typeFilter = "公衆トイレ"
                }
                if typeField.text == typeOption[2]{
                    filter.typeFilterOn = true
                    filter.typeFilter = "コンビニ"
                }
                if typeField.text == typeOption[3]{
                    filter.typeFilterOn = true
                    filter.typeFilter = "カフェ"
                }
                if typeField.text == typeOption[4]{
                    filter.typeFilterOn = true
                    filter.typeFilter = "レストラン"
                }
                if typeField.text == typeOption[5]{
                    filter.typeFilterOn = true
                    filter.typeFilter = "商業施設"
                }
                if typeField.text == typeOption[6]{
                    filter.typeFilterOn = true
                    filter.typeFilter = "観光地・スタジアム"
                }
                if typeField.text == typeOption[7]{
                    filter.typeFilterOn = true
                    filter.typeFilter = "仮設トイレ"
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
    
//    @IBAction func washletSwitchTapped(_ sender: Any) {
//        
//            if washletLabelSwitch.isOn == true{
//                filter.washletFilter = true
//            }else {
//                filter.washletFilter = false
//            }
//    }
//    
//    
//    @IBAction func wheelChairSwitchTapped(_ sender: Any) {
//        if wheelchairLabelSwitch.isOn == true{
//            filter.wheelchairFilter = true
//        }else {
//            filter.wheelchairFilter = false
//        }
//
//    }
//  
//    @IBAction func onlyFemaleSwitchTapped(_ sender: Any) {
//        if onlyFemaleSwitch.isOn == true{
//            filter.onlyFemaleFilter = true
//        }else {
//            filter.onlyFemaleFilter = false
//        }
//    }
//    
//    @IBAction func unisexSwtichTapped(_ sender: Any) {
//        if unisexLabelSwitch.isOn == true{
//            filter.unisexFilter = true
//        }else {
//            filter.unisexFilter = false
//        }
//    }
//  
//    @IBAction func makeroomSwitch(_ sender: Any) {
//        if makeroomLabelSwtich.isOn == true{
//            filter.makeroomFilter = true
//        }else {
//            filter.makeroomFilter = false
//        }
//    }
//   
//    @IBAction func milkspaceSwtich(_ sender: Any) {
//        if milkspaceLabelSwitch.isOn == true{
//            filter.milkspaceFilter = true
//        }else {
//            filter.milkspaceFilter = false
//        }
//    }
//    
//    @IBAction func omutuSwitchTapped(_ sender: Any) {
//        if omutuLabelSwitch.isOn == true{
//            filter.omutuFilter = true
//        }else {
//            filter.omutuFilter = false
//        }
//    }
//
//    @IBAction func ostomateSwitchTapped(_ sender: Any) {
//        if ostomateLabelSwitch.isOn == true{
//            filter.ostomateFilter = true
//        }else {
//            filter.ostomateFilter = false
//        }
//    }
// 
//    @IBAction func japaneseSwitchTapped(_ sender: Any) {
//        if japaneseLabelSwitch.isOn == true{
//            filter.japaneseFilter = true
//        }else {
//            filter.japaneseFilter = false
//        }
//
//    }
//  
//    @IBAction func westernSwitchTapped(_ sender: Any) {
//        if westernLabelSwitch.isOn == true{
//            filter.westernFilter = true
//        }else {
//            filter.westernFilter = false
//        }
//
//    }
//    
//   
//    @IBAction func availableSwitchTapped(_ sender: Any) {
//        if availableLabelSwitch.isOn == true{
//            filter.availableFilter = true
//        }else {
//            filter.availableFilter = false
//        }
//    }
//    
//    @IBAction func warmSeatSwitchTapped(_ sender: Any) {
//        if warmSeatSwitch.isOn == true{
//            filter.warmSearFilter = true
//        }else {
//            filter.warmSearFilter = false
//        }
//
//    }
//    
//    @IBAction func baggageSwitchTapped(_ sender: Any) {
//        
//        if baggageSpaceLabelSwitch.isOn == true{
//            filter.baggageSpaceFilter = true
//        }else {
//            filter.baggageSpaceFilter = false
//        }
//    }
//    
   
    
   
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("cancelButtonTapped")
       
         performSegue(withIdentifier: "CanneltoMapSegue", sender: nil)
//         _ = self.navigationController?.popViewController(animated: true)
//        //previous one
    }
    
   
}
