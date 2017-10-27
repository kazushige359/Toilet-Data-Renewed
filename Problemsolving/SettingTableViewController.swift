//
//  SettingTableViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 2/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        performSegue(withIdentifier: "changeNameSegue", sender: nil)
        print("indexPath.row == 0")
        }
        if indexPath.row == 1 {
            performSegue(withIdentifier: "PictureSegue", sender: nil)
              print("indexPath.row == 1")
        }

        if indexPath.row == 2 {
        performSegue(withIdentifier: "aboutThisAppSegue", sender: nil)
        print("indexPath.row == 2")
        
        }
        
        
        if indexPath.row == 5 {
            print("indexPath.row == 5")

            logoutStart()
            
        }
        
        
    }
    
    
    func logoutStart(){
        print("LogoutStart 1")
        try! Auth.auth().signOut()
        
        print("LogoutStart 2")
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "UserFirstTimeViewController") as! UserFirstTimeViewController
       // let nextVC = navigationContoller.topViewController as! PlaceDetailViewController
        
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(nextVC, animated: false, completion: nil)
        
        
        
//        if let storyboard = self.storyboard {
//            let vc = storyboard.instantiateViewController(withIdentifier: "UserFirstTimeViewController") as! UINavigationController
//            self.present(vc, animated: false, completion: nil)
//        }
    }
    
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
