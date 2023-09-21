//
//  CommentCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLbl: UILabel!{
        didSet{
            nameLbl.font = Fonts.getSourceSansProRegularOf(size: 14)
            nameLbl.textColor = AppColor.textDarkGrayColor()
        }
    }
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var commentView: UIView!{
        didSet{
            commentView.clipsToBounds = true
        }
    }
    @IBOutlet weak var commentLbl: UILabel!{
        didSet{
            commentLbl.font = Fonts.getSourceSansProRegularOf(size: 14)
            commentLbl.textColor = AppColor.appWhiteColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
