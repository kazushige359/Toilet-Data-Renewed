//
//  PictureViewController.swift
//  Problemsolving
//
//  Created by 重信和宏 on 3/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase


class PictureViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var selectPicture: UIButton!
    
    @IBOutlet weak var savePicture: UIButton!
    
    var databaseRef = FIRDatabase.database().reference()
    var uuid = NSUUID().uuidString
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).child("userPhoto").queryOrderedByKey().observe(FIRDataEventType.value, with: { snapshot in
            //g to l at 2pm 20th
            
            self.imageView.sd_setImage(with: URL(string:snapshot.value as! String))
            if snapshot.value == nil{
                self.imageView.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/problemsolving-299e4.appspot.com/o/images%2Fdefault%20picture.png?alt=media&token=b407a188-5a9d-4b0f-8b43-3bf6c2060573"))
                
            }
        })
        
        savePicture.isEnabled = false
        imagePicker.delegate = self
        selectPicture.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        savePicture.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 75.0
        let myColor : UIColor = UIColor(red: 0.4, green: 0.6, blue: 1.4, alpha: 0.7)

        imageView.layer.borderColor = myColor.cgColor
        imageView.layer.borderWidth = 3

        // Do any additional setup after loading the view.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        imageView.backgroundColor = UIColor.clear
        
        //nextButton.isEnabled = true
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectPictureButtonTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
        savePicture.isEnabled = true
    }
    
    
    @IBAction func savePictureButtonTapped(_ sender: Any) {
        savePicture.isEnabled = false
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        
        
        imagesFolder.child("\(uuid).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(error)")
            } else {
                
                print(metadata?.downloadURL() as Any)
                let downloadURL = metadata!.downloadURL()!.absoluteString
                self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["userPhoto": downloadURL])

                self.performSegue(withIdentifier:"backNewAccountSegue", sender: metadata!.downloadURL()!.absoluteString)
            }
        })
    }
    

  
}
