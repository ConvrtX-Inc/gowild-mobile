//
//  FaqCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 03/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit

class FaqCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dropDownImageView: UIImageView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
