//
//  NotificationCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 14/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var userImageBackView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!{
        didSet{
            titleLbl.font = Fonts.getSourceSansProBoldOf(size: 16)
            titleLbl.textColor = AppColor.appWhiteColor()
        }
    }
    @IBOutlet weak var dateLbl: UILabel!{
        didSet{
            dateLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
            dateLbl.textColor = AppColor.textLightYellow()
        }
    }
    @IBOutlet weak var descriptionLbl: UILabel!{
        didSet{
            descriptionLbl.font = Fonts.getSourceSansProRegularOf(size: 13)
            descriptionLbl.textColor = AppColor.textDarkGrayColor()
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
