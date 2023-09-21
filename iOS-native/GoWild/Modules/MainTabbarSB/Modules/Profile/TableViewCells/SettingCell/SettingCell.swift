//
//  SettingCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 28/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var settingNameLbl: UILabel!{
        didSet{
            settingNameLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 21)
            settingNameLbl.textColor = AppColor.appWhiteColor()
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
