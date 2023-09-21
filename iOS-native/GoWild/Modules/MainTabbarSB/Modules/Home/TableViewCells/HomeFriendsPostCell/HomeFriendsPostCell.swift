//
//  HomeFriendsPostCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 17/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class HomeFriendsPostCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendNameLbl: UILabel!{
        didSet{
            friendNameLbl.font = Fonts.getSourceSansProBoldOf(size: 16)
            friendNameLbl.textColor = AppColor.bgBlackColor()
        }
    }
    @IBOutlet weak var postTimeLbl: UILabel!{
        didSet{
            postTimeLbl.font = Fonts.getSourceSansProRegularOf(size: 12)
            postTimeLbl.textColor = AppColor.textDarkGrayColor()
        }
    }
    @IBOutlet weak var postDescriptionLbl: UILabel!{
        didSet{
            postDescriptionLbl.font = Fonts.getSourceSansProRegularOf(size: 16)
            postDescriptionLbl.textColor = AppColor.textDarkGrayColor()
            postDescriptionLbl.numberOfLines = 0
        }
    }
    @IBOutlet weak var attachmentLbl: UILabel!{
        didSet{
            attachmentLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
            attachmentLbl.textColor = .systemBlue
            attachmentLbl.numberOfLines = 0
        }
    }
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var friendsLikeLbl: UILabel!{
        didSet{
            friendsLikeLbl.font = Fonts.getSourceSansProRegularOf(size: 14)
            friendsLikeLbl.textColor = AppColor.textDarkGrayColor()
        }
    }
    @IBOutlet weak var friendOneImageView: UIImageView!
    @IBOutlet weak var friendTwoImageView: UIImageView!
    @IBOutlet weak var friendThreeImageView: UIImageView!
    @IBOutlet weak var postViewImageView: UIImageView!
    @IBOutlet weak var postViewCountLbl: UILabel!{
        didSet{
            postViewCountLbl.font = Fonts.getSourceSansProRegularOf(size: 10)
            postViewCountLbl.textColor = AppColor.textLightOrangeColor()
        }
    }
    @IBOutlet weak var postShareImageView: UIImageView!
    @IBOutlet weak var postShareCountLbl: UILabel!{
        didSet{
            postShareCountLbl.font = Fonts.getSourceSansProRegularOf(size: 10)
            postShareCountLbl.textColor = AppColor.textLightOrangeColor()
        }
    }
    @IBOutlet weak var postCommentImageView: UIImageView!
    @IBOutlet weak var postCommentCountLbl: UILabel!{
        didSet{
            postCommentCountLbl.font = Fonts.getSourceSansProRegularOf(size: 10)
            postCommentCountLbl.textColor = AppColor.textLightOrangeColor()
        }
    }
    @IBOutlet weak var postLikeImageView: UIImageView!
    @IBOutlet weak var postLikeCountLbl: UILabel!{
        didSet{
            postLikeCountLbl.font = Fonts.getSourceSansProRegularOf(size: 10)
            postLikeCountLbl.textColor = AppColor.textLightOrangeColor()
        }
    }
    @IBOutlet weak var imageHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var likeImagesStackView: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
