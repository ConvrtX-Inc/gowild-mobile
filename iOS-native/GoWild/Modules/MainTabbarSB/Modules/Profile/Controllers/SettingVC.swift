//
//  SettingVC.swift
//  GoWild
//
//  Created by APPLE on 11/14/22.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher

struct SettingModel{
    let image: UIImage?
    let name: String
}

class SettingVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var settingTableView: UITableView!{
        didSet{
            settingTableView.delegate = self
            settingTableView.dataSource = self
            settingTableView.register(R.nib.settingCell)
        }
    }
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    //MARK: - PROPERTIES -
    
    private var logoutViewModel = LogoutViewModel()
    
    private let settings : [SettingModel] = [
        SettingModel(image: R.image.ic_setting_editprofile_icon() ?? nil, name: GoWildStrings.editProfile()),
        SettingModel(image: R.image.ic_setting_subscription_icon() ?? nil, name: GoWildStrings.subscriptions()),
        SettingModel(image: R.image.ic_setting_message_icon() ?? nil, name: GoWildStrings.messages()),
        SettingModel(image: R.image.ic_setting_races_icon() ?? nil, name: GoWildStrings.myRaces()),
        SettingModel(image: R.image.ic_setting_support_icon() ?? nil, name: GoWildStrings.support()),
        SettingModel(image: R.image.ic_setting_faq_icon() ?? nil, name: GoWildStrings.faq()),
        SettingModel(image: R.image.ic_setting_profile_icon() ?? nil, name: GoWildStrings.myAchievements()),
        SettingModel(image: R.image.ic_setting_payment_icon() ?? nil, name: GoWildStrings.payment()),
        SettingModel(image: R.image.ic_setting_notification_icon() ?? nil, name: GoWildStrings.notifications()),
        SettingModel(image: R.image.ic_setting_logout_icon() ?? nil, name: GoWildStrings.logout())
    ]
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        logoutViewModel.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateProfileImage()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("***** SettingVC *****")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.settings().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        nameLbl.font = Fonts.getSourceSansProBoldOf(size: 26)
        nameLbl.textColor = AppColor.appWhiteColor()
        didTapOnProfileImage()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func updateProfileImage(){
        nameLbl.text = "\(UserManager.shared.firstName ?? "") \(UserManager.shared.lastName ?? "")"
        if let profileURL = URL(string: "\(UserManager.shared.getBaseURL())\(UserManager.shared.picture ?? "")"){
            self.profileImageView.kf.indicatorType = .activity
            self.profileImageView.kf.setImage(with: profileURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            self.profileImageView.image = R.image.ic_user_placeholder_image()
        }
    }
    
    //MARK: - ACTIONS -

    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func didTapOnProfileImage(){
        self.profileImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if let userProfile = UserManager.shared.picture,
               !userProfile.isEmpty{
                let userPicURL = "\(UserManager.shared.getBaseURL())\(userProfile)"
                LightBoxVC.shared.showImage(with: userPicURL,inVC: self)
            }
        }
    }

}

//MARK: - EXTENSION FOR LOGOUT VIEWMODEL DELEGATES -

extension SettingVC: LogoutViewModelDelegates{
    
    func didLogoutUser(response: LogoutResponse) {
        
    }
    
    func didLogoutUserResponseWith(error: String) {
        Constants.printLogs(error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        Constants.printLogs(error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        Constants.printLogs(error?.first ?? "")
    }
    
}

//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension SettingVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureSettingCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            self.navigateToEditProfileVC()
        case 2:
            self.navigateToMessagesVC()
        case 3:
//            self.navigateToMyRacesVC()
            Constants.printLogs("MyRacesVC")
        case 4:
            self.navigateToSupportVC()
        case 5:
//            self.navigateToFAQVC()
            Constants.printLogs("FAQ VC")
        case 6:
            self.navigateToMyAchievementVC()
        case 8:
            self.navigateToNotificatonsVC()
        case 9:
            self.didLogoutUser()
        default:
            Constants.printLogs("*************")
        }
    }
    
}

// MARK: - EXTENSION FOR CONFIGURE SETTING CELL -

extension SettingVC{
    
    private func configureSettingCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.settingTableView.dequeueReusableCell(withIdentifier: .settingCell, for: indexPath) as! SettingCell
        let setting = self.settings[indexPath.row]
        cell.settingNameLbl.text = setting.name
        cell.settingImageView.image = setting.image
        return cell
    }
    
}

//MARK: - EXTENSION FOR NAVIGATION METHODS -

extension SettingVC{
    
    private func navigateToEditProfileVC(){
        guard let editProfileVC = R.storyboard.profileSB.editProfileVC() else {return}
        self.push(controller: editProfileVC, hideBar: true, animated: true)
    }
    
    private func navigateToMessagesVC(){
        guard let messagesVC = R.storyboard.messageSB.messagesVC() else {return}
        self.push(controller: messagesVC, hideBar: true, animated: true)
    }
    
    private func navigateToMyRacesVC(){
        guard let myRacesVC = R.storyboard.mapSB.treasureWildVC() else {return}
        self.push(controller: myRacesVC, hideBar: true, animated: true)
    }
    
    private func navigateToSupportVC(){
        guard let supportVC = R.storyboard.supportSB.supportVC() else {return}
        self.push(controller: supportVC, hideBar: true, animated: true)
    }
    
    private func navigateToFAQVC(){
        guard let faqVC = R.storyboard.profileSB.faqVC() else {return}
        self.push(controller: faqVC, hideBar: true, animated: true)
    }
    
    private func navigateToMyAchievementVC(){
        guard let myAchievementVC = R.storyboard.profileSB.myAchievementsVC() else {return}
        self.push(controller: myAchievementVC, hideBar: true, animated: true)
    }
    
    private func navigateToNotificatonsVC(){
        guard let notificationsVC = R.storyboard.profileSB.notificationsVC() else {return}
        self.push(controller: notificationsVC, hideBar: true, animated: true)
    }
    
    private func didLogoutUser(){
        if Network.isAvailable{
            UIApplication.shared.applicationIconBadgeNumber = 0
            self.logoutViewModel.logoutUser()
            MapOverLayViewModel.shared.removeAllMapTypes()
            let currentUser = UserManager()
            currentUser.deleteUser()
            UserManager.shared.saveUser(user: currentUser)
            self.navigationController?.viewControllers.removeAll()
            RouterNavigation.shared.loadAuthNavigation()
        }else{
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsNetworkError())
        }
    }
    
}
