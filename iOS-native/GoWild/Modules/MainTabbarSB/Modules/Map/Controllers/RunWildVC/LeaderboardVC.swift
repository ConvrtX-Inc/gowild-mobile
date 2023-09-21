//
//  LeaderboardVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit

class LeaderboardVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var leaderboardTableView: UITableView!{
        didSet{
            leaderboardTableView.delegate = self
            leaderboardTableView.dataSource = self
            leaderboardTableView.register(R.nib.myAchievementCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var leaderboardVM = RouteLeaderboardViewModel()
    private var arrayOfLeaderboard: [RouteLeaderboardResponseData] = []
    var routeID: String = ""
    private var totalPage: Int = 0
    private var currentPage: Int = 0
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        leaderboardVM.delegates = self
        getRouteLeaderboard()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** LeaderboardVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.leaderboard().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getRouteLeaderboard(){
        if !self.routeID.isEmpty{
            if self.currentPage == 0{
                LoaderView.shared.showSpiner(inVC: self)
            }
            self.leaderboardVM.getRouteLeaderboard(currentPage: self.currentPage, routeID: self.routeID)
        }
    }
    
    private func navigateToMyAchievementsDetailVC(leaderboard: RouteLeaderboardResponseData){
        guard let myAchievementsDetailVC = R.storyboard.runWildSB.myAchievementsDetailVC() else {return}
        myAchievementsDetailVC.mode = .routeLeaderboard
        myAchievementsDetailVC.routeLeaderboard = leaderboard
        self.push(controller: myAchievementsDetailVC, hideBar: true, animated: true)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - EXTENSION FOR LEADERBOARD VIEWMODEL DELEGATES -

extension LeaderboardVC: RouteLeaderboardViewModelDelegates{
    
    func didGetRouteLeaderboard(response: RouteLeaderboardResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let totalPage = response.totalPage,
           let currentPage = response.currentPage{
            self.totalPage = totalPage
            self.currentPage = currentPage
        }
        if let leaderboardList = response.data,
           !leaderboardList.isEmpty{
            for list in leaderboardList {
                self.arrayOfLeaderboard.append(list)
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.leaderboardTableView.reloadData()
        }
    }
    
    func didGetRouteLeaderboardResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}

//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension LeaderboardVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfLeaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureLeaderboardCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (self.arrayOfLeaderboard.count - 1)) && (self.currentPage < self.totalPage){
            self.getRouteLeaderboard()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leaderboard = self.arrayOfLeaderboard[indexPath.row]
        self.navigateToMyAchievementsDetailVC(leaderboard: leaderboard)
    }
    
}

//MARK: - EXTESNION FOR CELL METHODS -

extension LeaderboardVC{
    
    private func configureLeaderboardCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.leaderboardTableView.dequeueReusableCell(withIdentifier: .myAchievementCell, for: indexPath) as! MyAchievementCell
        
        let leaderboard = self.arrayOfLeaderboard[indexPath.row]
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(leaderboard.user?.userPhoto ?? "")"){
            cell.profileImageView.kf.indicatorType = .activity
            cell.profileImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }
        
        cell.nameLbl.text = "\(leaderboard.user?.firstName ?? "") \(leaderboard.user?.lastName ?? "")"
        
        if let rank = leaderboard.rank{
            switch rank{
            case 1:
                cell.positionLbl.isHidden = true
                cell.positionImageView.image = R.image.ic_first_position()
            case 2:
                cell.positionLbl.isHidden = true
                cell.positionImageView.image = R.image.ic_second_position()
            case 3:
                cell.positionLbl.isHidden = true
                cell.positionImageView.image = R.image.ic_third_position()
            default:
                cell.positionLbl.isHidden = false
                cell.positionLbl.text = "\(rank)"
                cell.positionImageView.image = R.image.ic_forth_position()
            }
        }
        
        return cell
    }
    
}
