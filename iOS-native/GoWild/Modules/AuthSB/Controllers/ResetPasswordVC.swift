//
//  ResetPasswordVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 11/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import PhoneNumberKit

class ResetPasswordVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNmbLbl: UILabel!
    @IBOutlet weak var phoneNmbTextField: PhoneNumberTextField!
    @IBOutlet weak var verifyAccountBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    private var viewModel = ForgotPasswordViewModel()
    private var userPhoneNmb : String{
        return "+\(phoneNmbTextField.phoneNumber?.countryCode ?? 123)\(phoneNmbTextField.phoneNumber?.nationalNumber ?? 456)"
    }
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        configurePhoneNumberKit()
        viewModel.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** ResetPasswordVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.resetPassword().capitalized
        subTitleLbl.text = GoWildStrings.enterEmailOrPhoneAssociatedWithYourAccount()
        emailLbl.text = GoWildStrings.email()
        phoneNmbLbl.text = GoWildStrings.phoneNumber()
        verifyAccountBtn.setTitle(GoWildStrings.verifyAccount(), for: .normal)
    }
    
    func setUI(){
        self.backView.backgroundColor = AppColor.appBgColor()
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 50)
        titleLbl.textColor = AppColor.textLightYellow()
        subTitleLbl.font = Fonts.getSourceSansProRegularOf(size: 18)
        subTitleLbl.textColor = AppColor.textLightGrayColor()
        emailLbl.textColor = AppColor.appWhiteColor()
        emailLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        emailTextField.textColor = AppColor.appWhiteColor()
        emailTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        phoneNmbLbl.textColor = AppColor.appWhiteColor()
        phoneNmbLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        phoneNmbTextField.textColor = AppColor.appWhiteColor()
        phoneNmbTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        verifyAccountBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        verifyAccountBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
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
    
    @IBAction func didTapVerifyAccountBtn(_ sender: UIButton){
        sender.showAnimation {
            self.view.endEditing(true)
            if !self.verifyAccountBtn.isAnimating{
                self.verifyAccountBtn.showLoading()
                let email = self.emailTextField.text?.removeExtraSpacingFromString()
                self.emailTextField.text = email
                let request = ForgotPasswordRequest(email: email ?? "", phoneNumber: self.userPhoneNmb)
                self.viewModel.forgotPasswordWith(request: request,isValidPhone: self.phoneNmbTextField.isValidNumber)
            }
        }
    }
    
}

//MARK: - EXTENSION FOR FORGOT PASSWORD VIEWMODEL DELEGATES -

extension ResetPasswordVC: ForgotPasswordViewModelDelegates{
    
    func didGetForgotPassword(response: ForgotPasswordResponse) {
        self.verifyAccountBtn.hideLoading()
        self.navigateToVerifyPhoneVC()
    }
    
    func didGetForgotPasswordResponseWith(error: String) {
        self.verifyAccountBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        self.verifyAccountBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        self.verifyAccountBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
}

//MARK: - EXTENSION FOR METHODS -

extension ResetPasswordVC{
    
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
                phoneNmbTextField.textColor = .white
            }else{
                phoneNmbTextField.textColor = .red
            }
        }
    }
    
}


//MARK: - EXTENSION FOR NAVIGATION METHODS -

extension ResetPasswordVC{
    
    private func navigateToVerifyPhoneVC(){
        guard let verifyPhoneVC = R.storyboard.authSB.verifyPhoneVC() else {return}
        verifyPhoneVC.mode = .forgotPassword
        verifyPhoneVC.userPhoneNmb = self.userPhoneNmb
        verifyPhoneVC.userEmail = self.emailTextField.text ?? ""
        self.push(controller: verifyPhoneVC, hideBar: true, animated: true)
    }
    
}
