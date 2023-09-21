//
//  LoginVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var fbLoginBtn: SocialButtonWithImage!
    @IBOutlet weak var googleLoginBtn: SocialButtonWithImage!
    @IBOutlet weak var orLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var byLoggingLbl: UILabel!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var andLbl: UILabel!
    @IBOutlet weak var privacyBtn: UIButton!
    @IBOutlet weak var loginBtn: LoadingButton!
    @IBOutlet weak var dontHaveAccountLbl: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    
    //MARK: - PRPERTIES -
    
    private var loginViewModel = LoginViewModel()
    private var currentUserViewModel = CurrentUserViewModel()
    private var fbLoginViewModel = FBLoginViewModel()
    private var googleLoginViewModel = GoogleLoginViewModel()
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        loginViewModel.delegates = self
        currentUserViewModel.delegates = self
        fbLoginViewModel.delegates = self
        googleLoginViewModel.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** LoginVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.loginTitle()
        fbLoginBtn.setTitle(GoWildStrings.logInWithFacebook(), for: .normal)
        googleLoginBtn.setTitle(GoWildStrings.logInWithGoogle(), for: .normal)
        orLbl.text = GoWildStrings.or()
        emailLbl.text = GoWildStrings.email()
        passwordLbl.text = GoWildStrings.password()
        byLoggingLbl.text = GoWildStrings.byLoggingInYouAgreeToOur()
        andLbl.text = GoWildStrings.and()
        loginBtn.setTitle(GoWildStrings.login(), for: .normal)
        dontHaveAccountLbl.text = GoWildStrings.dontHaveAnAccount()
    }
    
    func setUI() {
        self.backView.backgroundColor = AppColor.appBgColor()
        titleLbl.textColor = AppColor.textLightYellow()
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 50)
        fbLoginBtn.backgroundColor = AppColor.appLightBlueColor()
        fbLoginBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 14)
        fbLoginBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        googleLoginBtn.backgroundColor = AppColor.appRedColor()
        googleLoginBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 14)
        googleLoginBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        orLbl.textColor = AppColor.appWhiteColor()
        orLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        emailLbl.textColor = AppColor.appWhiteColor()
        emailLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        emailTextField.textColor = AppColor.appWhiteColor()
        emailTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        passwordLbl.textColor = AppColor.appWhiteColor()
        passwordLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        passwordTextField.textColor = AppColor.appWhiteColor()
        passwordTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        forgetPasswordBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        forgetPasswordBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 14)
        forgetPasswordBtn.titleLabel?.text = GoWildStrings.forgotPassword()
        forgetPasswordBtn.underline()
        byLoggingLbl.textColor = AppColor.appWhiteColor()
        byLoggingLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        termsBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
        termsBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 14)
        termsBtn.titleLabel?.text = GoWildStrings.termsAndConditions()
        termsBtn.underline()
        andLbl.textColor = AppColor.appWhiteColor()
        andLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        privacyBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
        privacyBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 14)
        privacyBtn.titleLabel?.text = GoWildStrings.privacyPolicy()
        privacyBtn.underline()
        loginBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        loginBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        dontHaveAccountLbl.textColor = AppColor.textLightGrayColor()
        dontHaveAccountLbl.font = Fonts.getSourceSansProRegularOf(size: 14)
        signupBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
        signupBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 14)
        signupBtn.titleLabel?.text = GoWildStrings.signUp()
        signupBtn.underline()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapFBLoginBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            LoaderView.shared.showSpiner(inVC: self)
            self.fbLoginBtn.isUserInteractionEnabled = false
            self.fbLoginViewModel.loginWithFacebook(self)
        }
    }
    
    @IBAction func didTapGoogleLoginBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            LoaderView.shared.showSpiner(inVC: self)
            self.googleLoginBtn.isUserInteractionEnabled = false
            self.googleLoginViewModel.loginWithGoogle(self)
        }
    }
    
    @IBAction func didTapForgotPasswordBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            self.navigateToResetPasswordVC()
        }
    }
    
    @IBAction func didTapTermsBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            self.navigateToPrivacyVC(mode: .termsOfConditions)
        }
    }
    
    @IBAction func didTapPrivacyBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            self.navigateToPrivacyVC(mode: .privacyPolicy)
        }
    }
    
    @IBAction func didTapLoginBtn(_ sender: LoadingButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            if !self.loginBtn.isAnimating{
                self.loginBtn.showLoading()
                let email = self.emailTextField.text?.removeExtraSpacingFromString()
                self.emailTextField.text = email
                let request = LoginRequest(email: email ?? "", password: self.passwordTextField.text ?? "", device_type: .iOS)
                self.loginViewModel.getLoginUserWith(request: request)
            }
        }
    }
    
    @IBAction func didTapSignUpBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            self.navigateToSignupVC()
        }
    }
    
}

//MARK: - EXTENSION FOR LOGIN VIEWMODEL DELEGATES -

extension LoginVC: LoginViewModelDelegates{
    
    func didGetLogin(response: LoginBaseResponse) {
        let currentUser = UserManager()
        currentUser.accessToken = response.accessToken
        UserManager.shared.saveUser(user: currentUser)
        self.currentUserViewModel.getCurrentUser()
    }
    
    func didGetLoginResponseWith(error: String) {
        self.loginBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error) {
            self.dismiss(animated: true)
        }
    }
    
    func didGetUserIsNotVerify(error: String) {
        self.loginBtn.hideLoading()
        AlertControllers.showAlertMessage(inVC: self, title: GoWildStrings.alert(), message: error) {
            self.dismiss(animated: true) {
                self.navigateToSignupVC()
            }
        } cancel: {
            self.dismiss(animated: true)
        }

    }
    
}

//MARK: - EXTENSION FOR CURRENT USER VIEWMODEL DELEGATES -

extension LoginVC: CurrentUserViewModelDelegates{
    
    func didGetCurrentUser(response: CurrentUserResponse) {
        self.loginBtn.hideLoading()
        let newUser = UserManager.shared.convertUser(user: response)
        UserManager.shared.saveUser(user: newUser)
        self.navigateToMainTabbarVC()
    }
    
    func didGetCurrentUserResponseWith(error: String) {
        self.loginBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error) {
            self.dismiss(animated: true)
        }
    }
    
}

//MARK: - EXTENSION FOR FB LOGIN VIEWMODEL DELEGATES -

extension LoginVC: FBLoginViewModelDelegates{
    
    func didGetFBLogin(response: FBLoginBaseResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.fbLoginBtn.isUserInteractionEnabled = true
        let currentUser = UserManager()
        currentUser.accessToken = response.token?.accessToken
        UserManager.shared.saveUser(user: currentUser)
        self.currentUserViewModel.getCurrentUser()
    }
    
    func didGetFBLoginResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.fbLoginBtn.isUserInteractionEnabled = true
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.fbLoginBtn.isUserInteractionEnabled = true
        self.googleLoginBtn.isUserInteractionEnabled = true
        self.loginBtn.isUserInteractionEnabled = true
        if self.loginBtn.isAnimating {self.loginBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.fbLoginBtn.isUserInteractionEnabled = true
        self.googleLoginBtn.isUserInteractionEnabled = true
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
}

//MARK: - EXTENSION FOR Google LOGIN VIEWMODEL DELEGATES -

extension LoginVC: GoogleLoginViewModelDelegates{
    
    func didGetGoogleLogin(response: GoogleLoginResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.googleLoginBtn.isUserInteractionEnabled = true
        let currentUser = UserManager()
        currentUser.accessToken = response.token?.accessToken
        UserManager.shared.saveUser(user: currentUser)
        self.currentUserViewModel.getCurrentUser()
    }
    
    func didGetGoogleLoginResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.googleLoginBtn.isUserInteractionEnabled = true
        AlertControllers.showAlert(inVC: self, message: error) {
            self.dismiss(animated: true)
        }
    }
    
}

//MARK: - EXTENSION FOR NAVIGATION METHODS -

extension LoginVC{
    
    private func navigateToMainTabbarVC(){
        RouterNavigation.shared.loadTabbarNavigation()
    }
    
    private func navigateToResetPasswordVC(){
        guard let resetPasswordVC = R.storyboard.authSB.resetPasswordVC() else {return}
        self.push(controller: resetPasswordVC, hideBar: true, animated: true)
    }
    
    private func navigateToSignupVC(){
        guard let signupVC = R.storyboard.authSB.signupVC() else {return}
        self.push(controller: signupVC, hideBar: true, animated: true)
    }
    
    private func navigateToPrivacyVC(mode: PrivacyPolicyVCMode){
        guard let privacyVC = R.storyboard.authSB.privacyPolicyVC() else {return}
        privacyVC.mode = mode
        self.push(controller: privacyVC, hideBar: true, animated: true)
    }
    
}
