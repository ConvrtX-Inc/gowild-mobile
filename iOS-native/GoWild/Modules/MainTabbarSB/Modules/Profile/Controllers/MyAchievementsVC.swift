//
//  MyAchievementsVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 13/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher

class MyAchievementsVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var achievementsTableView: UITableView!{
        didSet{
            achievementsTableView.delegate = self
            achievementsTableView.dataSource = self
            achievementsTableView.register(R.nib.myAchievementCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var achievementsVM = MyAchievementViewModel()
    private var arrayOfAchievements : [MyAchievementResponseData] = []
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        achievementsVM.delegates = self
        getMyAchievements()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** MyAchievementsVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.myAchievements().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getMyAchievements(){
        LoaderView.shared.showSpiner(inVC: self)
        self.achievementsVM.getMyAchievements()
    }
    
    private func navigateToMyAchievementsDetailVC(leaderboard: MyAchievementResponseData){
        guard let myAchievementsDetailVC = R.storyboard.runWildSB.myAchievementsDetailVC() else {return}
        myAchievementsDetailVC.mode = .myLeaderboard
        myAchievementsDetailVC.myLeaderboard = leaderboard
        self.push(controller: myAchievementsDetailVC, hideBar: true, animated: true)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - EXTENSION FOR MyAchievementViewModel Delegates -

extension MyAchievementsVC: MyAchievementViewModelDelegates{
    
    func didGetMyAchievements(response: MyAchievementResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let achievementList = response.data{
            self.arrayOfAchievements = achievementList
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.achievementsTableView.reloadData()
        }
    }
    
    func didGetMyAchievementsResponseWith(error: String) {
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

extension MyAchievementsVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfAchievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureAchievementsCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToMyAchievementsDetailVC(leaderboard: self.arrayOfAchievements[indexPath.row])
    }
    
}

//MARK: - EXTESNION FOR CELL METHODS -

extension MyAchievementsVC{
    
    private func configureAchievementsCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.achievementsTableView.dequeueReusableCell(withIdentifier: .myAchievementCell, for: indexPath) as! MyAchievementCell
        
        let leaderboard = self.arrayOfAchievements[indexPath.row]
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(UserManager.shared.picture ?? "")"){
            cell.profileImageView.kf.indicatorType = .activity
            cell.profileImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }
        
        cell.nameLbl.text = leaderboard.route?.title
        
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
