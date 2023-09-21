//
//  EWaiverVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 10/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

enum EWaiverMode {
    case signup
    case treasureHunt
}

class EWaiverVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var companyNameView: UIView!
    @IBOutlet weak var companySpacerView: UIView!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateSpacerView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var eWavierLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!{
        didSet{
            checkBtn.setImage(R.image.ic_uncheck_icon(), for: .normal)
            checkBtn.setImage(R.image.ic_check_icon(), for: .selected)
        }
    }
    @IBOutlet weak var checkLbl: UILabel!
    @IBOutlet weak var agreeBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    private var eWaiverViewModel = GuideLineViewModel()
    private var currentUserViewModel = CurrentUserViewModel()
    var mode : EWaiverMode = {
        let mode : EWaiverMode = .signup
        return mode
    }()
    
    var accessToken : String = ""
    var companyName : String = "My company’s treasure hunt"
    private var descriptionText = ""
    private var dateText = ""
    var eventID : String = ""
    var eventPicture : String = ""
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        eWaiverViewModel.delegates = self
        currentUserViewModel.delegates = self
        getEWaiver()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** EWaiverVC Deinit ***")
    }

    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.eWavier()
        updateEWaiverText()
        checkBtn.isSelected = false
        checkBtn.setImage(R.image.ic_uncheck_icon(), for: .normal)
        checkLbl.text = GoWildStrings.iAgreeWithLocalLawsAndTaxesTerms()
        agreeBtn.setTitle(GoWildStrings.iAgree(), for: .normal)
    }
    
    func setUI(){
        self.backView.backgroundColor = AppColor.appBgColor()
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        companyNameView.isHidden = self.mode == .signup ? true : false
        companySpacerView.isHidden = self.mode == .signup ? true : false
        companyLbl.font = Fonts.getForegenRoughOneFontOf(size: 22)
        companyLbl.textColor = AppColor.textLightYellow()
        companyLbl.isHidden = self.mode == .signup ? true : false
        dateView.isHidden = self.mode == .signup ? true : false
        dateSpacerView.isHidden = self.mode == .signup ? true : false
        dateLbl.font = Fonts.getForegenRoughOneFontOf(size: 16)
        dateLbl.textColor = AppColor.textLightYellow()
        dateLbl.isHidden = self.mode == .signup ? true : false
        eWavierLbl.font = Fonts.getSourceSansProRegularOf(size: 16)
        eWavierLbl.textColor = AppColor.appWhiteColor()
        checkLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 16)
        checkLbl.textColor = AppColor.appWhiteColor()
        agreeBtn.titleLabel?.font = Fonts.getSourceSansProSemiBoldOf(size: 16)
        agreeBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func updateEWaiverText(){
        companyLbl.text = companyName.capitalized
        dateLbl.text = dateText.capitalized
        eWavierLbl.text = descriptionText
    }
    
    private func getEWaiver(){
        LoaderView.shared.showSpiner(inVC: self)
        let type : GuideLineType = self.mode == .signup ? .eWaiver : .huntEWaiver
        self.eWaiverViewModel.getAdminGuideLinesOf(type: type)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didTapCheckBtn(_ sender: UIButton){
        sender.showAnimation {
            self.checkBtn.isSelected = !self.checkBtn.isSelected
        }
    }
    
    @IBAction func didTapAgreeBtn(_ sender: UIButton){
        sender.showAnimation {
            if self.mode == .signup{
                if self.checkBtn.isSelected{
                    if !Network.isAvailable {
                        AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsNetworkError())
                        return
                    }
                    if !self.agreeBtn.isAnimating{
                        self.agreeBtn.showLoading()
                        let currentUser = UserManager()
                        currentUser.accessToken = self.accessToken
                        UserManager.shared.saveUser(user: currentUser)
                        self.currentUserViewModel.getCurrentUser()
                    }
                }else{
                    AlertControllers.showAlert(inVC: self, message: GoWildStrings.selectEWaiverTermAndConditionError())
                }
            }else{
                if self.checkBtn.isSelected{
                    self.navigateToRegistrationVC()
                }else{
                    AlertControllers.showAlert(inVC: self, message: GoWildStrings.selectEWaiverTermAndConditionError())
                }
            }
        }
    }
    

}

//MARK: - EXTENSION FOR GUIDLINES VIEWMODEL DELEGATES -

extension EWaiverVC: GuideLineViewModelDelegates{
    
    func didGetAdminGuideLines(response: GuideLineResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let eWavier = response.data{
            self.descriptionText = eWavier.description ?? ""
            if let date = eWavier.createdDate{
                self.dateText = date.UTCToLocal(incomingFormat: date, outGoingFormat: .eWavierDateFormat)
            }else{
                self.dateText = eWavier.createdDate?.convertToDate() ?? ""
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.updateEWaiverText()
        }
    }
    
    func didGetAdminGuideLinesResponseWith(error: String) {
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

//MARK: - EXTENSION FOR CURRENT USER VIEWMODEL DELEGATES -

extension EWaiverVC: CurrentUserViewModelDelegates{
    
    func didGetCurrentUser(response: CurrentUserResponse) {
        self.agreeBtn.hideLoading()
        let newUser = UserManager.shared.convertUser(user: response)
        UserManager.shared.saveUser(user: newUser)
        self.navigateToMainTabbarVC()
    }
    
    func didGetCurrentUserResponseWith(error: String) {
        self.agreeBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}


//MARK: - EXTENSION FOR NAVIGATION METHODS -

extension EWaiverVC{
    
    private func navigateToMainTabbarVC(){
        RouterNavigation.shared.loadTabbarNavigation()
    }
    
    private func navigateToRegistrationVC(){
        guard let eventRegistrationVC = R.storyboard.mapSB.eventRegisterVC() else {return}
        eventRegistrationVC.eventID = self.eventID
        eventRegistrationVC.companyTitle = self.companyName
        eventRegistrationVC.eventPicture = self.eventPicture
        self.push(controller: eventRegistrationVC, hideBar: true, animated: true)
    }
    
}
