//
//  YourReviewTableViewCell.swift
//  Problemsolving
//
//  Created by 重信和宏 on 17/4/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit
import Cosmos

class YourReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeStarView: CosmosView!
    
    @IBOutlet weak var placeDistanceLabel: UILabel!

    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var placeWaitingTime: UILabel!
    
    @IBOutlet weak var placeWarningPhoto: UIImageView!
    
    @IBOutlet weak var placeViewImage: UIImageView!
    
    
    @IBOutlet weak var userFeedbackTextView: UITextView!
    
    @IBOutlet weak var userRatedStarView: CosmosView!
    
    @IBOutlet weak var userLikedButton: UIButton!
    
    @IBOutlet weak var userLikedCountLabel: UILabel!
    
    @IBOutlet weak var userWaitingTimeLabel: UILabel!
    
    
    @IBOutlet weak var userCommentDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
