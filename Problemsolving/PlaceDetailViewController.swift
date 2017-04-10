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
    
    class PlaceDetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
        //UITableViewDelegate, UITableViewDataSource
    {
        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////            if reviews.count == 0{
////                backgroundScrollView.contentSize = CGSize(width: 320,height: 1036)
////            }
////            if reviews.count == 1{
////                backgroundScrollView.contentSize = CGSize(width: 320,height: 1254)
////            }
////            if reviews.count >= 2{
////                backgroundScrollView.contentSize = CGSize(width: 320,height: 1432)
////            }
//            return reviews.count
//        }
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = Bundle.main.loadNibNamed("ReviewTableViewCell", owner: self, options: nil)?.first as! ReviewTableViewCell
//            
//            cell.feedbackTextView.backgroundColor = UIColor.white
//            cell.feedbackTextView.isUserInteractionEnabled = false
//            
//            cell.userPhotoImage.sd_setImage(with: URL(string: reviews[indexPath.row].userPhoto))
//            cell.userPhotoImage.layer.masksToBounds = true
//            cell.userPhotoImage.layer.cornerRadius = 25.5
//            ////////////// 5 to 25.5
//            
//            let myColor : UIColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.1)
//            cell.userPhotoImage.layer.borderColor = myColor.cgColor
//            cell.userPhotoImage.layer.borderWidth = 1
//            cell.starRatedLabel.rating = reviews[indexPath.row].star
//            cell.feedbackTextView.text = reviews[indexPath.row].feedback
//            cell.userNameLabel.text = reviews[indexPath.row].userName
//            cell.dateLabel.text = reviews[indexPath.row].time
//            cell.selectionStyle = UITableViewCellSelectionStyle.none
//            cell.likedCountLabel.text = "いいね\(reviews[indexPath.row].likedCount)件"
//            cell.nextLikedCountLabel.isHidden = true
//            cell.nextUserLikedCount.isHidden = true
//            cell.userFavoritedCount.text = "\(reviews[indexPath.row].totalFavoriteCount)"
//            cell.userHelpedCount.text = "\(reviews[indexPath.row].totalHelpedCount)"
//            cell.userLikedCount.text = "\(reviews[indexPath.row].totalLikedCount)"
//            
//            cell.starRatedLabel.settings.filledColor = UIColor.yellow
//            cell.starRatedLabel.settings.emptyBorderColor = UIColor.orange
//            cell.starRatedLabel.settings.filledBorderColor = UIColor.orange
//            
//            
//            cell.likeButton.addTarget(self, action: #selector(DetailViewController.buttonClicked), for: .touchUpInside)
//            
//            if reviews[indexPath.row].userLiked == true {
//                cell.likeButton.setImage(UIImage(named: "like1"), for: UIControlState.normal)
//                let nextNumber = reviews[indexPath.row].likedCount - 1
//                let nextLikedNumber = reviews[indexPath.row].totalLikedCount - 1
//                cell.nextLikedCountLabel.text = "いいね\(nextNumber)件"
//                cell.nextUserLikedCount.text = "\(nextLikedNumber)"
//            } else{
//                let nextNumber = reviews[indexPath.row].likedCount + 1
//                let nextLikedNumber = reviews[indexPath.row].totalLikedCount + 1
//                cell.nextLikedCountLabel.text = "いいね\(nextNumber)件"
//                cell.nextUserLikedCount.text = "\(nextLikedNumber)"
//            }
//            
//            if reviews[indexPath.row].waitingtime == "0"{
//                cell.waitingMinuteLabel.text = "待ちなし"
//            }else {
//                let waitminutes = "\(reviews[indexPath.row].waitingtime)分待ち"
//                cell.waitingMinuteLabel.text = waitminutes}
//            return cell
//        }
//        
//        
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 218
//        }
//        
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            print("didselect")
//        }
        
//        @IBOutlet weak var backgroundScrollView: UIScrollView!
        
        @IBOutlet weak var backgroundScrollView: UIScrollView!
        
        @IBOutlet weak var bigPicture: UIImageView!
        
        @IBOutlet weak var placeNameLabel: UILabel!
        
        @IBOutlet weak var typeAndDistanceLabel: UILabel!
        
        @IBOutlet weak var availableTimeAndWaitingTImeLabel: UILabel!
        
        
        @IBOutlet weak var starImage: CosmosView!
        
        @IBOutlet weak var starLabel: UILabel!
        
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
        
        
        @IBOutlet weak var reviewTwoUserImage: UIImageView!
        
        @IBOutlet weak var reviewTwoUserNameLabel: UILabel!
        
        @IBOutlet weak var reviewTwoUserLikeCount: UILabel!
        
        @IBOutlet weak var reviewTwoUserFavoriteCount: UILabel!
        
        @IBOutlet weak var reviewTwoUserHelpCount: UILabel!
        
        @IBOutlet weak var reviewTwoUserFeedbackTextView: UITextView!
        
        
//        
//        @IBOutlet weak var backView: UIView!
//        @IBOutlet weak var bigPicture: UIImageView!
//        
//        @IBOutlet weak var distanceLabel: UILabel!
//        @IBOutlet weak var nameLabel: UILabel!
//        
//        @IBOutlet weak var starImage: CosmosView!
//        
//        @IBOutlet weak var starLabel: UILabel!
//        @IBOutlet weak var waitingtimeLabel: UILabel!
//        
//        
//        @IBOutlet weak var openinghoursLabel: UILabel!
//        
//        @IBOutlet weak var pictureLabel: UILabel!
//        
//        @IBOutlet weak var picture1: UIImageView!
//        @IBOutlet weak var picture2: UIImageView!
//        @IBOutlet weak var picture3: UIImageView!
//        @IBOutlet weak var accessTextView: UITextView!
//        @IBOutlet weak var backLabel1: UILabel!
//        @IBOutlet weak var backLabel2: UILabel!
//        @IBOutlet weak var availableLabel: UILabel!
//        @IBOutlet weak var okiniiriButton: UIButton!
//        @IBOutlet weak var kansouButton: UIButton!
//        @IBOutlet weak var hensyuuButton: UIButton!
//        @IBOutlet weak var goButton: UIButton!
//        
//        
//        @IBOutlet weak var categoryType: UILabel!
//        
//        @IBOutlet weak var tableView: UITableView!
//        
//        @IBOutlet weak var pictureBackLabel: UILabel!
//        
//        @IBOutlet weak var mapView: MKMapView!
//        
//        @IBOutlet weak var reviewCountLabel: UILabel!
        
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
        var reviewsSet = Set<String>()
        var likedSet = Set<String>()
        var toilet = Toilet()
        var review = Review()
        var filter = Filter()
        var search = Search()
        var favoriteAdded = false
        var youwentAdded = false
        var youwentEdited = false
        var firebaseLoadedOnce = false
        var locationManager = CLLocationManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            mapView.delegate = self
            mapView.isUserInteractionEnabled = false
            
            dataQuery(queryKey: toilet.key)
//            tableView.dataSource = self
//            tableView.delegate = self
//            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "review")
//            
//            print("reviewsSet = \(reviewsSet)")
//            
//            bigPicture.sd_setImage(with: URL(string: toilet.urlOne))
//            placeNameLabel.text = toilet.name
//            locationAuthStatus()
//            
//            let coordinate1: CLLocationCoordinate2D = toilet.loc.coordinate
//            let pinAnnotation = MKPointAnnotation()
//            pinAnnotation.coordinate = coordinate1
//            mapView.addAnnotation(pinAnnotation)
//            
//            mapView.tintColor = UIColor.blue
//            var focusArea = 2000
//            
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
//            
//            let region = MKCoordinateRegionMakeWithDistance(coordinate1, CLLocationDistance(focusArea), CLLocationDistance(focusArea))
//            mapView.setRegion(region, animated: true)
//            
//            var distanceText = ""
//            
//            
//            if toilet.distance > 1000{
//                let td1 = round(0.01*toilet.distance)/0.01/1000
//                print("td1 = \(td1)")
//                distanceText = "\(td1)km"
//                
//            } else{
//                distanceText = "\(Int(round(0.1*toilet.distance)/0.1))m"
//            }
//            
//            if toilet.distance >= 1000000{
//                let toiletD = Int(round(0.01*toilet.distance)/0.01/1000000)
//                distanceText = "\(toiletD)Mm"
//                print("cell.distanceLabel.text = \(toiletD)Mm")
//            }
//            
//            typeAndDistanceLabel.text = toilet.type + "/" + distanceText
//            
//            reviewCountLabel.text = "(\(toilet.reviewCount)件)"
//            
////            waitingtimeLabel.text = "平均待ち時間　\(toilet.averageWait)分"
////            // Changed to toilet.averageWait
////            openinghoursLabel?.text = "利用可能時間　\(toilet.openinghours)"
//            
//            availableTimeAndWaitingTImeLabel.text = toilet.openinghours + "/" + "平均待ち　\(toilet.averageWait)分"
//            
//            
//            starImage.rating = Double(toilet.averageStar)!
//            starImage.settings.filledColor = UIColor.yellow
//            starImage.settings.emptyBorderColor = UIColor.orange
//            starImage.settings.filledBorderColor = UIColor.orange
//            starImage.text = "\(toilet.averageStar)"
//            starImage.settings.textColor = UIColor.black
//            starImage.settings.textMargin = 10
//            
//            
//            //        starLabel.text = "\(toilet.averageStar)"
//           // pictureBackLabel.backgroundColor = UIColor.white
//            buttonGoOutlet.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
//            buttonKansouOutlet.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
//            buttonEditInfoOutlet.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
//            //okiniiriButton.backgroundColor = UIColor(red: 1.2, green: 0.4, blue: 0.4, alpha: 0.7)
//            
////            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
////            tableView.tableFooterView?.isHidden = true
////            tableView.backgroundColor = UIColor.white
//            //Added for table view empty cells
//            
////            backLabel1.backgroundColor = UIColor.white
////            backLabel2.backgroundColor = UIColor.white
////            pictureLabel.backgroundColor = UIColor.white
//            howToAccessTextView.text = "アクセス情報"
//            picture1.sd_setImage(with: URL(string: toilet.urlOne))
//            picture2.sd_setImage(with: URL(string: toilet.urlTwo))
//            picture3.sd_setImage(with: URL(string: toilet.urlThree))
//            
//            
//            howToAccessTextView.text = toilet.howtoaccess
//            howToAccessTextView.isUserInteractionEnabled = false
//            
//            let date = NSDate()
//            let calendar = Calendar.current
//            let day = calendar.component(.day, from:date as Date)
//            let month = calendar.component(.month, from:date as Date)
//            let year = calendar.component(.year, from:date as Date)
//            
//            print("yearmonthday = \(year):\(month):\(day)")
//            
            likedQuery()
            //reviewQuery()
        }
        
        func dataQuery(queryKey: String){
            
            let toiletsRef = FIRDatabase.database().reference().child("Toilets")
            
            
            
            toiletsRef.child(queryKey).observe(FIRDataEventType.value, with: { snapshot in
//                let toilet = Toilet()
                /////        //////Copied from new one April 6   .....
                
                
                self.toilet.key = queryKey
                let snapshotValue = snapshot.value as? NSDictionary
                
                
                self.toilet.urlOne = (snapshotValue?["urlOne"] as? String!)!
                self.toilet.urlTwo = (snapshotValue?["urlTwo"] as? String!)!
                self.toilet.urlThree = (snapshotValue?["urlThree"] as? String)!
                self.toilet.address = (snapshotValue?["address"] as? String)!
                self.toilet.howtoaccess = (snapshotValue?["howtoaccess"] as? String)!
                self.toilet.addedBy = (snapshotValue?["addedBy"] as? String)!
                self.toilet.editedBy = (snapshotValue?["editedBy"] as? String)!
                self.toilet.openinghours = (snapshotValue?["openAndCloseHours"] as? String)!
                
                let averageStar = snapshotValue?["averageStar"] as? String
                self.toilet.star = Double(averageStar!)!
                
                
                
                self.toilet.name = (snapshotValue?["name"] as? String)!
                self.toilet.type = (snapshotValue?["type"] as? String)!
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
                self.toilet.handrail = (snapshotValue?["handrail"] as? Bool)!
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
                print(" reviewCount= \(reviewCount)")
                
                
                let averageWait = snapshotValue?["averageWait"] as? Int
                self.toilet.averageWait = averageWait!
                
                self.toilet.latitude = (snapshotValue?["latitude"] as? Double)!
                self.toilet.longitude = (snapshotValue?["longitude"] as? Double)!
                
                print("self.toilet.latitude == \(self.toilet.latitude)")
                print("self.toilet.longditude == \(self.toilet.longitude)")
                
                
                self.toilet.loc = CLLocation(latitude: self.toilet.latitude, longitude: self.toilet.longitude)
                 print("toilet.loc == \(self.toilet.loc)")
                
            
                print("center Place Detail = \(self.search.centerSearchLocation)")

                let distance = self.toilet.loc.distance(from: self.search.centerSearchLocation)
                
                print("distance111 == \(distance)")

                
                //center == user location
                
                //toilet lat lng,  I have already have it
                
                
                self.toilet.distance = Double(distance)
                
                self.layoutInfoReady()
            
            })
        }
        
        func layoutInfoReady(){
            
            bigPicture.sd_setImage(with: URL(string: toilet.urlOne))
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
            var focusArea = 2000
            
            if toilet.distance <= 50{
                focusArea = 100}else
                if toilet.distance <= 100{
                    focusArea = 200}else
                    if toilet.distance <= 300{
                        focusArea = 600}else
                        if toilet.distance <= 500{
                            focusArea = 1200}else
                            if toilet.distance <= 900{
                                focusArea = 2000}
            
            
             let region = MKCoordinateRegionMakeWithDistance(toiletCoordinate, CLLocationDistance(focusArea), CLLocationDistance(focusArea))
            
//            let region = MKCoordinateRegionMakeWithDistance(coordinate1, CLLocationDistance(focusArea), CLLocationDistance(focusArea))
            mapView.setRegion(region, animated: true)
            
            var distanceText = ""
            
            print("toiletDistance22233 == \(toilet.distance)")
            
            if toilet.distance > 1000{
                let td1 = round(0.01*toilet.distance)/0.01/1000
                print("td1 = \(td1)")
                distanceText = "\(td1)km"
                
            } else{
                distanceText = "\(Int(round(0.1*toilet.distance)/0.1))m"
            }
            
            if toilet.distance >= 1000000{
                let toiletD = Int(round(0.01*toilet.distance)/0.01/1000000)
                distanceText = "\(toiletD)Mm"
                print("cell.distanceLabel.text = \(toiletD)Mm")
            }
            
            typeAndDistanceLabel.text = toilet.type + "/" + distanceText
            
            reviewCountLabel.text = "(\(toilet.reviewCount)件)"
            
            //            waitingtimeLabel.text = "平均待ち時間　\(toilet.averageWait)分"
            //            // Changed to toilet.averageWait
            //            openinghoursLabel?.text = "利用可能時間　\(toilet.openinghours)"
            
            availableTimeAndWaitingTImeLabel.text = toilet.openinghours + "/" + "平均待ち　\(toilet.averageWait)分"
            
            
            starImage.rating = Double(toilet.averageStar)!
            starImage.settings.filledColor = UIColor.yellow
            starImage.settings.emptyBorderColor = UIColor.orange
            starImage.settings.filledBorderColor = UIColor.orange
            starImage.text = "\(toilet.averageStar)"
            starImage.settings.textColor = UIColor.black
            starImage.settings.textMargin = 10
            
            
            //        starLabel.text = "\(toilet.averageStar)"
            // pictureBackLabel.backgroundColor = UIColor.white
            buttonGoOutlet.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
            buttonKansouOutlet.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
            buttonEditInfoOutlet.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
            //okiniiriButton.backgroundColor = UIColor(red: 1.2, green: 0.4, blue: 0.4, alpha: 0.7)
            
            //            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            //            tableView.tableFooterView?.isHidden = true
            //            tableView.backgroundColor = UIColor.white
            //Added for table view empty cells
            
            //            backLabel1.backgroundColor = UIColor.white
            //            backLabel2.backgroundColor = UIColor.white
            //            pictureLabel.backgroundColor = UIColor.white
            howToAccessTextView.text = "アクセス情報"
            
            if toilet.urlOne != ""{
                picture1.sd_setImage(with: URL(string: toilet.urlOne))
                
            }
            if toilet.urlTwo != ""{
                picture2.sd_setImage(with: URL(string: toilet.urlTwo))
                
            }
            if toilet.urlThree != ""{
                picture3.sd_setImage(with: URL(string: toilet.urlThree))
                
            }
            
            
//            picture1.sd_setImage(with: URL(string: toilet.urlOne))
//            picture2.sd_setImage(with: URL(string: toilet.urlTwo))
//            picture3.sd_setImage(with: URL(string: toilet.urlThree))
            
            
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
        
        
        }
        
        func firstPosterQuery(){
            let userRef = FIRDatabase.database().reference().child("users")
            userRef.child(toilet.addedBy).observe(FIRDataEventType.value, with: { snapshot in
                
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
                
                self.firstPosterLikeLabel.text = "\(userLikeCount)"
                self.firstPosterFavoriteLabel.text = "\(userFavotiteCount)"
                self.firstPosterHelpLabel.text = "\(userHelpedCount)"
            })
            
        }
        
        
        func lastEditerQuery(){
            let userRef = FIRDatabase.database().reference().child("users")
            userRef.child(toilet.editedBy).observe(FIRDataEventType.value, with: { snapshot in
                
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
                
                self.lastEditerLikeLabel.text = "\(userLikeCount)"
                self.lastEditerFavoriteLabel.text = "\(userFavotiteCount)"
                self.lastEditerHelpLabel.text = "\(userHelpedCount)"
            })
            
        }

        
        func likedQuery(){
            
            print("liked Query Called")
            let youLikedRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("youLiked")
            youLikedRef.observe(FIRDataEventType.childAdded, with: {(snapshot) in
                self.likedSet.insert(snapshot.key)
                print("likedSet = \(self.likedSet)")
                print("liked Query End")
                
            })
            
            //April 8
            
            
            //        let youLikedRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("youLiked")
            //        youLikedRef.observe(FIRDataEventType.childAdded, with: {(snapshot) in
            //            self.likedSet.insert(snapshot.key)
            //            print("likedSet = \(self.likedSet)")
            //
            //        })
        }
        
        
//        func reviewQuery(){
//            
//            print("review Query Called")
//            
//            let reviewsRef = FIRDatabase.database().reference().child("reviews")
//            
//            reviewsRef.queryOrdered(byChild: "tid").queryEqual(toValue: toilet.key).observe(.childAdded, with: { snapshot in
//                if self.firebaseLoadedOnce == false{
//                    print("snapshot = \(snapshot)")
//                    print("snapshot.key = \(snapshot.key)")
//                    print("snapshot.value = \(snapshot.value)")
//                    let review = Review()
//                    
//                    let snapshotValue = snapshot.value as? NSDictionary
//                    
//                    let star = snapshotValue?["star"] as? String
//                    print("star = \(star)!!!")
//                    review.star = Double(star!)!
//                    let feedback = snapshotValue?["feedback"] as? String
//                    review.feedback = feedback!
//                    
//                    let time = snapshotValue?["time"] as? String
//                    review.time = time!
//                    print("review.time = \(review.time)")
//                    
//                    let waitingtime = snapshotValue?["waitingtime"] as? String
//                    review.waitingtime = waitingtime!
//                    
//                    let timeNumbers = snapshotValue?["timeNumbers"] as? Double
//                    review.timeNumbers = timeNumbers!
//                    
//                    let likedCount = snapshotValue?["likedCount"] as? Int
//                    review.likedCount = likedCount!
//                    
//                    let uid = snapshotValue?["uid"] as? String
//                    review.uid = uid!
//                    
//                    review.rid = snapshot.key
//                    
//                    if self.likedSet.contains(review.rid){
//                        print("self.likedSet.contains(review.rid)")
//                        review.userLiked = true
//                    }
//                    
//                    
//                    let userRef = FIRDatabase.database().reference().child("users")
//                    userRef.child(uid!).queryOrderedByKey().observe(FIRDataEventType.value, with: {(snapshot) in
//                        if self.firebaseLoadedOnce == false{
//                            print("userRef.child(uid!).observe(.childAdded, with: { snapshot in")
//                            print("snapshot = \(snapshot)")
//                            
//                            let snapshotValue = snapshot.value as? NSDictionary
//                            
//                            let userName = snapshotValue?["userName"] as? String
//                            review.userName = userName!
//                            print("review.userName = \(review.userName)")
//                            
//                            let userPhoto = snapshotValue?["userPhoto"] as? String
//                            review.userPhoto = userPhoto!
//                            print("review.userPhoto = \(review.userPhoto)")
//                            
//                            let totalFavoriteCount = snapshotValue?["totalFavoriteCount"] as? Int
//                            review.totalFavoriteCount = totalFavoriteCount!
//                            
//                            let totalHelpedCount = snapshotValue?["totalHelpedCount"] as? Int
//                            review.totalHelpedCount = totalHelpedCount!
//                            
//                            let totalLikedCount = snapshotValue?["totalLikedCount"] as? Int
//                            review.totalLikedCount = totalLikedCount!
//                            
//                            self.reviews.append(review)
//                            self.reviewsSet.insert(snapshot.key)
//                            self.reviews.sort(){$0.timeNumbers > $1.timeNumbers}
//                            self.tableView.reloadData()
//                            
//                            print("review Query End")
//                            
//                            //I moved codes above here because review tableview could not be loaded 26th
//                            //when the value is changed, tableveiw loads again and again
//                        }})}
//            })
//        }
        
        
        @IBAction func okiniiriButtonTapped(_ sender: Any)
        {   firebaseLoadedOnce = true
            let firebaseRef = FIRDatabase.database().reference()
            let userRef = firebaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid)
            userRef.child("favourite").child(toilet.key).setValue(true)
            let totalFavoriteCountRef = firebaseRef.child("users").child(toilet.addedBy).child("totalFavoriteCount")
            totalFavoriteCountRef.observe(FIRDataEventType.value, with: {(snapshot) in
                if self.favoriteAdded == false{
                    print("FVFVsnapshot = \(snapshot)")
                    print("FVFVsnapshot.key = \(snapshot.key)")
                    print("FVFVsnapshot.value = \(snapshot.value)")
                    let snapValue = snapshot.value as? Int
                    let newFavorite = snapValue! + 1
                    totalFavoriteCountRef.setValue(newFavorite)
                    self.favoriteAdded = true
                }})
            
            let alertController = UIAlertController (title: "お気に入りに追加されました", message: "", preferredStyle: .alert)
            let addAction = UIAlertAction(title: "はい", style: .default, handler: nil)
            alertController.addAction(addAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
        
        @IBAction func hensyuuButtonTapped(_ sender: Any) {
            performSegue(withIdentifier: "EditInformationSegue", sender: nil)
        }
        
        
        @IBAction func goButtonTapped(_ sender: Any) {
            
            var place: MKPlacemark!
            let coordinate1: CLLocationCoordinate2D = toilet.loc.coordinate
            place = MKPlacemark(coordinate: coordinate1)
            let destination = MKMapItem(placemark: place)
            destination.name = toilet.key
            let regionDistance: CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinate1, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey:  NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking] as [String : Any]
            
            let firebaseRef = FIRDatabase.database().reference()
            firebaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).child("youwent").child(toilet.key).setValue(true)
            
            let addedTotalHelpedCountRef = firebaseRef.child("users").child(toilet.addedBy).child("totalHelpedCount")
            
            addedTotalHelpedCountRef.observe(FIRDataEventType.value, with: {(snapshot) in
                if self.youwentAdded == false{
                    print("FVFVsnapshot = \(snapshot)")
                    print("FVFVsnapshot.key = \(snapshot.key)")
                    print("FVFVsnapshot.value = \(snapshot.value)")
                    let snapValue = snapshot.value as? Int
                    let newHelped = snapValue! + 1
                    addedTotalHelpedCountRef.setValue(newHelped)
                    self.youwentAdded = true
                }})
            
            let editedTotalHelpedCountRef = firebaseRef.child("users").child(toilet.editedBy).child("totalHelpedCount")
            editedTotalHelpedCountRef.observe(FIRDataEventType.value, with: {(snapshot) in
                if self.youwentEdited == false{
                    print("FVFVsnapshot = \(snapshot)")
                    print("FVFVsnapshot.key = \(snapshot.key)")
                    print("FVFVsnapshot.value = \(snapshot.value)")
                    let snapValue = snapshot.value as? Int
                    let newHelped = snapValue! + 1
                    editedTotalHelpedCountRef.setValue(newHelped)
                    self.youwentEdited = true
                }})
            
            
            MKMapItem.openMaps(with: [destination], launchOptions: options)
        }
        
        
        @IBAction func kansouButtonTapped(_ sender: Any) {
            
            performSegue(withIdentifier: "kansouSegue", sender: nil)
            print(toilet.key)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "kansouSegue"{
                print("TEST!")
                let nextVC = segue.destination as! KansouViewController
                nextVC.toilet = toilet
                nextVC.filter = filter
                nextVC.search = search
                
                
            }
            
            if segue.identifier == "EditInformationSegue"{
                let nextV = segue.destination as! EditTableViewController
                
                let coordinate: CLLocationCoordinate2D = toilet.loc.coordinate
                
                nextV.toilet = toilet
                
                print("toilet.loc = \(toilet.loc)")
                
                nextV.pincoodinate = coordinate
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
        
        
        @IBAction func buttonBackToMapTapped(_ sender: Any) {
            performSegue(withIdentifier:"detailBackToMapSegue", sender: nil)

        }
        
        @IBAction func buttonReportTapped(_ sender: Any) {
            let alertController = UIAlertController (title: "", message: "情報の誤りを報告しますか", preferredStyle: .actionSheet)
            
            let yesAction = UIAlertAction(title: "報告する", style: .default) { (_) -> Void in
                
            }
            let cancelAction = UIAlertAction(title: "報告しない", style: .default, handler: nil)
            alertController.addAction(yesAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        
//        @IBAction func questionButtonTapped(_ sender: Any) {
//            
//            let alertController = UIAlertController (title: "", message: "情報の誤りを報告しますか", preferredStyle: .actionSheet)
//            
//            let yesAction = UIAlertAction(title: "報告する", style: .default) { (_) -> Void in
//                
//            }
//            let cancelAction = UIAlertAction(title: "報告しない", style: .default, handler: nil)
//            alertController.addAction(yesAction)
//            alertController.addAction(cancelAction)
//            present(alertController, animated: true, completion: nil)
//            
//        }
        
//        @IBAction func MapButtonTapped(_ sender: Any) {
//            performSegue(withIdentifier:"detailbacktoMapSegue", sender: nil)
//        }
        
    

    ////Copied from Detail View

   }
