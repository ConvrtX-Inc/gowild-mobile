//
//  SupportCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 16/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class SupportCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!{
        didSet{
            logoImageView.clipsToBounds = true
            logoImageView.layer.cornerRadius = (logoImageView.frame.height / 2)
        }
    }
    @IBOutlet weak var trackNmbLbl: UILabel!{
        didSet{
            trackNmbLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
            trackNmbLbl.textColor = AppColor.appWhiteColor()
        }
    }
    @IBOutlet weak var statusLbl: PaddingLabel!{
        didSet{
            statusLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
            statusLbl.textColor = AppColor.appWhiteColor()
            statusLbl.clipsToBounds = true
            statusLbl.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var dateLbl: UILabel!{
        didSet{
            dateLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
            dateLbl.textColor = AppColor.textLightYellow()
        }
    }
    @IBOutlet weak var descriptionLbl: UILabel!{
        didSet{
            descriptionLbl.font = Fonts.getSourceSansProRegularOf(size: 12)
            descriptionLbl.textColor = AppColor.appWhiteColor()
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
