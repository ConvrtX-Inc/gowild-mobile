//
//  RunWildRouteCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import MapKit

class RunWildRouteCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var headerView: UIView!{
        didSet{
            headerView.clipsToBounds = true
            headerView.layer.cornerRadius = 20
            headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    
    @IBOutlet weak var suggestedRoutesLbl: UILabel!{
        didSet{
            suggestedRoutesLbl.font = Fonts.getSourceSansProRegularOf(size: 12)
            suggestedRoutesLbl.textColor = AppColor.appBgColor()
        }
    }
    @IBOutlet weak var suggestedRoutesBtn: UIButton!
    @IBOutlet weak var routeTableView: ContentSizedTableView!{
        didSet{
            routeTableView.delegate = self
            routeTableView.dataSource = self
            routeTableView.register(R.nib.homeRouteSubCell)
        }
    }
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var seeAllRoutesBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - EXTENDION FOR LIST VIEW METHODS -

extension RunWildRouteCell: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureRouteCell(at: indexPath)
    }
    
}

//MARK: - EXTENDION FOR CONFIGURE CELL -

extension RunWildRouteCell{
    
    private func configureRouteCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = routeTableView.dequeueReusableCell(withIdentifier: .homeRouteSubCell, for: indexPath) as! HomeRouteSubCell
        
        cell.backView.borderColor = indexPath.row == 0 ? AppColor.textLightOrangeColor() : AppColor.cardBorderColor()
        cell.backView.backgroundColor = indexPath.row == 0 ? AppColor.appOrangeBgColor() : AppColor.appWhiteColor()
        cell.btnStackView.isHidden = indexPath.row == 0 ? false : true
        cell.spacerView.isHidden = indexPath.row == 0 ? true : false
        cell.leaderboardTableView.isHidden = true
        
        return cell
    }
    
}
