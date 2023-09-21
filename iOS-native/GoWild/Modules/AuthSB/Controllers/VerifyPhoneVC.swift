//
//  VerifyPhoneVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 10/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import SVPinView

enum VerificationMode {
    case signup
    case forgotPassword
}

class VerifyPhoneVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var pinView: SVPinView!
    @IBOutlet weak var didNotGetOtpLbl: UILabel!
    @IBOutlet weak var resendBtn: LoadingButton!
    @IBOutlet weak var verifyBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    private var viewModel = RegisterVerifyMobileViewModel()
    private var resendOTPViewModel = RegisterSendMobileOTPViewModel()
    private var resetOTPViewModel = ResetVerifyOTPViewModel()
    
    var mode : VerificationMode = {
        let mode : VerificationMode = .signup
        return mode
    }()
    var userEmail: String = ""
    var userPhoneNmb : String = ""
    private var currentPin : String = ""
    
    //MARK: - LIFE CYCLE -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        configureSVPinView()
        viewModel.delegates = self
        resendOTPViewModel.delegates = self
        resetOTPViewModel.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** VerifyPhoneVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        if self.mode == .signup{
            titleLbl.text = GoWildStrings.verifyPhone().capitalized
        }else{
            titleLbl.text = GoWildStrings.verifyCode().capitalized
        }
        subTitleLbl.text = "\(GoWildStrings.verificationCodeSentTo())\n\(self.userPhoneNmb)"
        didNotGetOtpLbl.text = GoWildStrings.didNotRecieveCode()
        verifyBtn.setTitle(GoWildStrings.verifyAccount(), for: .normal)
    }
    
    func setUI(){
        self.backView.backgroundColor = AppColor.appBgColor()
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 50)
        titleLbl.textColor = AppColor.textLightYellow()
        subTitleLbl.font = Fonts.getSourceSansProRegularOf(size: 18)
        subTitleLbl.textColor = AppColor.textLightGrayColor()
        didNotGetOtpLbl.textColor = AppColor.appWhiteColor()
        didNotGetOtpLbl.font = Fonts.getSourceSansProRegularOf(size: 18)
        resendBtn.setTitleColor(AppColor.textLightYellow(), for: .normal)
        resendBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 20)
        resendBtn.titleLabel?.text = GoWildStrings.resendOTP()
        resendBtn.underline()
        verifyBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        verifyBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
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
    
    @IBAction func didTapResendBtn(_ sender: UIButton) {
        sender.showAnimation {
            if !self.resendBtn.isAnimating{
                self.resendBtn.showLoading()
                let request = RegisterSendMobileOTPRequest(email: self.userEmail)
                self.resendOTPViewModel.getOTPOnMobileWith(request: request)
            }
        }
    }
    
    @IBAction func didTapVerifyBtn(_ sender: UIButton) {
        sender.showAnimation {
            if !self.verifyBtn.isAnimating{
                self.verifyBtn.showLoading()
                if self.mode == .signup{
                    let request = RegisterVerifyMobileRequest(email: self.userEmail, phoneNumber: self.userPhoneNmb, otpCode: self.currentPin)
                    self.viewModel.verifyMobileOTPWith(request: request)
                }else{
                    let request = ResetVerifyOTPRequest(otpCode: self.currentPin, phoneNumber: self.userEmail)
                    self.resetOTPViewModel.resetVerifyPhoneWith(request: request)
                }
            }
        }
    }
    

}

//MARK: - EXTENSION FOR REGISTER VERIFY VIEWMODEL DELEGATES -

extension VerifyPhoneVC: RegisterVerifyMobileViewModelDelegates{
    
    func didVerifyMobileOTP(response: RegisterVerifyMobileResponse) {
        self.verifyBtn.hideLoading()
        self.navigateToEWavierVC(accessToken: response.accessToken ?? "")
    }
    
    func didVerifyMobileOTPResponseWith(error: String) {
        self.verifyBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        self.verifyBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        self.verifyBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
}

//MARK: - EXTENSION FOR RESET VERIFY MOBILE ON MOBILE VIEWMODEL DELEGATES -

extension VerifyPhoneVC: ResetVerifyOTPViewModelDelegates{
    
    func didGetResetVerifyOTP(response: ResetVerifyOTPResponse) {
        self.verifyBtn.hideLoading()
        self.navigateToNewPasswordVC()
    }
    
    func didGetResetVerifyOTPResponseWith(error: String) {
        self.verifyBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR SEND OTP ON MOBILE VIEWMODEL DELEGATES -

extension VerifyPhoneVC: RegisterSendMobileOTPViewModelDelegates{
    
    func didGetOTPToMobile(response: RegisterSendMobileOTPResponse) {
        self.resendBtn.hideLoading()
    }
    
    func didGetOTPToMobilResponseWith(error: String) {
        self.resendBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR NAVIGATION METHODS -

extension VerifyPhoneVC{
    
    private func navigateToEWavierVC(accessToken: String){
        guard let eWavierVC = R.storyboard.authSB.eWaiverVC() else {return}
        eWavierVC.mode = .signup
        eWavierVC.accessToken = accessToken
        self.push(controller: eWavierVC, hideBar: true, animated: true)
    }
    
    private func navigateToNewPasswordVC(){
        guard let createNewPasswordVC = R.storyboard.authSB.createNewPasswordVC() else {return}
        createNewPasswordVC.phoneNmb = self.userPhoneNmb
        createNewPasswordVC.email = self.userEmail
        createNewPasswordVC.otpCode = self.currentPin
        self.push(controller: createNewPasswordVC, hideBar: true, animated: true)
    }
    
}


//MARK: - EXTENSION FOR SVPIN CONFIGURE METHODS -

extension VerifyPhoneVC{
    
    private func configureSVPinView(){
        pinView.style = .underline
        pinView.font = Fonts.getSourceSansProBoldOf(size: 20) ?? .boldSystemFont(ofSize: 20)
        pinView.keyboardType = .numberPad
        pinView.keyboardAppearance = .default
//        pinView.becomeFirstResponderAtIndex = 0
        pinView.didFinishCallback = { [weak self] pin in
            self?.currentPin = pin
        }
        pinView.didChangeCallback = { [weak self] pin in
            self?.currentPin = pin
        }
    }
    
}
