//
//  FilterTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 14/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var japaneseLabelSwitch: UISwitch!
    
    @IBOutlet weak var westernLabelSwitch: UISwitch!
    
    @IBOutlet weak var onlyFemaleSwitch: UISwitch!
    
    @IBOutlet weak var unisexLabelSwitch: UISwitch!
    
    @IBOutlet weak var washletLabelSwitch: UISwitch!
    
    @IBOutlet weak var warmSeatSwitch: UISwitch!
    
    @IBOutlet weak var omutuLabelSwitch: UISwitch!
    
    @IBOutlet weak var milkspaceLabelSwitch: UISwitch!
    
    @IBOutlet weak var makeroomLabelSwtich: UISwitch!
    
    @IBOutlet weak var baggageSpaceLabelSwitch: UISwitch!
    
    @IBOutlet weak var wheelchairLabelSwitch: UISwitch!
    
    @IBOutlet weak var ostomateLabelSwitch: UISwitch!
    
    @IBOutlet weak var availableLabelSwitch: UISwitch!
    
    
    
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
        
        if filter.distaceSetted == true{
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
        
        washletLabelSwitch.isOn = false
        wheelchairLabelSwitch.isOn = false
        onlyFemaleSwitch.isOn = false
        unisexLabelSwitch.isOn = false
        makeroomLabelSwtich.isOn = false
        milkspaceLabelSwitch.isOn = false
        omutuLabelSwitch.isOn = false
        ostomateLabelSwitch.isOn = false
        japaneseLabelSwitch.isOn = false
        westernLabelSwitch.isOn = false
        warmSeatSwitch.isOn = false
        baggageSpaceLabelSwitch.isOn = false
        availableLabelSwitch.isOn = false
        
        
        if filter.washletFilter == true{
        washletLabelSwitch.isOn = true
        }
        if filter.wheelchairFilter == true{
            wheelchairLabelSwitch.isOn = true
        }
        if filter.onlyFemaleFilter == true{
            onlyFemaleSwitch.isOn = true
        }
        if filter.unisexFilter == true{
            unisexLabelSwitch.isOn = true
        }
        if filter.makeroomFilter == true{
            makeroomLabelSwtich.isOn = true
        }
        if filter.milkspaceFilter == true{
            milkspaceLabelSwitch.isOn = true
        }
        if filter.omutuFilter == true{
            omutuLabelSwitch.isOn = true
        }
        if filter.ostomateFilter == true{
            ostomateLabelSwitch.isOn = true
        }
        if filter.japaneseFilter == true{
            japaneseLabelSwitch.isOn = true
        }
        if filter.westernFilter == true{
            westernLabelSwitch.isOn = true
        }
        if filter.warmSearFilter == true{
            warmSeatSwitch.isOn = true
        }
        if filter.baggageSpaceFilter == true{
            baggageSpaceLabelSwitch.isOn = true
        }
        if filter.availableFilter == true{
            availableLabelSwitch.isOn = true
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
        if washletLabelSwitch.isOn == true{
            filter.washletFilter = true
        }
        
        if wheelchairLabelSwitch.isOn == true{
            filter.wheelchairFilter = true
        }

        if onlyFemaleSwitch.isOn == true{
            filter.onlyFemaleFilter = true
        }

        if unisexLabelSwitch.isOn == true{
            filter.unisexFilter = true
        }
        if makeroomLabelSwtich.isOn == true{
            filter.makeroomFilter = true
        }

        if milkspaceLabelSwitch.isOn == true{
            filter.milkspaceFilter = true
        }

        if omutuLabelSwitch.isOn == true{
            filter.omutuFilter = true
        }
        if ostomateLabelSwitch.isOn == true{
            filter.ostomateFilter = true
        }

        if japaneseLabelSwitch.isOn == true{
            filter.japaneseFilter = true
        }
        
        if westernLabelSwitch.isOn == true {
            filter.westernFilter = true
        }
        
        if warmSeatSwitch.isOn == true {
            filter.warmSearFilter = true
        }
        
        if baggageSpaceLabelSwitch.isOn == true {
            filter.baggageSpaceFilter = true
        }
        
        if availableLabelSwitch.isOn == true{
            filter.availableFilter = true
        }
        
        if pickedOption == distanceOption[0]{
            filter.distanceFilter = 0.5
            filter.distaceSetted = true
        }
        if pickedOption == distanceOption[1]{
            filter.distanceFilter = 1
            filter.distaceSetted = true
        }
        if pickedOption == distanceOption[2]{
            filter.distanceFilter = 3
            filter.distaceSetted = true
        }
        if pickedOption == distanceOption[3]{
            filter.distanceFilter = 5
            filter.distaceSetted = true
        }
        if pickedOption == distanceOption[4]{
            filter.distanceFilter = 10
            filter.distaceSetted = true
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
    
    @IBAction func washletSwitchTapped(_ sender: Any) {
        
            if washletLabelSwitch.isOn == true{
                filter.washletFilter = true
            }else {
                filter.washletFilter = false
            }
    }
    
    
    @IBAction func wheelChairSwitchTapped(_ sender: Any) {
        if wheelchairLabelSwitch.isOn == true{
            filter.wheelchairFilter = true
        }else {
            filter.wheelchairFilter = false
        }

    }
  
    @IBAction func onlyFemaleSwitchTapped(_ sender: Any) {
        if onlyFemaleSwitch.isOn == true{
            filter.onlyFemaleFilter = true
        }else {
            filter.onlyFemaleFilter = false
        }
    }
    
    @IBAction func unisexSwtichTapped(_ sender: Any) {
        if unisexLabelSwitch.isOn == true{
            filter.unisexFilter = true
        }else {
            filter.unisexFilter = false
        }
    }
  
    @IBAction func makeroomSwitch(_ sender: Any) {
        if makeroomLabelSwtich.isOn == true{
            filter.makeroomFilter = true
        }else {
            filter.makeroomFilter = false
        }
    }
   
    @IBAction func milkspaceSwtich(_ sender: Any) {
        if milkspaceLabelSwitch.isOn == true{
            filter.milkspaceFilter = true
        }else {
            filter.milkspaceFilter = false
        }
    }
    
    @IBAction func omutuSwitchTapped(_ sender: Any) {
        if omutuLabelSwitch.isOn == true{
            filter.omutuFilter = true
        }else {
            filter.omutuFilter = false
        }
    }

    @IBAction func ostomateSwitchTapped(_ sender: Any) {
        if ostomateLabelSwitch.isOn == true{
            filter.ostomateFilter = true
        }else {
            filter.ostomateFilter = false
        }
    }
 
    @IBAction func japaneseSwitchTapped(_ sender: Any) {
        if japaneseLabelSwitch.isOn == true{
            filter.japaneseFilter = true
        }else {
            filter.japaneseFilter = false
        }

    }
  
    @IBAction func westernSwitchTapped(_ sender: Any) {
        if westernLabelSwitch.isOn == true{
            filter.westernFilter = true
        }else {
            filter.westernFilter = false
        }

    }
    
   
    @IBAction func availableSwitchTapped(_ sender: Any) {
        if availableLabelSwitch.isOn == true{
            filter.availableFilter = true
        }else {
            filter.availableFilter = false
        }
    }
    
    @IBAction func warmSeatSwitchTapped(_ sender: Any) {
        if warmSeatSwitch.isOn == true{
            filter.warmSearFilter = true
        }else {
            filter.warmSearFilter = false
        }

    }
    
    @IBAction func baggageSwitchTapped(_ sender: Any) {
        
        if baggageSpaceLabelSwitch.isOn == true{
            filter.baggageSpaceFilter = true
        }else {
            filter.baggageSpaceFilter = false
        }
    }
    
   
    
   
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("cancelButtonTapped")
       
         performSegue(withIdentifier: "CanneltoMapSegue", sender: nil)
//         _ = self.navigationController?.popViewController(animated: true)
//        //previous one
    }
    
   
}
