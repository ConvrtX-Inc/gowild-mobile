//
//  MapOverlayCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit

class MapOverlayCell: UITableViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!{
        didSet{
            nameLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 16)
            nameLbl.textColor = AppColor.bgBlackColor()
        }
    }
    @IBOutlet weak var setBtn: UIButton!{
        didSet{
            setBtn.titleLabel?.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
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
