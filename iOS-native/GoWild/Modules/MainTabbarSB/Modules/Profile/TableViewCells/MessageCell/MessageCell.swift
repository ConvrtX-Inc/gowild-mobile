//
//  MessageCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!{
        didSet{
            nameLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
            nameLbl.textColor = AppColor.appWhiteColor()
        }
    }
    @IBOutlet weak var chatImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
