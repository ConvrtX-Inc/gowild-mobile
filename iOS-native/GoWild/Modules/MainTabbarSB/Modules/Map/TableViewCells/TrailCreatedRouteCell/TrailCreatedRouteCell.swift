//
//  TrailCreatedRouteCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class TrailCreatedRouteCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mapView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!{
        didSet{
            titleLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
            titleLbl.textColor = AppColor.bgBlackColor()
        }
    }
    @IBOutlet weak var tryRouteBtn: LoadingButton!{
        didSet{
            tryRouteBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 12)
            tryRouteBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
            tryRouteBtn.setTitle(GoWildStrings.tryRoute(), for: .normal)
        }
    }
    @IBOutlet weak var shareBtn: LoadingButton!
    @IBOutlet weak var detailBtn: LoadingButton!{
        didSet{
            detailBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 12)
            detailBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
            detailBtn.setTitle(GoWildStrings.details(), for: .normal)
        }
    }
    
    @IBOutlet weak var spacerView: UIView!
    @IBOutlet weak var milesLbl: UILabel!{
        didSet{
            milesLbl.font = Fonts.getSourceSansProBoldOf(size: 11)
        }
    }
    @IBOutlet weak var durationLbl: UILabel!{
        didSet{
            durationLbl.font = Fonts.getSourceSansProBoldOf(size: 11)
        }
    }
    @IBOutlet weak var meterLbl: UILabel!{
        didSet{
            meterLbl.font = Fonts.getSourceSansProBoldOf(size: 11)
        }
    }
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var leadingStackView: UIStackView!
    @IBOutlet weak var editRouteImageView: UIImageView!
    @IBOutlet weak var deleteRouteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
