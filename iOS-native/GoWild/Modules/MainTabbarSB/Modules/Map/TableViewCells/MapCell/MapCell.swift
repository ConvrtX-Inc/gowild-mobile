//
//  MapCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 18/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class MapCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!{
        didSet{
            titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 22)
            titleLbl.textColor = AppColor.bgBlackColor()
        }
    }
    @IBOutlet weak var mapImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
