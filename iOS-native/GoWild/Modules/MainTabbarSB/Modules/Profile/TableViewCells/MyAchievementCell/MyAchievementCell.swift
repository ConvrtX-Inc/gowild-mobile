//
//  MyAchievementCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 13/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class MyAchievementCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var positionImageView: UIImageView!
    @IBOutlet weak var positionLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
