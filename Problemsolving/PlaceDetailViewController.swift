//
//  PlaceDetailViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 8/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Cosmos

class PlaceDetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate,
    UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booleans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = Bundle.main.loadNibNamed("BooleanTableViewCell", owner: self, options: nil)?.first as! BooleanTableViewCell
        
        cell.booleanName.text = booleans[indexPath.row]
        
        print(" cell.booleanName.text =  \(String(describing: cell.booleanName.text))")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didselect")
    }
    
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    @IBOutlet weak var booleansTableView: UITableView!
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var bigPicture: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var typeAndDistanceLabel: UILabel!
    @IBOutlet weak var availableTimeAndWaitingTImeLabel: UILabel!
    @IBOutlet weak var starImage: CosmosView!
    
    
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var picture1: UIImageView!
    @IBOutlet weak var picture2: UIImageView!
    @IBOutlet weak var picture3: UIImageView!
    
    //  @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonShowDetailOutlet: UIButton!
    @IBOutlet weak var buttonKansouOutlet: UIButton!
    @IBOutlet weak var buttonEditInfoOutlet: UIButton!
    @IBOutlet weak var addressTextView: UILabel!
    @IBOutlet weak var howToAccessTextView: UILabel!
    @IBOutlet weak var buttonGoOutlet: UIButton!
    @IBOutlet weak var buttonShowAllReviewsOutlet: UIButton!
    
    
    @IBOutlet weak var firstPosterPicture: UIImageView!
    @IBOutlet weak var firstPosterNameLabel: UILabel!
    @IBOutlet weak var firstPosterLikeLabel: UILabel!
    @IBOutlet weak var firstPosterFavoriteLabel: UILabel!
    @IBOutlet weak var firstPosterHelpLabel: UILabel!
    
    
    
    @IBOutlet weak var lastEditerPicture: UIImageView!
    @IBOutlet weak var lastEditerNameLabel: UILabel!
    @IBOutlet weak var lastEditerLikeLabel: UILabel!
    @IBOutlet weak var lastEditerFavoriteLabel: UILabel!
    @IBOutlet weak var lastEditerHelpLabel: UILabel!
    
    
    @IBOutlet weak var reviewOneUserImage: UIImageView!
    @IBOutlet weak var reviewOneUserNameLabel: UILabel!
    @IBOutlet weak var reviewOneUserLikeCount: UILabel!
    @IBOutlet weak var reviewOneUserFavoriteCount: UILabel!
    @IBOutlet weak var reviewOneUserHelpCount: UILabel!
    @IBOutlet weak var reviewOneFeedbackTextView: UITextView!
    
    @IBOutlet weak var reviewOneThumbUpButtonOutlet: UIButton!
    @IBOutlet weak var reviewOneThumbUpCountLabel: UILabel!
    @IBOutlet weak var reviewOneWaitingMinuteLabel: UILabel!
    @IBOutlet weak var reviewOneDateStringLabel: UILabel!
    
    var reviewOneThumbOriginalCount = 0
    //var reviewOneThumbUpdatedCount = 0
    
    var reviewOneUserTotalLikeOriginalCount = 0
    //var reviewOneUSerTotalikeUpdatedCount = 0
    
    
    var reviewTwoThumbOriginalCount = 0
    //var reviewTwoThumbUpdatedCount = 0
    
    
    var reviewTwoUserTotalLikeOriginalCount = 0
    //var reviewTwoUserTotalLikeUpdatedCount = 0

    
    
    
    
    @IBOutlet weak var reviewTwoUserImage: UIImageView!
    @IBOutlet weak var reviewTwoUserNameLabel: UILabel!
    @IBOutlet weak var reviewTwoUserLikeCount: UILabel!
    @IBOutlet weak var reviewTwoUserFavoriteCount: UILabel!
    @IBOutlet weak var reviewTwoUserHelpCount: UILabel!
    @IBOutlet weak var reviewTwoUserFeedbackTextView: UITextView!
    
    
    @IBOutlet weak var reviewTwoThumbUpButtonOutlet: UIButton!
    
    @IBOutlet weak var reviewTwoThumbUpCountLabel: UILabel!
    
    
    @IBOutlet weak var reviewTwoWatingTImeLabel: UILabel!
    
    @IBOutlet weak var reviewTwoDateStringOutlet: UILabel!
    
    
    @IBOutlet weak var booleanTableViewLeftConstraint: NSLayoutConstraint!
    
    
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    var waitingtime = 0
    var washlet = Bool()
    var westerntoilet = Bool()
    var omutu = Bool()
    var ostomate = Bool()
    var type = ""
    var url = ""
    var key = ""
    var loc = CLLocation()
    var reviews: [Review] = []
    var booleans: [String] = []
    var reviewsSet = Set<String>()
    var thumbsUpSet = Set<String>()
    var newThumbsUpSet = Set<String>()
    var newThumbsDownSet = Set<String>()
    var favoriteSet = Set<String>()
    var likeChangedList = [String: Bool]()
    //added April 22 
    
    
    var toilet = Toilet()
    var review = Review()
    var filter = Filter()
    var search = Search()
    var favoriteAdded = false
    var youwentAdded = false
    var youwentEdited = false
    var firebaseReviewOneLoadedOnce = false
    var firebaseReviewTwoLoadedOnce = false
    var favoriteButtonTapped = false
    var firstEditerHelpCountAdded = false
    var lastEditerHelpCountAdded = false
    var reviewOneLikeAlreadyTapped = false
    var reviewTwoLikeAlreadyTapped = false
    var userAlreadyLogin = false
    var firebaseOnceLoaded = false
    var postRid = ""
    var suspiciosUserId = ""
//    var reviewReportOnceUploaded = false
//    var userReportOnceUploaded = false
    var reviewOnePoster = ""
    var reviewTwoPoster = ""
    var firstPosterFavoriteNumber = 0
    var lastEditerFavoriteNumber = 0
    
    
    
    
    let firebaseRef = FIRDatabase.database().reference()
    let currentUserId = FIRAuth.auth()?.currentUser?.uid
    
    let imageColored = UIImage(named:"like_colored_25")
    let imageBlack = UIImage(named:"thumbsUp_black_image_25")
    
    var locationManager = CLLocationManager()
    let primaryColor : UIColor = UIColor(red:0.32, green:0.67, blue:0.95, alpha:1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.isUserInteractionEnabled = false
        
        print("Place Detail View Loaded")
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PlaceDetailViewController.hideTableView))
        view.addGestureRecognizer(tap)
        
        booleansTableView.delegate = self
        booleansTableView.dataSource = self
        
        booleansTableView.tableFooterView = UIView()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        booleanTableViewLeftConstraint.constant = screenWidth
        
        print("booleanTableViewLeftConstraint.constant = \(booleanTableViewLeftConstraint.constant)")
        
        
        dataQuery(queryKey: toilet.key)
        
        
        
        
        
        
        //Commented for making table view... April 11 12pm
        
        
        
        //reviewQuery()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("View Did Disappear!!!")
        
        
    }
    
    func userLoginCheck(){
        
        let userRef = firebaseRef.child("Users")
        
        userRef.child(currentUserId!).observe(.value, with: { snapshot in
            
            if ( snapshot.value is NSNull ) {
                print("(User did not found)")
                
                if self.toilet.reviewOne != ""{
                    self.reviewOneQuery(ridOne: self.toilet.reviewOne)
                }
                
                if self.toilet.reviewTwo != ""{
                    self.reviewTwoQuery(ridTwo: self.toilet.reviewTwo)
                }
                
                
            } else {
                print(snapshot.value!)
                print("User Find")
                self.favoriteListQuery()
                self.thumbsUpQuery()
                
                self.userAlreadyLogin = true
            }
        })
        
    }
    
    func showPleaseLogin(){
        let alertController = UIAlertController (title: "この機能を使用するためにはログインが必要です", message: "ログインをしますか？", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "はい", style: .default) { (_) -> Void in
            
            print("Move to first time view controller")
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UserFirstTimeViewController") as! UserFirstTimeViewController
            //self.(vc, sender: self)
            print("Move to first time view controller Over")
            self.present(vc, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "いいえ", style: .default, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    func dataQuery(queryKey: String){
        
        print("Data Query Called")
        let toiletsRef = FIRDatabase.database().reference().child("Toilets")
        
        
        
        toiletsRef.child(queryKey).observe(FIRDataEventType.value, with: { snapshot in
            
            self.toilet.key = queryKey
            let snapshotValue = snapshot.value as? NSDictionary
            
            self.booleans.append("この施設の設備")
            
            
            self.toilet.urlOne = (snapshotValue?["urlOne"] as? String!)!
            self.toilet.urlTwo = (snapshotValue?["urlTwo"] as? String!)!
            self.toilet.urlThree = (snapshotValue?["urlThree"] as? String)!
            self.toilet.address = (snapshotValue?["address"] as? String)!
            self.toilet.howtoaccess = (snapshotValue?["howtoaccess"] as? String)!
            self.toilet.addedBy = (snapshotValue?["addedBy"] as? String)!
            self.toilet.editedBy = (snapshotValue?["editedBy"] as? String)!
            self.toilet.openinghours = (snapshotValue?["openAndCloseHours"] as? String)!
            
            
            print("Review One Query Called")
            self.toilet.reviewOne = (snapshotValue?["reviewOne"] as? String!)!
            
            self.toilet.reviewTwo = (snapshotValue?["reviewTwo"] as? String!)!
            
            
            
            
            
            
            let averageStar = snapshotValue?["averageStar"] as? String
            self.toilet.star = Double(averageStar!)!
            
            
            
            self.toilet.name = (snapshotValue?["name"] as? String)!
            self.toilet.type = (snapshotValue?["type"] as? Int)!
            self.toilet.urlOne = (snapshotValue?["urlOne"] as? String)!
            self.toilet.averageStar = (snapshotValue?["averageStar"] as? String)!
            
            
            
            
            self.toilet.openHours = (snapshotValue?["openHours"] as? Int)!
            self.toilet.closeHours = (snapshotValue?["closeHours"] as? Int)!
            self.toilet.reviewCount = (snapshotValue?["reviewCount"] as? Int)!
            self.toilet.averageWait = (snapshotValue?["averageWait"] as? Int)!
            
            
            
            
            self.toilet.available = (snapshotValue?["available"] as? Bool)!
            self.toilet.japanesetoilet = (snapshotValue?["japanesetoilet"] as? Bool)!
            self.toilet.westerntoilet = (snapshotValue?["westerntoilet"] as? Bool)!
            self.toilet.onlyFemale = (snapshotValue?["onlyFemale"] as? Bool)!
            self.toilet.unisex = (snapshotValue?["unisex"] as? Bool)!
            
            
            
            
            
            self.toilet.washlet = (snapshotValue?["washlet"] as? Bool)!
            self.toilet.warmSeat = (snapshotValue?["warmSeat"] as? Bool)!
            self.toilet.autoOpen = (snapshotValue?["autoOpen"] as? Bool)!
            self.toilet.noVirus = (snapshotValue?["noVirus"] as? Bool)!
            self.toilet.paperForBenki = (snapshotValue?["paperForBenki"] as? Bool)!
            self.toilet.cleanerForBenki = (snapshotValue?["cleanerForBenki"] as? Bool)!
            self.toilet.autoToiletWash = (snapshotValue?["nonTouchWash"] as? Bool)!
            
            
            
            self.toilet.sensorHandWash = (snapshotValue?["sensorHandWash"] as? Bool)!
            self.toilet.handSoap = (snapshotValue?["handSoap"] as? Bool)!
            self.toilet.autoHandSoap = (snapshotValue?["nonTouchHandSoap"] as? Bool)!
            self.toilet.paperTowel = (snapshotValue?["paperTowel"] as? Bool)!
            self.toilet.handDrier = (snapshotValue?["handDrier"] as? Bool)!
            
            
            
            
            self.toilet.otohime = (snapshotValue?["otohime"] as? Bool)!
            self.toilet.napkinSelling = (snapshotValue?["napkinSelling"] as? Bool)!
            self.toilet.makeuproom = (snapshotValue?["makeuproom"] as? Bool)!
            self.toilet.clothes = (snapshotValue?["clothes"] as? Bool)!
            self.toilet.baggageSpace = (snapshotValue?["baggageSpace"] as? Bool)!
            
            
            self.toilet.wheelchair = (snapshotValue?["wheelchair"] as? Bool)!
            self.toilet.wheelchairAccess = (snapshotValue?["wheelchairAccess"] as? Bool)!
            self.toilet.autoDoor = (snapshotValue?["autoDoor"] as? Bool)!
            self.toilet.callHelp = (snapshotValue?["callHelp"] as? Bool)!
            self.toilet.ostomate = (snapshotValue?["ostomate"] as? Bool)!
            self.toilet.english = (snapshotValue?["english"] as? Bool)!
            self.toilet.braille = (snapshotValue?["braille"] as? Bool)!
            self.toilet.voiceGuide = (snapshotValue?["voiceGuide"] as? Bool)!
            
            
            
            self.toilet.fancy = (snapshotValue?["fancy"] as? Bool)!
            self.toilet.smell = (snapshotValue?["smell"] as? Bool)!
            self.toilet.conforatableWide = (snapshotValue?["confortable"] as? Bool)!
            self.toilet.noNeedAsk = (snapshotValue?["noNeedAsk"] as? Bool)!
            self.toilet.parking = (snapshotValue?["parking"] as? Bool)!
            self.toilet.airCondition = (snapshotValue?["airCondition"] as? Bool)!
            self.toilet.wifi = (snapshotValue?["wifi"] as? Bool)!
            
            self.toilet.milkspace = (snapshotValue?["milkspace"] as? Bool)!
            self.toilet.babyroomOnlyFemale = (snapshotValue?["babyRoomOnlyFemale"] as? Bool)!
            self.toilet.babyroomManCanEnter = (snapshotValue?["babyRoomMaleEnter"] as? Bool)!
            self.toilet.babyPersonalSpace = (snapshotValue?["babyRoomPersonalSpace"] as? Bool)!
            self.toilet.babyPersonalSpaceWithLock = (snapshotValue?["babyRoomPersonalSpaceWithLock"] as? Bool)!
            self.toilet.babyRoomWideSpace = (snapshotValue?["babyRoomWideSpace"] as? Bool)!
            
            self.toilet.babyCarRental = (snapshotValue?["babyCarRental"] as? Bool)!
            self.toilet.babyCarAccess = (snapshotValue?["babyCarAccess"] as? Bool)!
            self.toilet.omutu = (snapshotValue?["omutu"] as? Bool)!
            self.toilet.hipWashingStuff = (snapshotValue?["hipCleaningStuff"] as? Bool)!
            self.toilet.babyTrashCan = (snapshotValue?["omutuTrashCan"] as? Bool)!
            self.toilet.omutuSelling = (snapshotValue?["omutuSelling"] as? Bool)!
            
            
            self.toilet.babyRoomSink = (snapshotValue?["babySink"] as? Bool)!
            self.toilet.babyWashStand = (snapshotValue?["babyWashstand"] as? Bool)!
            self.toilet.babyHotWater = (snapshotValue?["babyHotwater"] as? Bool)!
            self.toilet.babyMicroWave = (snapshotValue?["babyMicrowave"] as? Bool)!
            self.toilet.babyWaterSelling = (snapshotValue?["babyWaterSelling"] as? Bool)!
            self.toilet.babyFoddSelling = (snapshotValue?["babyFoodSelling"] as? Bool)!
            self.toilet.babyEatingSpace = (snapshotValue?["babyEatingSpace"] as? Bool)!
            
            
            self.toilet.babyChair = (snapshotValue?["babyChair"] as? Bool)!
            self.toilet.babySoffa = (snapshotValue?["babySoffa"] as? Bool)!
            self.toilet.babyKidsToilet = (snapshotValue?["kidsToilet"] as? Bool)!
            self.toilet.babyKidsSpace = (snapshotValue?["kidsSpace"] as? Bool)!
            self.toilet.babyHeightMeasure = (snapshotValue?["babyHeight"] as? Bool)!
            self.toilet.babyWeightMeasure = (snapshotValue?["babyWeight"] as? Bool)!
            self.toilet.babyToy = (snapshotValue?["babyToy"] as? Bool)!
            self.toilet.babyFancy = (snapshotValue?["babyFancy"] as? Bool)!
            self.toilet.babySmellGood = (snapshotValue?["babySmellGood"] as? Bool)!
            
            
            
            
            let reviewCount = snapshotValue?["reviewCount"] as? Int
            self.toilet.reviewCount = reviewCount!
            print(" reviewCount= \(String(describing: reviewCount))")
            
            
            let averageWait = snapshotValue?["averageWait"] as? Int
            self.toilet.averageWait = averageWait!
            
            self.toilet.latitude = (snapshotValue?["latitude"] as? Double)!
            self.toilet.longitude = (snapshotValue?["longitude"] as? Double)!
            
            print("self.toilet.latitude == \(self.toilet.latitude)")
            print("self.toilet.longditude == \(self.toilet.longitude)")
            
            
            self.toilet.loc = CLLocation(latitude: self.toilet.latitude, longitude: self.toilet.longitude)
            print("toilet.loc == \(self.toilet.loc)")
            
            
            //print("center Place Detail = \(self.search.centerSearchLocation)")
            
            self.toilet.distance = MapViewController.distanceCalculationGetString(destination: self.toilet.loc, center: self.search.centerSearchLocation)
            
            
                        
            
            if self.toilet.japanesetoilet{
                self.booleans.append("japanese_toilet".localized)
            }
            if self.toilet.westerntoilet{
                self.booleans.append("western_toilet".localized)
            }
            if self.toilet.onlyFemale{
                self.booleans.append("female_toilet".localized)
            }
            if self.toilet.unisex{
                self.booleans.append("unisex_toilet".localized)
            }
            
            
            if self.toilet.washlet{
                self.booleans.append("washlet".localized)
            }
            if self.toilet.warmSeat{
                self.booleans.append("toilet_warm_seat".localized)
            }
            if self.toilet.autoOpen{
                self.booleans.append("automated_open_toilet_seat".localized)
            }
            if self.toilet.noVirus{
                self.booleans.append("antibackterial_toilet_seat".localized)
            }
            if self.toilet.paperForBenki{
                self.booleans.append("toilet_seat_paper".localized)
            }
            if self.toilet.cleanerForBenki{
                self.booleans.append("便座クリーナー")
            }
            if self.toilet.autoToiletWash{
                self.booleans.append("自動洗浄")
            }
            
            
            
            if self.toilet.sensorHandWash{
                self.booleans.append("センサー式お手洗い")
            }
            if self.toilet.handSoap{
                self.booleans.append("ハンドソープ")
            }
            
            if self.toilet.autoHandSoap{
                self.booleans.append("自動ハンドソープ")
            }
            if self.toilet.paperTowel{
                self.booleans.append("ペーパータオル")
            }
            if self.toilet.handDrier{
                self.booleans.append("ハンドドライヤー")
            }
            
            
            
            if self.toilet.otohime{
                self.booleans.append("音姫")
            }
            if self.toilet.napkinSelling{
                self.booleans.append("ナプキン販売機")
            }
            if self.toilet.makeuproom{
                self.booleans.append("メイクルーム")
            }
            
            if self.toilet.clothes{
                self.booleans.append("洋服掛け")
            }
            if self.toilet.baggageSpace{
                self.booleans.append("荷物置き")
            }
            
            
            
            
            if self.toilet.wheelchair{
                self.booleans.append("車イス対応")
            }
            if self.toilet.wheelchairAccess{
                self.booleans.append("車イスでアクセス可能")
            }
            if self.toilet.autoDoor{
                self.booleans.append("自動ドア")
            }
            if self.toilet.callHelp{
                self.booleans.append("呼び出しボタン")
            }
            
            if self.toilet.ostomate{
                self.booleans.append("オストメイト")
            }
            if self.toilet.english{
                self.booleans.append("英語表記")
            }
            if self.toilet.braille{
                self.booleans.append("点字案内")
            }
            if self.toilet.voiceGuide{
                self.booleans.append("音声案内")
            }
            
            
            
            if self.toilet.fancy{
                self.booleans.append("おしゃれ")
            }
            if self.toilet.smell{
                self.booleans.append("良い香り")
            }
            
            if self.toilet.conforatableWide{
                self.booleans.append("快適な広さ")
            }
            if self.toilet.noNeedAsk{
                self.booleans.append("声かけ不要")
            }
            if self.toilet.parking{
                self.booleans.append("駐車場")
            }
            if self.toilet.airCondition{
                self.booleans.append("冷暖房")
            }
            if self.toilet.wifi{
                self.booleans.append("無料Wi-Fi")
            }
            
            
            if self.toilet.milkspace{
                self.booleans.append("授乳スペース")
            }
            
            if self.toilet.babyroomOnlyFemale{
                self.booleans.append("女性限定")
            }
            if self.toilet.babyroomManCanEnter{
                self.booleans.append("男性入室可能")
            }
            if self.toilet.babyPersonalSpace{
                self.booleans.append("個室あり")
            }
            if self.toilet.babyPersonalSpaceWithLock{
                self.booleans.append("鍵付き個室あり")
            }
            if self.toilet.babyRoomWideSpace{
                self.booleans.append("広いスペース")
            }
            if self.toilet.babyCarRental{
                self.booleans.append("ベビーカー貸し出し")
            }
            
            if self.toilet.babyCarAccess{
                self.booleans.append("ベビーカーでアクセス可能")
            }
            if self.toilet.omutu{
                self.booleans.append("おむつ交換台")
            }
            if self.toilet.hipWashingStuff{
                self.booleans.append("おしりふき")
            }
            if self.toilet.babyTrashCan{
                self.booleans.append("おむつ用ゴミ箱")
            }
            if self.toilet.omutuSelling{
                self.booleans.append("おむつ販売機")
            }
            
            
            
            
            if self.toilet.babyRoomSink{
                self.booleans.append("シンク")
            }
            
            if self.toilet.babyWashStand{
                self.booleans.append("洗面台")
            }
            if self.toilet.babyHotWater{
                self.booleans.append("給湯器")
            }
            if self.toilet.babyMicroWave{
                self.booleans.append("電子レンジ")
            }
            if self.toilet.babyWaterSelling{
                self.booleans.append("飲料販売機")
            }
            if self.toilet.babyFoddSelling{
                self.booleans.append("離乳食販売機")
            }
            if self.toilet.babyEatingSpace{
                self.booleans.append("飲食スペース")
            }
            
            
            
            
            if self.toilet.babyChair{
                self.booleans.append("ベビーチェア")
            }
            if self.toilet.babySoffa{
                self.booleans.append("ソファ")
            }
            if self.toilet.babyKidsToilet{
                self.booleans.append("キッズトイレ")
            }
            if self.toilet.babyKidsSpace{
                self.booleans.append("キッズスペース")
            }
            if self.toilet.babyHeightMeasure{
                self.booleans.append("身長計")
            }
            if self.toilet.babyWeightMeasure{
                self.booleans.append("体重計")
            }
            
            if self.toilet.babyToy{
                self.booleans.append("おもちゃ")
            }
            if self.toilet.babyFancy{
                self.booleans.append("おしゃれ")
            }
            if self.toilet.babySmellGood{
                self.booleans.append("良い香り")
            }
            
            
            //                self.toilet.distance = Double(distance)
            
            self.booleansTableView.reloadData()
            
            self.layoutInfoReady()
            
        })
    }
    
    func layoutInfoReady(){
        
        
        
        placeNameLabel.text = toilet.name
        locationAuthStatus()
        
        // let coordinate1: CLLocationCoordinate2D = toilet.loc.coordinate
        
        print("toilet.latitude222 == \(toilet.latitude)")
        print("toilet.longditude222 == \(toilet.longitude)")
        
        let toiletCoordinate = CLLocationCoordinate2D(latitude: toilet.latitude, longitude: toilet.longitude)
        print(" toiletCoordinate== \(toiletCoordinate)")
        
        
        let pinAnnotation = MKPointAnnotation()
        //pinAnnotation.coordinate = coordinate1
        pinAnnotation.coordinate = toiletCoordinate
        
        print(" pinAnnotation.coordinate== \(pinAnnotation.coordinate)")
        
        //return 0,0
        
        mapView.addAnnotation(pinAnnotation)
        
        
        mapView.tintColor = UIColor.blue
        let focusArea = 1200
        
        //            if toilet.distance <= 50{
        //                focusArea = 100}else
        //                if toilet.distance <= 100{
        //                    focusArea = 200}else
        //                    if toilet.distance <= 300{
        //                        focusArea = 600}else
        //                        if toilet.distance <= 500{
        //                            focusArea = 1200}else
        //                            if toilet.distance <= 900{
        //                                focusArea = 2000}
        //
        
        let region = MKCoordinateRegionMakeWithDistance(toiletCoordinate, CLLocationDistance(focusArea), CLLocationDistance(focusArea))
        
        //            let region = MKCoordinateRegionMakeWithDistance(coordinate1, CLLocationDistance(focusArea), CLLocationDistance(focusArea))
        mapView.setRegion(region, animated: true)
        
        let distanceText = toilet.distance
        
        print("toiletDistance22233 == \(toilet.distance)")
        
        var typeString = ""
        
        
        if toilet.type == 0{
            typeString = "public_restroom".localized
        } else if toilet.type == 1{
            typeString = "convenience_store".localized
        } else if toilet.type == 2{
            typeString = "caffe".localized
        } else if toilet.type == 3{
            typeString = "restaurant".localized
        } else if toilet.type == 4{
            typeString = "shopping_center".localized

        } else if toilet.type == 5{
            typeString = "tourist_places".localized
        } else if toilet.type == 6{
            typeString = "stadium".localized
            
        } else if toilet.type == 7{
            typeString = "portable_toilet".localized
        } else if toilet.type == 8{
            typeString = "home_toilet".localized
        }

        
        typeAndDistanceLabel.text = typeString + "/" + distanceText
        
        reviewCountLabel.text = "(\(toilet.reviewCount)件)"
        
        availableTimeAndWaitingTImeLabel.text = toilet.openinghours + "/" + "平均待ち　\(toilet.averageWait)分"
        
        
        starImage.rating = Double(toilet.averageStar)!
        starImage.settings.filledColor = UIColor.yellow
        starImage.settings.emptyBorderColor = UIColor.orange
        starImage.settings.filledBorderColor = UIColor.orange
        starImage.text = "\(toilet.averageStar)"
        starImage.settings.textColor = UIColor.orange
        
        starImage.settings.textFont = UIFont.boldSystemFont(ofSize: 20.0)
        starImage.settings.textMargin = 5
        
        
        //        starLabel.text = "\(toilet.averageStar)"
        // pictureBackLabel.backgroundColor = UIColor.white
        
        
        
        buttonGoOutlet.backgroundColor = primaryColor
        buttonShowDetailOutlet.backgroundColor = primaryColor
        
        howToAccessTextView.text = "アクセス情報"
        
        if toilet.urlOne != ""{
            picture1.sd_setImage(with: URL(string: toilet.urlOne))
            bigPicture.sd_setImage(with: URL(string: toilet.urlOne))
            
        }
        if toilet.urlTwo != ""{
            picture2.sd_setImage(with: URL(string: toilet.urlTwo))
            
        }
        if toilet.urlThree != ""{
            picture3.sd_setImage(with: URL(string: toilet.urlThree))
            
        }
        
        howToAccessTextView.text = toilet.howtoaccess
        howToAccessTextView.isUserInteractionEnabled = false
        
        let date = NSDate()
        let calendar = Calendar.current
        let day = calendar.component(.day, from:date as Date)
        let month = calendar.component(.month, from:date as Date)
        let year = calendar.component(.year, from:date as Date)
        
        print("yearmonthday = \(year):\(month):\(day)")
        
        firstPosterQuery()
        lastEditerQuery()
        
        userLoginCheck()
        
        
    }
    
    func firstPosterQuery(){
        let userRef = FIRDatabase.database().reference().child("Users")
        userRef.child(toilet.addedBy).observe(FIRDataEventType.value, with: { snapshot in
            
            if self.firstEditerHelpCountAdded == false{
                
                let snapshotValue = snapshot.value as? NSDictionary
                self.firstPosterNameLabel.text = (snapshotValue?["userName"] as? String!)!
                let imageURL = (snapshotValue?["userPhoto"] as? String!)!
                
                if imageURL != ""{
                    //means user real picture not a default one...
                    self.firstPosterPicture.sd_setImage(with: URL(string: imageURL!))
                }
                
                let userLikeCount = (snapshotValue?["totalLikedCount"] as? Int)!
                let userFavotiteCount = (snapshotValue?["totalFavoriteCount"] as? Int)!
                let userHelpedCount = (snapshotValue?["totalHelpedCount"] as? Int)!
                
                self.firstPosterFavoriteNumber = userFavotiteCount
                let newHelpCount = userHelpedCount + 1
                
                self.firstPosterLikeLabel.text = "\(userLikeCount)"
                self.firstPosterFavoriteLabel.text = "\(userFavotiteCount)"
                self.firstPosterHelpLabel.text = "\(newHelpCount)"
                
                let newData : [String : Any] = ["totalHelpedCount": newHelpCount]
                
                
                
                userRef.child(self.toilet.addedBy).updateChildValues(newData)
                
                self.firstEditerHelpCountAdded = true
            }
        })
        
    }
    
    
    func lastEditerQuery(){
        let userRef = FIRDatabase.database().reference().child("Users")
        userRef.child(toilet.editedBy).observe(FIRDataEventType.value, with: { snapshot in
            
            if self.lastEditerHelpCountAdded == false{
                
                let snapshotValue = snapshot.value as? NSDictionary
                self.lastEditerNameLabel.text = (snapshotValue?["userName"] as? String!)!
                let imageURL = (snapshotValue?["userPhoto"] as? String!)!
                
                if imageURL != ""{
                    //means user real picture not a default one...
                    self.lastEditerPicture.sd_setImage(with: URL(string: imageURL!))
                }
                
                let userLikeCount = (snapshotValue?["totalLikedCount"] as? Int)!
                let userFavotiteCount = (snapshotValue?["totalFavoriteCount"] as? Int)!
                let userHelpedCount = (snapshotValue?["totalHelpedCount"] as? Int)!
                
                self.lastEditerFavoriteNumber = userFavotiteCount
                
                let newHelpCount = userHelpedCount + 1
                
                
                
                
                self.lastEditerLikeLabel.text = "\(userLikeCount)"
                self.lastEditerFavoriteLabel.text = "\(userFavotiteCount)"
                self.lastEditerHelpLabel.text = "\(newHelpCount)"
                
                let newData : [String : Any] = ["totalHelpedCount": newHelpCount]
                
                
                userRef.child(self.toilet.editedBy).updateChildValues(newData)
                
                self.lastEditerHelpCountAdded = true
            }
            
        })
        
    }
    
    
    
    
    func thumbsUpQuery(){
        
        print("thumbsUpQuery( Called")
        let thumbsUpRef = FIRDatabase.database().reference().child("ThumbsUpList").child(FIRAuth.auth()!.currentUser!.uid)
        thumbsUpRef.observe(FIRDataEventType.childAdded, with: {(snapshot) in
            self.thumbsUpSet.insert(snapshot.key)
            print("ThumbSetQuery == \(self.thumbsUpSet)")
            
            
        })
        
        
        if self.toilet.reviewOne != ""{
            self.reviewOneQuery(ridOne: self.toilet.reviewOne)
        }
        
        if self.toilet.reviewTwo != ""{
            self.reviewTwoQuery(ridTwo: self.toilet.reviewTwo)
        }
        

        
    }
    
//    func thumbsUpUpload(){
//        //delete all of them 
//        
//        
//        let thumbsUpRef = FIRDatabase.database().reference().child("ThumbsUpList").child(FIRAuth.auth()!.currentUser!.uid)
//        for item in thumbsUpSet{
//            
//            thumbsUpRef.child(item).setValue(true)
//           // thumbsUpRef.updateChildValues()
//            
//        }
//    }
    
    
    func favoriteListQuery(){
        
        print("liked Query Called")
        let favoriteRef = FIRDatabase.database().reference().child("FavoriteList").child(FIRAuth.auth()!.currentUser!.uid)
        favoriteRef.observe(FIRDataEventType.childAdded, with: {(snapshot) in
            self.favoriteSet.insert(snapshot.key)
            print("Favorite List insert\(snapshot.key)")
            
            if self.favoriteSet.contains(self.toilet.key){
                let image = UIImage(named:"love_Icon_40")
                self.favoriteButtonOutlet.setImage(image, for: .normal)
                print("Image is supposed to be replacedAAA")
                self.favoriteButtonTapped = true
            }
            
        })
    }
    
    
    
    func reviewOneQuery(ridOne: String){
        
        print("Tid = \(toilet.key)")
        print("Rid One = \(ridOne)")
        
        let reviewsRef = FIRDatabase.database().reference().child("ReviewInfo")
        
        reviewsRef.child(ridOne).observe(FIRDataEventType.value, with: { snapshot in
            if self.firebaseReviewOneLoadedOnce == false{
                let review = Review()
                let snapshotValue = snapshot.value as? NSDictionary
                
                print("Snapshot 88888 = \(snapshot)")
                
                let star = snapshotValue?["star"] as? String
                
                review.star = Double(star!)!
                let feedback = snapshotValue?["feedback"] as? String
                review.feedback = feedback!
                
                let time = snapshotValue?["time"] as? String
                review.time = time!
                print("review.time = \(review.time)")
                
                let waitingtime = snapshotValue?["waitingtime"] as? String
                review.waitingtime = waitingtime! + "分待ちました"
                
                let timeNumbers = snapshotValue?["timeNumbers"] as? Double
                review.timeNumbers = timeNumbers!
                
                let likedCount = snapshotValue?["likedCount"] as? Int
                review.likedCount = likedCount!
                
                let uid = snapshotValue?["uid"] as? String
                review.uid = uid!
                
                self.reviewOnePoster = review.uid
                
                review.rid = snapshot.key
                
                
                let userRef = FIRDatabase.database().reference().child("Users")
                userRef.child(uid!).queryOrderedByKey().observe(FIRDataEventType.value, with: {(snapshot) in
                    if self.firebaseReviewOneLoadedOnce == false{
                        print("snapshot = \(snapshot)")
                        
                        let snapshotValue = snapshot.value as? NSDictionary
                        
                        let userName = snapshotValue?["userName"] as? String
                        review.userName = userName!
                        print("review.userName = \(review.userName)")
                        
                        let userPhoto = snapshotValue?["userPhoto"] as? String
                        review.userPhoto = userPhoto!
                        print("review.userPhoto = \(review.userPhoto)")
                        
                        let totalFavoriteCount = snapshotValue?["totalFavoriteCount"] as? Int
                        review.totalFavoriteCount = totalFavoriteCount!
                        
                        let totalHelpedCount = snapshotValue?["totalHelpedCount"] as? Int
                        review.totalHelpedCount = totalHelpedCount!
                        
                        let totalLikedCount = snapshotValue?["totalLikedCount"] as? Int
                        review.totalLikedCount = totalLikedCount!
                        
                        self.reviewOneThumbOriginalCount = review.likedCount
                        self.reviewOneUserTotalLikeOriginalCount = review.totalLikedCount
                        //let newThumbCount = review.likedCount + 1
                        //                        self.reviewOneThumbUpdatedCount = newThumbCount
//                        let newThumbTotalCount = review.totalLikedCount + 1
//                        self.reviewOneUSerTotalikeUpdatedCount = newThumbTotalCount
                        
                        
                        
                        self.reviewOneUserImage.sd_setImage(with: URL(string: review.userPhoto))
                        self.reviewOneUserNameLabel.text = review.userName
                        
                        self.reviewOneUserLikeCount.text = String(review.totalLikedCount)
                        self.reviewOneUserFavoriteCount.text = String(review.totalFavoriteCount)
                        self.reviewOneUserHelpCount.text = String(review.totalHelpedCount)
                        
                        self.reviewOneFeedbackTextView.text = review.feedback
                        self.reviewOneThumbUpCountLabel.text = "いいね" + String(review.likedCount) + "件"
                        self.reviewOneDateStringLabel.text = review.time
                        self.reviewOneWaitingMinuteLabel.text = review.waitingtime
                        
                        self.firebaseReviewOneLoadedOnce = true
                        
                        if self.thumbsUpSet.contains(review.rid){
                            self.reviewOneThumbUpButtonOutlet.setImage(self.imageColored, for: .normal)
                            self.reviewOneLikeAlreadyTapped = true
                            
//                            let newReducedCount = review.likedCount - 1
//                            self.reviewOneThumbUpdatedCount = newReducedCount
//                            
//                            let newReducedTotalCount = review.totalLikedCount - 1
//                            self.reviewOneUSerTotalikeUpdatedCount = newReducedTotalCount
                            
                            
//                            self.reviewOneUserLikeCount.text = String(self.reviewOneUSerTotalikeUpdatedCount)
//                            self.reviewOneThumbUpCountLabel.text = "いいね" + String(self.reviewOneThumbUpdatedCount) + "件"
                            
                        }
                        
                    }})}
        })
    }
    
    
    func reviewTwoQuery(ridTwo: String){
        
        print("Rid Two = \(ridTwo)")
        
        
        let reviewsRef = FIRDatabase.database().reference().child("ReviewInfo")
        
        reviewsRef.child(ridTwo).observe(FIRDataEventType.value, with: { snapshot in
            if self.firebaseReviewTwoLoadedOnce == false{
                let review = Review()
                let snapshotValue = snapshot.value as? NSDictionary
                
                let star = snapshotValue?["star"] as? String
                
                review.star = Double(star!)!
                let feedback = snapshotValue?["feedback"] as? String
                review.feedback = feedback!
                
                let time = snapshotValue?["time"] as? String
                review.time = time!
                print("review.time = \(review.time)")
                
                let waitingtime = snapshotValue?["waitingtime"] as? String
                review.waitingtime = waitingtime! + "分待ちました"
                
                let timeNumbers = snapshotValue?["timeNumbers"] as? Double
                review.timeNumbers = timeNumbers!
                
                let likedCount = snapshotValue?["likedCount"] as? Int
                review.likedCount = likedCount!
                
                let uid = snapshotValue?["uid"] as? String
                review.uid = uid!
                
                self.reviewTwoPoster = review.uid
                
                review.rid = snapshot.key
                
//                if self.thumbsUpSet.contains(review.rid){
//                    
//                    print("self.likedSet.contains(review.rid)")
//                    self.reviewTwoThumbUpButtonOutlet.setImage(self.imageColored, for: .normal)
//                    self.reviewTwoLikeAlreadyTapped = true
//                    review.userLiked = true
//                }
                
                
                let userRef = FIRDatabase.database().reference().child("Users")
                userRef.child(uid!).queryOrderedByKey().observe(FIRDataEventType.value, with: {(snapshot) in
                    if self.firebaseReviewTwoLoadedOnce == false{
                        
                        
                        print("snapshot = \(snapshot)")
                        
                        let snapshotValue = snapshot.value as? NSDictionary
                        
                        let userName = snapshotValue?["userName"] as? String
                        review.userName = userName!
                        print("review.userName = \(review.userName)")
                        
                        let userPhoto = snapshotValue?["userPhoto"] as? String
                        review.userPhoto = userPhoto!
                        print("review.userPhoto = \(review.userPhoto)")
                        
                        let totalFavoriteCount = snapshotValue?["totalFavoriteCount"] as? Int
                        review.totalFavoriteCount = totalFavoriteCount!
                        
                        let totalHelpedCount = snapshotValue?["totalHelpedCount"] as? Int
                        review.totalHelpedCount = totalHelpedCount!
                        
                        let totalLikedCount = snapshotValue?["totalLikedCount"] as? Int
                        review.totalLikedCount = totalLikedCount!
                        
//                        self.reviewOneLike = "いいね" + String(review.likedCount) + "件"
//                        let newLikedCount = review.likedCount + 1
//                        self.reviewOneUserLikeUpdatedCount = "いいね" + String(newLikedCount) + "件"
                        
                        self.reviewTwoThumbOriginalCount = review.likedCount
                        //let newThumbCount = review.likedCount + 1
                       // self.reviewTwoThumbUpdatedCount = newThumbCount
                        self.reviewTwoUserTotalLikeOriginalCount = review.totalLikedCount
                       // let newThumbTotalCount = review.totalLikedCount + 1
                        //self.reviewTwoUserTotalLikeUpdatedCount = newThumbTotalCount
                        
//                        var reviewTwoThumbOriginalCount = ""
//                        var reviewTwoThumbUpdatedCount = ""
//                        var reviewTwoUserTotalLikeOriginalCount = ""
//                        var reviewTwoUserTotalLikeUpdatedCount = ""

//                        
                        
                        
                        self.reviewTwoUserImage.sd_setImage(with: URL(string: review.userPhoto))
                        self.reviewTwoUserNameLabel.text = review.userName
                        
                        self.reviewTwoUserLikeCount.text = String(review.totalLikedCount)
                        self.reviewTwoUserFavoriteCount.text = String(review.totalFavoriteCount)
                        self.reviewTwoUserHelpCount.text = String(review.totalHelpedCount)
                        
                        self.reviewTwoUserFeedbackTextView.text = review.feedback
                        self.reviewTwoThumbUpCountLabel.text = "いいね" + String(review.likedCount) + "件"
                        self.reviewTwoDateStringOutlet.text = review.time
                        self.reviewTwoWatingTImeLabel.text = review.waitingtime
                        
                        self.firebaseReviewTwoLoadedOnce = true
                        
                        if self.thumbsUpSet.contains(review.rid){
                            self.reviewTwoThumbUpButtonOutlet.setImage(self.imageColored, for: .normal)
                            self.reviewTwoLikeAlreadyTapped = true
//                            
//                            let newReducedCount = review.likedCount - 1
//                            self.reviewTwoThumbUpdatedCount = newReducedCount
//                            
//                            
//                            let newReducedTotalCount = review.totalLikedCount - 1
//                            self.reviewTwoUserTotalLikeUpdatedCount = newReducedTotalCount
//                            
                            
//                            self.reviewTwoUserLikeCount.text = String(self.reviewTwoUserTotalLikeUpdatedCount)
//                            self.reviewTwoThumbUpCountLabel.text = "いいね" + String(self.reviewTwoThumbUpdatedCount) + "件"
                            
                            
                        }

                        
                    }})}
        })
    }
    
    
    
    func afterFavoriteTappedAction()
    {
        //firebaseLoadedOnce = true
        let firebaseRef = FIRDatabase.database().reference()
        let userRef = firebaseRef.child("FavoriteList").child(FIRAuth.auth()!.currentUser!.uid)
        userRef.child(toilet.key).setValue(true)
        
        print("afterFavoriteTappedAction Called")
        
        
        if toilet.addedBy != ""{
            
             print("afterFavoriteTappedAction Added")
            let firstPosterFavoriteCountRef = firebaseRef.child("Users").child(toilet.addedBy)
            
            let tdata : [String : Any] = ["totalFavoriteCount": firstPosterFavoriteNumber + 1]
            firstPosterFavoriteCountRef.updateChildValues(tdata)
            
        
        }
        
        if toilet.editedBy != ""{
            print("afterFavoriteTappedAction edited")
            
            let lastEditerFavoriteCountRef = firebaseRef.child("Users").child(toilet.editedBy)
            
            let tdata : [String : Any] = ["totalFavoriteCount": lastEditerFavoriteNumber + 1]
            lastEditerFavoriteCountRef.updateChildValues(tdata)

        }
        
//        totalFavoriteCountRef.observe(FIRDataEventType.value, with: {(snapshot) in
//            if self.favoriteAdded == false{
//                print("FVFVsnapshot = \(snapshot)")
//                print("FVFVsnapshot.key = \(snapshot.key)")
//                print("FVFVsnapshot.value = \(String(describing: snapshot.value))")
//                let snapValue = snapshot.value as? Int
//                let newFavorite = snapValue! + 1
//                totalFavoriteCountRef.setValue(newFavorite)
//                self.favoriteAdded = true
//            }})
        
        
        
        
        //Added single event observer May 16 
        
       
        
        
        
        

        
        let alertController = UIAlertController (title: "お気に入りに追加されました", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "はい", style: .default, handler: nil)
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
//    func deleteItInMyPage(){
//        
//        let alertController = UIAlertController (title: "お気に入りリストから削除するには、マイページのお気に入りリストから削除してください", message: "", preferredStyle: .alert)
//        let addAction = UIAlertAction(title: "はい", style: .default, handler: nil)
//        alertController.addAction(addAction)
//        present(alertController, animated: true, completion: nil)
//        
//    }
    
    
    
    
    //        @IBAction func hensyuuButtonTapped(_ sender: Any) {
    //            performSegue(withIdentifier: "EditInformationSegue", sender: nil)
    //        }
    
    
    func goAction() {
        
        var place: MKPlacemark!
        let coordinate1: CLLocationCoordinate2D = toilet.loc.coordinate
        place = MKPlacemark(coordinate: coordinate1)
        let destination = MKMapItem(placemark: place)
        destination.name = toilet.name
        let regionDistance: CLLocationDistance = 1000
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinate1, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey:  NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking] as [String : Any]
        
        let firebaseRef = FIRDatabase.database().reference()
        firebaseRef.child("UserWentList").child(FIRAuth.auth()!.currentUser!.uid).child(toilet.key).setValue(true)
        
        let addedTotalHelpedCountRef = firebaseRef.child("Users").child(toilet.addedBy).child("totalHelpedCount")
        
        addedTotalHelpedCountRef.observe(FIRDataEventType.value, with: {(snapshot) in
            if self.youwentAdded == false{
                print("FVFVsnapshot = \(snapshot)")
                print("FVFVsnapshot.key = \(snapshot.key)")
                print("FVFVsnapshot.value = \(String(describing: snapshot.value))")
                let snapValue = snapshot.value as? Int
                let newHelped = snapValue! + 1
                addedTotalHelpedCountRef.setValue(newHelped)
                self.youwentAdded = true
            }})
        
        let editedTotalHelpedCountRef = firebaseRef.child("Users").child(toilet.editedBy).child("totalHelpedCount")
        editedTotalHelpedCountRef.observe(FIRDataEventType.value, with: {(snapshot) in
            if self.youwentEdited == false{
                print("FVFVsnapshot = \(snapshot)")
                print("FVFVsnapshot.key = \(snapshot.key)")
                print("FVFVsnapshot.value = \(String(describing: snapshot.value))")
                let snapValue = snapshot.value as? Int
                let newHelped = snapValue! + 1
                editedTotalHelpedCountRef.setValue(newHelped)
                self.youwentEdited = true
            }})
        
        
        MKMapItem.openMaps(with: [destination], launchOptions: options)
    }
    
    
    @IBAction func kansouButtonTapped(_ sender: Any) {
        
        if userAlreadyLogin == true{
            
            performSegue(withIdentifier: "kansouSegue", sender: nil)
            print(toilet.key)
            
        }else{
            showPleaseLogin()
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "kansouSegue"{
            print("TEST!")
            let nextVC = segue.destination as! KansouViewController
            nextVC.toilet = toilet
            nextVC.filter = filter
            nextVC.search = search
            
            
        }
        
        
        
        if segue.identifier == "placeDetailToEditSegue"{
            let nextV = segue.destination as! EditTableViewController
            
            let coordinate: CLLocationCoordinate2D = toilet.loc.coordinate
            
            nextV.toilet = toilet
            nextV.filter = filter
            nextV.search = search
            
            print("toilet.loc = \(toilet.loc)")
            
            nextV.pincoodinate = coordinate
        }
        
        if segue.identifier == "placeDetailToReviewTVSegue"{
            let nextVC = segue.destination as! ReviewTableViewController
            
            nextVC.toilet = toilet
            nextVC.filter = filter
            nextVC.search = search
            
            
            
            
        }
        
        if segue.identifier == "detailbacktoMapSegue"{
            print("TEST!")
            let nextVC = segue.destination as! MapViewController
            nextVC.filter = filter
            nextVC.search = search
        }
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            let alertController = UIAlertController (title: "GPS singal not found", message: "Change GPS settings?", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    //        func buttonClicked(sender:UIButton) {
    //            print("like button is clickedddddd")
    //            firebaseLoadedOnce = true
    //            let youLikedRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("youLiked")
    //            let buttonRow = sender.tag
    //            let likedID = reviews[buttonRow].rid
    //            let addLikeCount = reviews[buttonRow].likedCount + 1
    //            let removeLikeCount = reviews[buttonRow].likedCount - 1
    //            let firebaseRef = FIRDatabase.database().reference()
    //            let likedRef = firebaseRef.child("reviews").child(reviews[buttonRow].rid).child("likedCount")
    //            let userTotalLikedRef = firebaseRef.child("users").child(reviews[buttonRow].uid).child("totalLikedCount")
    //            let addTotalLikeCount = reviews[buttonRow].totalLikedCount + 1
    //            let removeTotalLikeCount = reviews[buttonRow].totalLikedCount - 1
    //
    //            if reviews[buttonRow].userLiked == false{
    //                reviews[buttonRow].userLiked = true
    //                if let image = UIImage(named:"like1") {
    //                    sender.setImage(image, for: .normal)
    //                    self.likedSet.insert(likedID)
    //                    likedRef.setValue(addLikeCount)
    //                    userTotalLikedRef.setValue(addTotalLikeCount)
    //
    //                    print("likedSet = \(likedSet)")
    //
    //                    youLikedRef.child(likedID).setValue(true)
    //                }
    //            }else{
    //                reviews[buttonRow].userLiked = false
    //                if let image = UIImage(named:"like") {
    //                    sender.setImage(image, for: .normal)
    //                    self.likedSet.remove(likedID)
    //                    likedRef.setValue(removeLikeCount)
    //                    userTotalLikedRef.setValue(removeTotalLikeCount)
    //                    print("likedSet = \(likedSet)")
    //
    //                    youLikedRef.child(likedID).removeValue { (error, ref) in
    //                        if error != nil {
    //                            print("error \(error)")
    //                        }
    //                    }
    //                }
    //            }
    //        }
    
    func hideTableView(){
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        booleanTableViewLeftConstraint.constant = screenWidth
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func showUpTableView(){
        
        booleanTableViewLeftConstraint.constant = 120
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func buttonBackToMapTapped(_ sender: Any) {
        performSegue(withIdentifier:"detailBackToMapSegue", sender: nil)
        
    }
    
    @IBAction func buttonReportTapped(_ sender: Any) {
        
        if userAlreadyLogin == true{
            let alertController = UIAlertController (title: "", message: "情報の誤りを報告しますか", preferredStyle: .actionSheet)
            
            let yesAction = UIAlertAction(title: "報告する", style: .default) { (_) -> Void in
                self.toiletReportStart()
                
            }
            let cancelAction = UIAlertAction(title: "報告しない", style: .default, handler: nil)
            alertController.addAction(yesAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }else{
            showPleaseLogin()
            
        }
        
    }
    
    func toiletReportStart(){
        
        var problemString = ""
        let nextAlertController = UIAlertController (title: "お願い", message: "問題だと思う点を教えてください", preferredStyle: .actionSheet)
        
        let wrongPhoto = UIAlertAction(title: "施設の写真が不適切である", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "the picture of this place is not appropriate"
            self.toiletProblemUpload(problemString: problemString)
        })
        
        let wrongInfo =  UIAlertAction(title: "施設の情報が正確でない", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "the infomation of this place is not correct"
            self.toiletProblemUpload(problemString: problemString)
            
        })
        
        let firstPosterNotAppropriate = UIAlertAction(title: "投稿者の名前または写真が適切ではない", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "Fisrt Poster Not Appropriate"
            self.toiletProblemUpload(problemString: problemString)
            
        })
        
        
        let lastEditerNotAppropriate = UIAlertAction(title: "編集者の名前または写真が適切ではない", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "Last Editer Not Appropriate"
            self.toiletProblemUpload(problemString: problemString)
            
        })
        
        
        
        let stillYes = UIAlertAction(title: "いいえ、問題はありません", style: .default, handler: {(alert:
            UIAlertAction!) in
            return
        })
        
        nextAlertController.addAction(wrongPhoto)
        nextAlertController.addAction(wrongInfo)
        nextAlertController.addAction(firstPosterNotAppropriate)
        nextAlertController.addAction(lastEditerNotAppropriate)
        nextAlertController.addAction(stillYes)
        
        
        self.present(nextAlertController, animated: true, completion: nil)

        
    
    
    
    }
    
    func toiletProblemUpload(problemString: String){
        
        let toiletProblemsRef = FIRDatabase.database().reference().child("ToiletInfoProblems")
        let rpid = UUID().uuidString
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
        
       
            
            
        
        let rpData : [String : Any] = ["uid": uid,
                                           "tid": toilet.key,
                                           "time": timeString,
                                           "timeNumbers": interval,
                                           "problem": problemString
                
            ]
            
        toiletProblemsRef.child(rpid).setValue(rpData)
        
        suspiciosUserId = toilet.editedBy
        userWarningListUpload()
        
        
        
    }
    

    
    
    
    
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        if userAlreadyLogin == false{
            showPleaseLogin()
            
        }else{
            
            print("Favorite Tapped")
            let loveColored = UIImage(named:"love_Icon_40")
            let loveDark = UIImage(named:"love_before_tap_40")
            
            
            
            if favoriteButtonTapped == false{
                //sender.setImage(image, forControlState: .Normal)
                (sender as AnyObject).setImage(loveColored, for: .normal)
                print("Image is supposed to be replacedAAA")
                favoriteButtonTapped = true
                self.afterFavoriteTappedAction()
                
            } else{
                (sender as AnyObject).setImage(loveDark, for: .normal)

                let userRef = firebaseRef.child("FavoriteList").child(FIRAuth.auth()!.currentUser!.uid)
                userRef.child(toilet.key).removeValue()
                 favoriteButtonTapped = false
                
                

            }
        }
    }
    
    
    @IBAction func buttonShowDetailTapped(_ sender: Any) {
        
        showUpTableView()
        
    }
    
    
    @IBAction func buttonAddFeedbackTapped(_ sender: Any) {
        //"placeDetailToKansouSegue"
        if userAlreadyLogin == false{
            showPleaseLogin()
            
        }else{
            
            
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationContoller = storyboard.instantiateViewController(withIdentifier: "KansouNavigationViewController") as! UINavigationController
            let nextVC = navigationContoller.topViewController as! KansouViewController
            
            
            nextVC.toilet = toilet
            nextVC.filter = filter
            nextVC.search = search
            
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            
            self.present(navigationContoller, animated: false, completion: nil)
        }
        
        
    }
    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        print(msg)
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = primaryColor
        //messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)//witdh 50 to 200
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    
    
    @IBAction func buttonEditTapped(_ sender: Any) {
        if userAlreadyLogin == false{
            showPleaseLogin()
            
        }else{
            
            
            print("edit tapped 11")
            progressBarDisplayer(msg:"", true)
            performSegue(withIdentifier:"placeDetailToEditSegue", sender: nil)
        }
        
    }
    @IBAction func buttonGoToThisPlaceTapped(_ sender: Any) {
        goAction()
    }
    
    @IBAction func buttonShowAllReviewsTapped(_ sender: Any) {
        print("Show Reviews Tapped")
        performSegue(withIdentifier:"placeDetailToReviewTVSegue", sender: nil)
        
        
        //            performSegue(withIdentifier:"placeDetailToReviewTVSegue", withIdentifier: <#String#>, sender: nil)
        //            "placeDetailToReviewTVSegue"
    }
    
    
    
    @IBAction func reviewOneLikeButtonTapped(_ sender: Any) {
        let thumbsUpRef = FIRDatabase.database().reference().child("ThumbsUpList").child(FIRAuth.auth()!.currentUser!.uid)
        let userRef = FIRDatabase.database().reference().child("Users").child(FIRAuth.auth()!.currentUser!.uid)
        let reviewInfoRef = FIRDatabase.database().reference().child("ReviewInfo").child(self.toilet.reviewTwo)
//        self.reviewOneThumbOriginalCount = review.likedCount
//        self.reviewOneUserTotalLikeOriginalCount = review.totalLikedCount

        
        if userAlreadyLogin == false{
            showPleaseLogin()
            
        }else{
            
            
            
            
            if self.reviewOneLikeAlreadyTapped == false{
                
                //Tap
                
                (sender as AnyObject).setImage(imageColored, for: .normal)
            
                //self.thumbsUpSet.insert(self.toilet.reviewOne)
                thumbsUpRef.child(self.toilet.reviewOne).setValue(true)
                
                
                                
                self.reviewOneUserTotalLikeOriginalCount = self.reviewOneUserTotalLikeOriginalCount + 1
                self.reviewOneThumbOriginalCount = self.reviewOneThumbOriginalCount + 1
                
                
                
                self.reviewOneUserLikeCount.text = String(self.reviewOneUserTotalLikeOriginalCount)
                self.reviewOneThumbUpCountLabel.text = "いいね" + String(self.reviewOneThumbOriginalCount) + "件"
                
                let userInfoUpdate: [String : Any] = ["totalLikedCount": self.reviewOneUserTotalLikeOriginalCount]
                userRef.updateChildValues(userInfoUpdate)
                
                let reviewInfoUpdate: [String : Any] = ["likedCount": self.reviewOneThumbOriginalCount]
                reviewInfoRef.updateChildValues(reviewInfoUpdate)
                
                self.reviewOneLikeAlreadyTapped = true
                
                
                
            }else {
                
                //UnTap
                
                (sender as AnyObject).setImage(imageBlack, for: .normal)
                
               // self.thumbsUpSet.remove(self.toilet.reviewOne)
                
                thumbsUpRef.child(self.toilet.reviewOne).removeValue()
                
                self.reviewOneUserTotalLikeOriginalCount = self.reviewOneUserTotalLikeOriginalCount - 1
                 self.reviewOneThumbOriginalCount = self.reviewOneThumbOriginalCount - 1
                
                
                self.reviewOneUserLikeCount.text = String(self.reviewOneUserTotalLikeOriginalCount)
                self.reviewOneThumbUpCountLabel.text = "いいね" + String(self.reviewOneThumbOriginalCount) + "件"
                
                
                
                let userInfoUpdate: [String : Any] = ["totalLikedCount": self.reviewOneUserTotalLikeOriginalCount]
                userRef.updateChildValues(userInfoUpdate)
                
                let reviewInfoUpdate: [String : Any] = ["likedCount": self.reviewOneThumbOriginalCount]
                reviewInfoRef.updateChildValues(reviewInfoUpdate)
                
                self.reviewOneLikeAlreadyTapped = false
                

                
                
                
            }
            
        }
        
        
        
    }
    
    
    @IBAction func reviewTwoLikeButtonTapped(_ sender: Any) {
        let thumbsUpRef = FIRDatabase.database().reference().child("ThumbsUpList").child(FIRAuth.auth()!.currentUser!.uid)
        let userRef = FIRDatabase.database().reference().child("Users").child(FIRAuth.auth()!.currentUser!.uid)
        let reviewInfoRef = FIRDatabase.database().reference().child("ReviewInfo").child(self.toilet.reviewTwo)
        
        if userAlreadyLogin == false{
            showPleaseLogin()
            
        }else{
            if self.reviewTwoLikeAlreadyTapped == false{
                
                //Tap
                
                //update count label
                
                (sender as AnyObject).setImage(imageColored, for: .normal)
                self.reviewTwoLikeAlreadyTapped = true
                
                thumbsUpRef.child(self.toilet.reviewTwo).setValue(true)
                self.newThumbsUpSet.insert(self.toilet.reviewTwo)
                
                self.reviewTwoUserTotalLikeOriginalCount = self.reviewTwoUserTotalLikeOriginalCount + 1
                self.reviewTwoThumbOriginalCount = self.reviewTwoThumbOriginalCount + 1
                
                
                self.reviewTwoUserLikeCount.text = String(self.reviewTwoUserTotalLikeOriginalCount)
                self.reviewTwoThumbUpCountLabel.text = "いいね" + String(self.reviewTwoThumbOriginalCount) + "件"
                
                
                //update firebase data
                
                
                
                let userInfoUpdate: [String : Any] = ["totalLikedCount": self.reviewTwoUserTotalLikeOriginalCount]
                userRef.updateChildValues(userInfoUpdate)
                
                let reviewInfoUpdate: [String : Any] = ["likedCount": self.reviewTwoThumbOriginalCount]
                reviewInfoRef.updateChildValues(reviewInfoUpdate)
                
                
            }else{
                
                
                //UnTap
                
                self.reviewTwoUserTotalLikeOriginalCount = self.reviewTwoUserTotalLikeOriginalCount - 1
                self.reviewTwoThumbOriginalCount = self.reviewTwoThumbOriginalCount - 1
                
                (sender as AnyObject).setImage(imageBlack, for: .normal)
                
                thumbsUpRef.child(self.toilet.reviewTwo).removeValue()
                
                self.reviewTwoUserLikeCount.text = String(self.reviewTwoUserTotalLikeOriginalCount)
                self.reviewTwoThumbUpCountLabel.text = "いいね" + String(self.reviewTwoThumbOriginalCount) + "件"
                
                let userInfoUpdate: [String : Any] = ["totalLikedCount": self.reviewTwoUserTotalLikeOriginalCount]
                userRef.updateChildValues(userInfoUpdate)
                
                let reviewInfoUpdate: [String : Any] = ["likedCount": self.reviewTwoThumbOriginalCount]
                reviewInfoRef.updateChildValues(reviewInfoUpdate)
                
                self.reviewTwoLikeAlreadyTapped = false
                
            }
            
        }
    }
    
    @IBAction func reviewOneReportButtonTapped(_ sender: Any) {
       postRid = toilet.reviewOne
       suspiciosUserId = reviewOnePoster
       reviewReportStart()
    }
    
    
    @IBAction func reviewTwoReportButtonTapped(_ sender: Any) {
        postRid = toilet.reviewTwo
        suspiciosUserId = reviewTwoPoster
        reviewReportStart()
    }
    
    
    func reviewReportStart(){
        
        
        let alertController = UIAlertController (title: "この感想に問題がありますか？", message: "Oh well", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "はい", style: .default, handler: {(alert:
            UIAlertAction!) in
            self.whatIsTheProblem()
        })
        let cancelAction = UIAlertAction(title: "いいえ", style: .default, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    func whatIsTheProblem(){
        
        var problemString = ""
        let nextAlertController = UIAlertController (title: "お願い", message: "問題だと思う点を教えてください", preferredStyle: .actionSheet)
        
        let wrongInfo = UIAlertAction(title: "感想の内容に誤りがあるから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "The content of the review is not correct"
            self.problemUpload(problemString: problemString)
        })
        
        let reviewNotRelevent =  UIAlertAction(title: "感想の内容に不適切な表現があるから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "The content of the review is not relevent"
            self.problemUpload(problemString: problemString)
            
        })
        
        let pictureNotAppropriate = UIAlertAction(title: "感想を投稿したユーザーの写真が適切ではないから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "The picture of the user is not appropriate"
            self.problemUpload(problemString: problemString)
            
        })
        
        
        let nameNotAppropriate = UIAlertAction(title: "感想を投稿したユーザーの名前が適切ではないから", style: .default, handler: {(alert:UIAlertAction!) in
            
            problemString = "The name of the user is not appropriate"
            self.problemUpload(problemString: problemString)
            
        })
        
        
        
        let stillYes = UIAlertAction(title: "いいえ、問題はありません", style: .default, handler: {(alert:
            UIAlertAction!) in
            return
        })
        
        nextAlertController.addAction(wrongInfo)
        nextAlertController.addAction(reviewNotRelevent)
        nextAlertController.addAction(pictureNotAppropriate)
        nextAlertController.addAction(nameNotAppropriate)
        nextAlertController.addAction(stillYes)
        
        
        self.present(nextAlertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    func problemUpload(problemString: String){
        
        let toiletProblemsRef = FIRDatabase.database().reference().child("ReviewProblems")
        let rpid = UUID().uuidString
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
        
        if postRid != ""{
            
            
            
            
            let rpData : [String : Any] = ["uid": uid,
                                           "rid": postRid,
                                           "time": timeString,
                                           "timeNumbers": interval,
                                           "problem": problemString
                
            ]
            
            toiletProblemsRef.child(rpid).setValue(rpData)
            
            
            
            reviewWarningListUpload()
            userWarningListUpload()
        }
        
    }
    
    func reviewWarningListUpload(){
        let reviewWarningsRef = FIRDatabase.database().reference().child("ReviewWarningList")
        let uid = FIRAuth.auth()!.currentUser!.uid
        reviewWarningsRef.child(postRid).child(uid).setValue(true)
        
        reviewWarningListCount()
        
        
        }
    
    func reviewWarningListCount(){
        let reviewWarningsRef = FIRDatabase.database().reference().child("ReviewWarningList")
        
        
        reviewWarningsRef.child(postRid).observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
            
            let countNumber = snapshot.childrenCount
            self.reviewWarningCountUploadToDatabase(countNumber: Int(countNumber))
        })
    }
    
//    func reviewWarningListCount(){
//        let reviewWarningsRef = FIRDatabase.database().reference().child("ReviewWarningList")
//        
//        reviewWarningsRef.child(postRid).observe(FIRDataEventType.value, with: { snapshot in
//            
//            if self.reviewReportOnceUploaded == false{
//                self.reviewReportOnceUploaded = true
//                
//                let countNumber = snapshot.childrenCount
//                self.reviewWarningCountUploadToDatabase(countNumber: Int(countNumber))
//                
//                
//                
//            }
//        })
//    }
    
    func reviewWarningCountUploadToDatabase(countNumber: Int){
        let reviewWarningCountRef = FIRDatabase.database().reference().child("ReviewWarningCount")
        
        reviewWarningCountRef.child(postRid).setValue(countNumber)
        
        showYourReviewPostedMessage()
        
        

    }
    
    
    
    func userWarningListUpload(){
        let userWarningsRef = FIRDatabase.database().reference().child("UserWarningList")
        let uid = FIRAuth.auth()!.currentUser!.uid
        userWarningsRef.child(suspiciosUserId).child(uid).setValue(true)
        
        userWarningListCount()
        
        
    }
    
    func userWarningListCount(){
        let userWarningsRef = FIRDatabase.database().reference().child("UserWarningList")
        
        userWarningsRef.child(suspiciosUserId).observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
            
            let countNumber = snapshot.childrenCount
            self.userWarningCountUploadToDatabase(countNumber: Int(countNumber))
            
            
        })
    }

    
    
//    func userWarningListCount(){
//        let userWarningsRef = FIRDatabase.database().reference().child("UserWarningList")
//        
//        userWarningsRef.child(suspiciosUserId).observe(FIRDataEventType.value, with: { snapshot in
//            
//            if self.userReportOnceUploaded == false{
//                self.userReportOnceUploaded = true
//                
//                let countNumber = snapshot.childrenCount
//                self.userWarningCountUploadToDatabase(countNumber: Int(countNumber))
//                
//                
//                
//            }
//        })
//    }
    
    func userWarningCountUploadToDatabase(countNumber: Int){
        let userWarningCountRef = FIRDatabase.database().reference().child("UserWarningCount")
        
        userWarningCountRef.child(suspiciosUserId).setValue(countNumber)
        
        showYourReviewPostedMessage()
        
        
        
    }

    
    
    
    func showYourReviewPostedMessage(){
        
        let alertController = UIAlertController (title: "ありがとうございます", message: "あなたの報告が完了しました", preferredStyle: .alert)
        
        
        let yesAction = UIAlertAction(title: "はい", style: .default, handler: nil);  alertController.addAction(yesAction)
        
        present(alertController, animated: true, completion: nil)
    }
    

    
    
    
}
