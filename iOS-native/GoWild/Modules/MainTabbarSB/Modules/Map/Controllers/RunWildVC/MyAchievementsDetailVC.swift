//
//  MyAchievementsDetailVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 16/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher

enum myAchievementsDetailVCMode {
    case myLeaderboard
    case routeLeaderboard
}

class MyAchievementsDetailVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var positionLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var distanceFromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var distanceToLbl: UILabel!
    
    //MARK: - PROPERTIES -
    
    var mode : myAchievementsDetailVCMode = {
        let mode : myAchievementsDetailVCMode = .myLeaderboard
        return mode
    }()
    var myLeaderboard : MyAchievementResponseData?
    var routeLeaderboard : RouteLeaderboardResponseData?
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** MyAchievementsDetailVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.leaderboard().capitalized
        if self.mode == .myLeaderboard{
            if let userImage = URL(string: "\(UserManager.shared.getBaseURL())\(UserManager.shared.picture ?? "")"){
                userImageView.kf.indicatorType = .activity
                userImageView.kf.setImage(with: userImage, placeholder: R.image.ic_user_placeholder_image())
            }
            userNameLbl.text = "\(UserManager.shared.firstName ?? "") \(UserManager.shared.lastName ?? "")"
            if let myLeaderboard = myLeaderboard{
                if let rank = myLeaderboard.rank{
                    switch rank{
                    case 1:
                        positionLbl.text = "\(GoWildStrings.congratulationsYouAre()) \(rank)st \(GoWildStrings.placeOnThisRoute())"
                    case 2:
                        positionLbl.text = "\(GoWildStrings.congratulationsYouAre()) \(rank)nd \(GoWildStrings.placeOnThisRoute())"
                    case 3:
                        positionLbl.text = "\(GoWildStrings.congratulationsYouAre()) \(rank)rd \(GoWildStrings.placeOnThisRoute())"
                    default:
                        positionLbl.text = "\(GoWildStrings.congratulationsYouAre()) \(rank)th \(GoWildStrings.placeOnThisRoute())"
                    }
                }
                timeLbl.text = myLeaderboard.completionTime
                distanceFromLbl.text = myLeaderboard.startLocation
                distanceToLbl.text = myLeaderboard.endLocation
            }
        }else{
            if let routeLeaderboard = routeLeaderboard{
                if let userImage = URL(string: "\(UserManager.shared.getBaseURL())\(routeLeaderboard.user?.userPhoto ?? "")"){
                    userImageView.kf.indicatorType = .activity
                    userImageView.kf.setImage(with: userImage, placeholder: R.image.ic_user_placeholder_image())
                }
                userNameLbl.text = "\(routeLeaderboard.user?.firstName ?? "") \(routeLeaderboard.user?.lastName ?? "")"
                if let rank = routeLeaderboard.rank{
                    switch rank{
                    case 1:
                        positionLbl.text = "\(GoWildStrings.congratulationsYouAre()) \(rank)st \(GoWildStrings.placeOnThisRoute())"
                    case 2:
                        positionLbl.text = "\(GoWildStrings.congratulationsYouAre()) \(rank)nd \(GoWildStrings.placeOnThisRoute())"
                    case 3:
                        positionLbl.text = "\(GoWildStrings.congratulationsYouAre()) \(rank)rd \(GoWildStrings.placeOnThisRoute())"
                    default:
                        positionLbl.text = "\(GoWildStrings.congratulationsYouAre()) \(rank)th \(GoWildStrings.placeOnThisRoute())"
                    }
                }
                timeLbl.text = routeLeaderboard.completionTime
                distanceFromLbl.text = routeLeaderboard.route?.startLocation
                distanceToLbl.text = routeLeaderboard.route?.endLocation
            }
        }
        toLbl.text = GoWildStrings.to().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        userNameLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        userNameLbl.textColor = AppColor.appWhiteColor()
        positionLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        positionLbl.textColor = AppColor.appWhiteColor()
//        timeLbl.font = Fonts.getDigitalNumbersRegularOf(size: 30)
        timeLbl.textColor = AppColor.textDarkOrangeColor()
        distanceFromLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        distanceFromLbl.textColor = AppColor.appWhiteColor()
        toLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        toLbl.textColor = AppColor.textLightYellow()
        distanceToLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        distanceToLbl.textColor = AppColor.appWhiteColor()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}
