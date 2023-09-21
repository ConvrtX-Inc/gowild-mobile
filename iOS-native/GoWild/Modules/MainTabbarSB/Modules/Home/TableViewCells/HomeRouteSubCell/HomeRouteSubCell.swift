//
//  HomeRouteSubCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher

class HomeRouteSubCell: UITableViewCell {
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mapView: UIImageView!
    @IBOutlet weak var mapWidthConstrain: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: UILabel!{
        didSet{
            titleLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
            titleLbl.textColor = AppColor.bgBlackColor()
        }
    }
    @IBOutlet weak var tryRouteBtn: LoadingButton!{
        didSet{
            tryRouteBtn.titleLabel?.font = Fonts.getSourceSansProSemiBoldOf(size: 11)
            tryRouteBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
            tryRouteBtn.setTitle(GoWildStrings.tryRoute(), for: .normal)
        }
    }
    @IBOutlet weak var saveBtn: LoadingButton!{
        didSet{
            saveBtn.titleLabel?.font = Fonts.getSourceSansProSemiBoldOf(size: 11)
        }
    }
    @IBOutlet weak var detailBtn: LoadingButton!{
        didSet{
            detailBtn.titleLabel?.font = Fonts.getSourceSansProSemiBoldOf(size: 11)
            detailBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
            detailBtn.setTitle(GoWildStrings.details(), for: .normal)
        }
    }
    
    @IBOutlet weak var spacerView: UIView!
    @IBOutlet weak var milesLbl: UILabel!{
        didSet{
            milesLbl.font = Fonts.getSourceSansProRegularOf(size: 12)
        }
    }
    @IBOutlet weak var durationLbl: UILabel!{
        didSet{
            durationLbl.font = Fonts.getSourceSansProRegularOf(size: 12)
        }
    }
    @IBOutlet weak var meterLbl: UILabel!{
        didSet{
            meterLbl.font = Fonts.getSourceSansProRegularOf(size: 12)
        }
    }
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var leaderboardTableView: UITableView!{
        didSet{
            leaderboardTableView.delegate = self
            leaderboardTableView.dataSource = self
            leaderboardTableView.register(R.nib.routeLeaderboardCell)
        }
    }
    
    var arrayOfLeaderboard : [HomeAdminRouteLeaderboard] = []{
        didSet{
            self.leaderboardTableView.reloadData()
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


//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension HomeRouteSubCell: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayOfLeaderboard.count > 4{
            return 4
        }else{
            return self.arrayOfLeaderboard.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureLeaderboardCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 28.0
    }
    
}

//MARK: - EXTENSION FOR CELL METHOD -

extension HomeRouteSubCell{
    
    private func configureLeaderboardCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.leaderboardTableView.dequeueReusableCell(withIdentifier: .routeLeaderboardCell, for: indexPath) as! RouteLeaderboardCell
        
        let currentLeaderboard = self.arrayOfLeaderboard[indexPath.row]
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(currentLeaderboard.image ?? "")"){
            cell.peopleImageView.kf.indicatorType = .activity
            cell.peopleImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }
        
        if let rank = currentLeaderboard.rank{
            switch rank{
            case 0:
                cell.positionLbl.text = "---"
            case 1:
                cell.positionLbl.text = "\(rank)st"
            case 2:
                cell.positionLbl.text = "\(rank)nd"
            case 3:
                cell.positionLbl.text = "\(rank)rd"
            default:
                cell.positionLbl.text = "\(rank)th"
            }
            
        }else{
            cell.positionLbl.text = "-"
        }
        
        
        if currentLeaderboard.userID == UserManager.shared.id{
            cell.backView.backgroundColor = R.color.textDarkOrangeColor()
            cell.positionLbl.textColor = R.color.appWhiteColor()
        }else{
            cell.backView.backgroundColor = .clear
            cell.positionLbl.textColor = R.color.appBgBlack()
        }
        
        return cell
    }
    
}
