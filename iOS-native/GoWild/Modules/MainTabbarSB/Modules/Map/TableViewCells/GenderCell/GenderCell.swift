//
//  GenderCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 09/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class GenderCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
