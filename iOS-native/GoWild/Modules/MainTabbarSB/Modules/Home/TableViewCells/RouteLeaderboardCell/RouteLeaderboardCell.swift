//
//  RouteLeaderboardCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 10/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit

class RouteLeaderboardCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var peopleImageView: UIImageView!
    @IBOutlet weak var positionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
