//
//  SignupVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 10/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import PhoneNumberKit

class SignupVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var fbLoginBtn: SocialButtonWithImage!
    @IBOutlet weak var googleLoginBtn: SocialButtonWithImage!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNmbLbl: UILabel!
    @IBOutlet weak var phoneNmbTextField: PhoneNumberTextField!
    @IBOutlet weak var addressOneLbl: UILabel!
    @IBOutlet weak var addressOneTextField: UITextField!
    @IBOutlet weak var addressTwoLbl: UILabel!
    @IBOutlet weak var addressTwoTextField: UITextField!
    @IBOutlet weak var bySignupLbl: UILabel!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var andLbl: UILabel!
    @IBOutlet weak var privacyBtn: UIButton!
    @IBOutlet weak var registerBtn: LoadingButton!
    @IBOutlet weak var alreadyHaveAccountLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    //MARK: - PROPERTIES -
    
    private var userPhoneNmb : String{
        return "+\(phoneNmbTextField.phoneNumber?.countryCode ?? 123)\(phoneNmbTextField.phoneNumber?.nationalNumber ?? 456)"
    }
    private var userViewModel = CurrentUserViewModel()
    private var registerViewModel = RegisterViewModel()
    private var sendMobileOTPViewModel = RegisterSendMobileOTPViewModel()
    private var fbLoginViewModel = FBLoginViewModel()
    private var googleLoginViewModel = GoogleLoginViewModel()
    
    //MARK: - LIFE CYCLE -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        configurePhoneNumberKit()
        userViewModel.delegates = self
        registerViewModel.delegates = self
        sendMobileOTPViewModel.delegates = self
        fbLoginViewModel.delegates = self
        googleLoginViewModel.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** SignupVC Deinit ***")
    }

    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.register().capitalized
        fbLoginBtn.setTitle(GoWildStrings.logInWithFacebook(), for: .normal)
        googleLoginBtn.setTitle(GoWildStrings.logInWithGoogle(), for: .normal)
        fullNameLbl.text = GoWildStrings.fullName()
        emailLbl.text = GoWildStrings.email()
        passwordLbl.text = GoWildStrings.password()
        phoneNmbLbl.text = GoWildStrings.phoneNumber()
        addressOneLbl.text = GoWildStrings.addressLineOne()
        addressTwoLbl.text = GoWildStrings.addressLineTwo()
        bySignupLbl.text = GoWildStrings.bySignupYouAgreeToOur()
        andLbl.text = GoWildStrings.and()
        registerBtn.setTitle(GoWildStrings.register(), for: .normal)
        loginBtn.setTitle(GoWildStrings.register(), for: .normal)
        alreadyHaveAccountLbl.text = GoWildStrings.doYouHaveAlreadyAccount()
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
        fullNameLbl.textColor = AppColor.appWhiteColor()
        fullNameLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        fullNameTextField.textColor = AppColor.appWhiteColor()
        fullNameTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        emailLbl.textColor = AppColor.appWhiteColor()
        emailLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        emailTextField.textColor = AppColor.appWhiteColor()
        emailTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        passwordLbl.textColor = AppColor.appWhiteColor()
        passwordLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        passwordTextField.textColor = AppColor.appWhiteColor()
        passwordTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        phoneNmbLbl.textColor = AppColor.appWhiteColor()
        phoneNmbLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        phoneNmbTextField.textColor = AppColor.appWhiteColor()
        phoneNmbTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        addressOneLbl.textColor = AppColor.appWhiteColor()
        addressOneLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        addressOneTextField.textColor = AppColor.appWhiteColor()
        addressOneTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        addressTwoLbl.textColor = AppColor.appWhiteColor()
        addressTwoLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        addressTwoTextField.textColor = AppColor.appWhiteColor()
        addressTwoTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        bySignupLbl.textColor = AppColor.appWhiteColor()
        bySignupLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
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
        alreadyHaveAccountLbl.textColor = AppColor.textLightGrayColor()
        alreadyHaveAccountLbl.font = Fonts.getSourceSansProRegularOf(size: 14)
        loginBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
        loginBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 14)
        loginBtn.titleLabel?.text = GoWildStrings.login()
        loginBtn.underline()
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
    
    
    @IBAction func didTapFbSignupBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            LoaderView.shared.showSpiner(inVC: self)
            self.fbLoginBtn.isUserInteractionEnabled = false
            self.fbLoginViewModel.loginWithFacebook(self)
        }
    }
    
    @IBAction func didTapGoogleSignupBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            LoaderView.shared.showSpiner(inVC: self)
            self.googleLoginBtn.isUserInteractionEnabled = false
            self.googleLoginViewModel.loginWithGoogle(self)
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
    
    
    @IBAction func didTapRegisterBtn(_ sender: UIButton) {
        sender.showAnimation {
            if !self.registerBtn.isAnimating{
                self.registerBtn.showLoading()
                self.view.endEditing(true)
                let fullName = self.removeExtraSpacingFrom(name: self.fullNameTextField.text ?? "")
                let firstName = self.split(fullName: fullName).0
                let lastName = self.split(fullName: fullName).1
                let email = self.emailTextField.text?.removeExtraSpacingFromString()
                self.emailTextField.text = email
                let request = RegisterRequest(firstName: firstName, lastName: lastName, email: email ?? "", phoneNumber: self.userPhoneNmb, password: self.passwordTextField.text ?? "", addressOne: self.addressOneTextField.text ?? "",addressTwo: self.addressTwoTextField.text ?? "", device_type: .iOS)
                self.registerViewModel.getRegisterUserWith(request: request, isValidPhoneNmb: self.phoneNmbTextField.isValidNumber)
            }
        }
    }
    
    @IBAction func didTapLoginBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

//MARK: - EXTENSION REGISTER VIEW MODEL DELEGATES -

extension SignupVC: RegisterViewModelDelegates{
    
    func didGetRegisterUser(response: RegisterBaseResponse) {
        /*
         self.registerBtn.hideLoading()
         self.navigateToVerifyPhoneVC()
         */
        let request = RegisterSendMobileOTPRequest(email: self.emailTextField.text ?? "")
        self.sendMobileOTPViewModel.getOTPOnMobileWith(request: request)
    }
    
    func didGetRegisterUserResponseWith(error: String) {
        self.registerBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.fbLoginBtn.isUserInteractionEnabled = true
        self.googleLoginBtn.isUserInteractionEnabled = true
        self.registerBtn.isUserInteractionEnabled = true
        if self.registerBtn.isAnimating {self.registerBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.registerBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
}

//MARK: - EXTENSION FOR CURRENT USER VIEWMODEL DELEGATES -

extension SignupVC: CurrentUserViewModelDelegates{
    
    func didGetCurrentUser(response: CurrentUserResponse) {
        let newUser = UserManager.shared.convertUser(user: response)
        UserManager.shared.saveUser(user: newUser)
        self.navigateToMainTabbarVC()
    }
    
    func didGetCurrentUserResponseWith(error: String) {
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR SEND OTP ON MOBILE VIEWMODEL DELEGATES -

extension SignupVC: RegisterSendMobileOTPViewModelDelegates{
    
    func didGetOTPToMobile(response: RegisterSendMobileOTPResponse) {
        self.registerBtn.hideLoading()
        self.navigateToVerifyPhoneVC()
    }
    
    func didGetOTPToMobilResponseWith(error: String) {
        self.registerBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR FB LOGIN VIEWMODEL DELEGATES -

extension SignupVC: FBLoginViewModelDelegates{
    
    func didGetFBLogin(response: FBLoginBaseResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.fbLoginBtn.isUserInteractionEnabled = true
        let currentUser = UserManager()
        currentUser.accessToken = response.token?.accessToken
        UserManager.shared.saveUser(user: currentUser)
        self.userViewModel.getCurrentUser()
    }
    
    func didGetFBLoginResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.fbLoginBtn.isUserInteractionEnabled = true
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR Google LOGIN VIEWMODEL DELEGATES -

extension SignupVC: GoogleLoginViewModelDelegates{
    
    func didGetGoogleLogin(response: GoogleLoginResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.googleLoginBtn.isUserInteractionEnabled = true
        let currentUser = UserManager()
        currentUser.accessToken = response.token?.accessToken
        UserManager.shared.saveUser(user: currentUser)
        self.userViewModel.getCurrentUser()
    }
    
    func didGetGoogleLoginResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.googleLoginBtn.isUserInteractionEnabled = true
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}


//MARK: - EXTENSION FOR METHODS -

extension SignupVC{
    
    private func configurePhoneNumberKit(){
        phoneNmbTextField.withFlag = true
        phoneNmbTextField.withPrefix = true
        phoneNmbTextField.updateFlag()
        phoneNmbTextField.updatePlaceholder()
        phoneNmbTextField.flagButton.isUserInteractionEnabled = true
        phoneNmbTextField.withDefaultPickerUI = true
        phoneNmbTextField.withExamplePlaceholder = true
        phoneNmbTextField.addTarget(self, action: #selector(phoneTextChanged), for: .editingChanged)
    }
    
    
    @objc func phoneTextChanged(_ textField: UITextField) {
        if textField == phoneNmbTextField {
            if phoneNmbTextField.isValidNumber{
//                loginBtn.isEnabled = true
                phoneNmbTextField.textColor = .white
            }else{
//                loginBtn.isEnabled = false
                phoneNmbTextField.textColor = .red
            }
        }
    }
    
}


//MARK: - EXTENSION FOR NAVIGATION METHODS -

extension SignupVC{
    
    private func navigateToMainTabbarVC(){
        RouterNavigation.shared.loadTabbarNavigation()
    }
    
    private func navigateToVerifyPhoneVC(){
        guard let verifyPhoneVC = R.storyboard.authSB.verifyPhoneVC() else {return}
        verifyPhoneVC.mode = .signup
        verifyPhoneVC.userPhoneNmb = self.userPhoneNmb
        verifyPhoneVC.userEmail = self.emailTextField.text ?? ""
        self.push(controller: verifyPhoneVC, hideBar: true, animated: true)
    }
    
    private func navigateToPrivacyVC(mode: PrivacyPolicyVCMode){
        guard let privacyVC = R.storyboard.authSB.privacyPolicyVC() else {return}
        privacyVC.mode = mode
        self.push(controller: privacyVC, hideBar: true, animated: true)
    }
    
}

//MARK: - SPLIT USER NAME -

extension SignupVC{
    
    private func removeExtraSpacingFrom(name: String) -> String{
        return name.components(separatedBy:.whitespacesAndNewlines).filter { $0.count > 0 }.joined(separator: " ")
    }
    
    private func split(fullName: String) -> (String, String){
        if !fullName.isEmpty{
            if fullName.contains(find: " "){
                
                if let firstName = fullName.components(separatedBy: " ").first,
                   let lastName = fullName.components(separatedBy: " ").last{
                    return (firstName, lastName)
                }else{
                    return (fullName, "")
                }
            }else if fullName.contains(find: "."){
                if let firstName = fullName.components(separatedBy: ".").first,
                   let lastName = fullName.components(separatedBy: ".").last{
                    return (firstName, lastName)
                }else{
                    return (fullName, "")
                }
            }else{
                return (fullName, "")
            }
        }else{
            return ("", "")
        }
    }
    
}
