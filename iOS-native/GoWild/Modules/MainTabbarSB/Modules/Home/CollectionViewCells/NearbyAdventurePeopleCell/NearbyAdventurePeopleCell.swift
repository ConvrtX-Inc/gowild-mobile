//
//  NearbyAdventurePeopleCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class NearbyAdventurePeopleCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var peopleImageView: UIImageView!
    @IBOutlet weak var countLbl: UILabel!{
        didSet{
            countLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
            countLbl.textColor = AppColor.bgBlackColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
