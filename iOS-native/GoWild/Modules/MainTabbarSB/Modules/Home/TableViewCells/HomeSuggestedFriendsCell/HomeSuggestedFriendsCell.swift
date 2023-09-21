//
//  HomeSuggestedFriendsCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 17/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class HomeSuggestedFriendsCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendNameLbl: UILabel!{
        didSet{
            friendNameLbl.font = Fonts.getSourceSansProRegularOf(size: 16)
            friendNameLbl.textColor = AppColor.appWhiteColor()
        }
    }
    @IBOutlet weak var addFriendBtn: UIButton!
    @IBOutlet weak var removeFriendBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
