//
//  DetailViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 25/12/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Cosmos

class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviews.count == 0{
            backgroundScrollView.contentSize = CGSize(width: 320,height: 1036)
        }
        if reviews.count == 1{
            backgroundScrollView.contentSize = CGSize(width: 320,height: 1254)
        }
        if reviews.count >= 2{
            backgroundScrollView.contentSize = CGSize(width: 320,height: 1432)
        }
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ReviewTableViewCell", owner: self, options: nil)?.first as! ReviewTableViewCell
        
//        cell.feedbackTextView.backgroundColor = UIColor.white
//        cell.feedbackTextView.isUserInteractionEnabled = false
//        
//        cell.userPhotoImage.sd_setImage(with: URL(string: reviews[indexPath.row].userPhoto))
//        cell.userPhotoImage.layer.masksToBounds = true
//        cell.userPhotoImage.layer.cornerRadius = 25.5
//        ////////////// 5 to 25.5
//        
//        let myColor : UIColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.1)
//        cell.userPhotoImage.layer.borderColor = myColor.cgColor
//        cell.userPhotoImage.layer.borderWidth = 1
//        cell.starRatedLabel.rating = reviews[indexPath.row].star
//        cell.feedbackTextView.text = reviews[indexPath.row].feedback
//        cell.userNameLabel.text = reviews[indexPath.row].userName
//        cell.dateLabel.text = reviews[indexPath.row].time
//        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        cell.likedCountLabel.text = "いいね\(reviews[indexPath.row].likedCount)件"
//        cell.nextLikedCountLabel.isHidden = true
//        cell.nextUserLikedCount.isHidden = true
//        cell.userFavoritedCount.text = "\(reviews[indexPath.row].totalFavoriteCount)"
//        cell.userHelpedCount.text = "\(reviews[indexPath.row].totalHelpedCount)"
//        cell.userLikedCount.text = "\(reviews[indexPath.row].totalLikedCount)"
//        
//        cell.starRatedLabel.settings.filledColor = UIColor.yellow
//        cell.starRatedLabel.settings.emptyBorderColor = UIColor.orange
//        cell.starRatedLabel.settings.filledBorderColor = UIColor.orange
//
//        
//        cell.likeButton.addTarget(self, action: #selector(DetailViewController.buttonClicked), for: .touchUpInside)
//        
//        if reviews[indexPath.row].userLiked == true {
//            cell.likeButton.setImage(UIImage(named: "like1"), for: UIControlState.normal)
//            let nextNumber = reviews[indexPath.row].likedCount - 1
//            let nextLikedNumber = reviews[indexPath.row].totalLikedCount - 1
//            cell.nextLikedCountLabel.text = "いいね\(nextNumber)件"
//            cell.nextUserLikedCount.text = "\(nextLikedNumber)"
//        } else{
//            let nextNumber = reviews[indexPath.row].likedCount + 1
//            let nextLikedNumber = reviews[indexPath.row].totalLikedCount + 1
//            cell.nextLikedCountLabel.text = "いいね\(nextNumber)件"
//            cell.nextUserLikedCount.text = "\(nextLikedNumber)"
//        }
//        
//        if reviews[indexPath.row].waitingtime == "0"{
//            cell.waitingMinuteLabel.text = "待ちなし"
//        }else {
//            let waitminutes = "\(reviews[indexPath.row].waitingtime)分待ち"
//            cell.waitingMinuteLabel.text = waitminutes}
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 218
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didselect")
    }
    
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bigPicture: UIImageView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var starImage: CosmosView!
    
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var waitingtimeLabel: UILabel!
    
    
    @IBOutlet weak var openinghoursLabel: UILabel!
    
    @IBOutlet weak var pictureLabel: UILabel!
    
    @IBOutlet weak var picture1: UIImageView!
    @IBOutlet weak var picture2: UIImageView!
    @IBOutlet weak var picture3: UIImageView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var backLabel1: UILabel!
    @IBOutlet weak var backLabel2: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var okiniiriButton: UIButton!
    @IBOutlet weak var kansouButton: UIButton!
    @IBOutlet weak var hensyuuButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    
    @IBOutlet weak var categoryType: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pictureBackLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "review")
        
        print("reviewsSet = \(reviewsSet)")
        
        bigPicture.sd_setImage(with: URL(string: toilet.urlOne))
        nameLabel.text = toilet.name
        categoryType.text = toilet.type
        locationAuthStatus()
        
        let coordinate1: CLLocationCoordinate2D = toilet.loc.coordinate
        let pinAnnotation = MKPointAnnotation()
        pinAnnotation.coordinate = coordinate1
        mapView.addAnnotation(pinAnnotation)
        
        mapView.tintColor = UIColor.blue
        let focusArea = 1200
        
//        if toilet.distance <= 50{
//            focusArea = 100}else
//            if toilet.distance <= 100{
//                focusArea = 200}else
//                if toilet.distance <= 300{
//                    focusArea = 600}else
//                    if toilet.distance <= 500{
//                        focusArea = 1200}else
//                        if toilet.distance <= 900{
//                            focusArea = 2000}
        
        
        let region = MKCoordinateRegionMakeWithDistance(coordinate1, CLLocationDistance(focusArea), CLLocationDistance(focusArea))
        mapView.setRegion(region, animated: true)
        
//        
//        if toilet.distance > 1000{
//            let td1 = round(0.01*toilet.distance)/0.01/1000
//            print("td1 = \(td1)")
//            distanceLabel.text = "\(td1)km"
//            
//        } else{
//            distanceLabel.text = "\(Int(round(0.1*toilet.distance)/0.1))m"
//        }
//        
//        if toilet.distance >= 1000000{
//            let toiletD = Int(round(0.01*toilet.distance)/0.01/1000000)
//            distanceLabel.text = "\(toiletD)Mm"
//            print("cell.distanceLabel.text = \(toiletD)Mm")
//        }
        
        reviewCountLabel.text = "(\(toilet.reviewCount)件)"
        
        waitingtimeLabel.text = "平均待ち時間　\(toilet.averageWait)分"
        // Changed to toilet.averageWait
        openinghoursLabel?.text = "利用可能時間　\(toilet.openinghours)"
        starImage.rating = Double(toilet.averageStar)!
        starImage.settings.filledColor = UIColor.yellow
        starImage.settings.emptyBorderColor = UIColor.orange
        starImage.settings.filledBorderColor = UIColor.orange
        starImage.text = "\(toilet.averageStar)"
        starImage.settings.textColor = UIColor.black
        starImage.settings.textMargin = 20

        
//        starLabel.text = "\(toilet.averageStar)"
        pictureBackLabel.backgroundColor = UIColor.white
        goButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        kansouButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        hensyuuButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        okiniiriButton.backgroundColor = UIColor(red: 1.2, green: 0.4, blue: 0.4, alpha: 0.7)
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        tableView.tableFooterView?.isHidden = true
        tableView.backgroundColor = UIColor.white
        //Added for table view empty cells
        
        backLabel1.backgroundColor = UIColor.white
        backLabel2.backgroundColor = UIColor.white
        pictureLabel.backgroundColor = UIColor.white
        accessTextView.text = "アクセス情報"
        picture1.sd_setImage(with: URL(string: toilet.urlOne))
        picture2.sd_setImage(with: URL(string: toilet.urlTwo))
        picture3.sd_setImage(with: URL(string: toilet.urlThree))
        
//        if toilet.washlet == true {
//            washletLabel.textColor = UIColor.black
//        }
//        
//        if toilet.wheelchair == true {
//            wheelchairLabel.textColor = UIColor.black
//        }
//        
//        if toilet.onlyFemale == true {
//            femaleToiletLabel.textColor = UIColor.black
//        }
//        
//        if toilet.unisex == true {
//            unisexToiletLabel.textColor = UIColor.black
//        }
//        
//        if toilet.makeuproom == true {
//            makeRoomLabel.textColor = UIColor.black
//        }
//        
//        if toilet.milkspace == true {
//            milkSpaceLabel.textColor = UIColor.black
//        }
//        
//        if toilet.omutu == true {
//            omutuLabel.textColor = UIColor.black
//        }
//        
//        if toilet.ostomate == true {
//            ostomateLabel.textColor = UIColor.black
//        }
//        
//        if toilet.japanesetoilet == true {
//            japaneseToiletLabel.textColor = UIColor.black
//        }
//        
//        if toilet.available == false {
//            availableLabel.textColor = UIColor.red
//        }
//        
//        if toilet.westerntoilet == true {
//            westernToiletLabel.textColor = UIColor.black
//        }
//        
//        if toilet.warmSeat == true {
//            warmToiletLabel.textColor = UIColor.black
//        }
//        
//        
//        if toilet.baggageSpace == true {
//            baggageLabel.textColor = UIColor.black
//        }
        
        accessTextView.text = toilet.howtoaccess
        accessTextView.isUserInteractionEnabled = false
        
        let date = NSDate()
        let calendar = Calendar.current
        let day = calendar.component(.day, from:date as Date)
        let month = calendar.component(.month, from:date as Date)
        let year = calendar.component(.year, from:date as Date)
        
        print("yearmonthday = \(year):\(month):\(day)")
        
        likedQuery()
        reviewQuery()
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
    
    
    func reviewQuery(){
        
        print("review Query Called")

        let reviewsRef = FIRDatabase.database().reference().child("reviews")
        
        reviewsRef.queryOrdered(byChild: "tid").queryEqual(toValue: toilet.key).observe(.childAdded, with: { snapshot in
            if self.firebaseLoadedOnce == false{
                print("snapshot = \(snapshot)")
                print("snapshot.key = \(snapshot.key)")
                print("snapshot.value = \(snapshot.value)")
                let review = Review()
                
                let snapshotValue = snapshot.value as? NSDictionary
                
                let star = snapshotValue?["star"] as? String
                print("star = \(star)!!!")
                review.star = Double(star!)!
                let feedback = snapshotValue?["feedback"] as? String
                review.feedback = feedback!
                
                let time = snapshotValue?["time"] as? String
                review.time = time!
                print("review.time = \(review.time)")
                
                let waitingtime = snapshotValue?["waitingtime"] as? String
                review.waitingtime = waitingtime!
                
                let timeNumbers = snapshotValue?["timeNumbers"] as? Double
                review.timeNumbers = timeNumbers!
                
                let likedCount = snapshotValue?["likedCount"] as? Int
                review.likedCount = likedCount!
                
                let uid = snapshotValue?["uid"] as? String
                review.uid = uid!
                
                review.rid = snapshot.key
                
                if self.likedSet.contains(review.rid){
                    print("self.likedSet.contains(review.rid)")
                    review.userLiked = true
                }
                
                
                let userRef = FIRDatabase.database().reference().child("users")
                userRef.child(uid!).queryOrderedByKey().observe(FIRDataEventType.value, with: {(snapshot) in
                    if self.firebaseLoadedOnce == false{
                        print("userRef.child(uid!).observe(.childAdded, with: { snapshot in")
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
                        
                        self.reviews.append(review)
                        self.reviewsSet.insert(snapshot.key)
                        self.reviews.sort(){$0.timeNumbers > $1.timeNumbers}
                        self.tableView.reloadData()
                        
                        print("review Query End")
                        
                        //I moved codes above here because review tableview could not be loaded 26th
                        //when the value is changed, tableveiw loads again and again
                    }})}
        })
    }
    
    
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
    
    func buttonClicked(sender:UIButton) {
        print("like button is clickedddddd")
        firebaseLoadedOnce = true
        let youLikedRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("youLiked")
        let buttonRow = sender.tag
        let likedID = reviews[buttonRow].rid
        let addLikeCount = reviews[buttonRow].likedCount + 1
        let removeLikeCount = reviews[buttonRow].likedCount - 1
        let firebaseRef = FIRDatabase.database().reference()
        let likedRef = firebaseRef.child("reviews").child(reviews[buttonRow].rid).child("likedCount")
        let userTotalLikedRef = firebaseRef.child("users").child(reviews[buttonRow].uid).child("totalLikedCount")
        let addTotalLikeCount = reviews[buttonRow].totalLikedCount + 1
        let removeTotalLikeCount = reviews[buttonRow].totalLikedCount - 1
        
        if reviews[buttonRow].userLiked == false{
            reviews[buttonRow].userLiked = true
            if let image = UIImage(named:"like1") {
                sender.setImage(image, for: .normal)
                self.likedSet.insert(likedID)
                likedRef.setValue(addLikeCount)
                userTotalLikedRef.setValue(addTotalLikeCount)
                
                print("likedSet = \(likedSet)")
                
                youLikedRef.child(likedID).setValue(true)
            }
        }else{
            reviews[buttonRow].userLiked = false
            if let image = UIImage(named:"like") {
                sender.setImage(image, for: .normal)
                self.likedSet.remove(likedID)
                likedRef.setValue(removeLikeCount)
                userTotalLikedRef.setValue(removeTotalLikeCount)
                print("likedSet = \(likedSet)")
                
                youLikedRef.child(likedID).removeValue { (error, ref) in
                    if error != nil {
                        print("error \(error)")
                    }
                }
            }
        }
    }
    
    @IBAction func questionButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController (title: "", message: "情報の誤りを報告しますか", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "報告する", style: .default) { (_) -> Void in
            
        }
        let cancelAction = UIAlertAction(title: "報告しない", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func MapButtonTapped(_ sender: Any) {
        performSegue(withIdentifier:"detailbacktoMapSegue", sender: nil)
    }
    
}
