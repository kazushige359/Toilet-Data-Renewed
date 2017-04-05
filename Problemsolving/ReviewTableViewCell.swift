//
//  ReviewTableViewCell.swift
//  Problemsolving
//
//  Created by 重信和宏 on 8/1/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var userPhotoImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var starRatedLabel: CosmosView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var feedbackTextView: UITextView!
    
    @IBOutlet weak var waitingMinuteLabel: UILabel!
        
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var userLikedCount: UILabel!
    
    @IBOutlet weak var userFavoritedCount: UILabel!
    
    @IBOutlet weak var userHelpedCount: UILabel!
    
    @IBOutlet weak var likedCountLabel: UILabel!
    
    @IBOutlet weak var nextUserLikedCount: UILabel!
    
    @IBOutlet weak var nextLikedCountLabel: UILabel!
    
    var buttonClicked = false
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        if buttonClicked == false{
            likedCountLabel.isHidden = true
            userLikedCount.isHidden = true
            nextLikedCountLabel.isHidden = false
            nextUserLikedCount.isHidden = false
            buttonClicked = true
        }else{
            likedCountLabel.isHidden = false
            userLikedCount.isHidden = false
            nextLikedCountLabel.isHidden = true
            nextUserLikedCount.isHidden = true
            
            buttonClicked = false
            
        }
        
    }
}


