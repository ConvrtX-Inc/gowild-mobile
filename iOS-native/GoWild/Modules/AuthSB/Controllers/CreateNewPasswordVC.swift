//
//  CreateNewPasswordVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 11/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class CreateNewPasswordVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var newPasswordLbl: UILabel!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLbl: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var resetPasswordBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    private var viewModel = SetNewPasswordViewModel()
    var phoneNmb: String = ""
    var email: String = ""
    var otpCode: String = ""
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        viewModel.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** CreateNewPasswordVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.createNewPassword().capitalized
        subTitleLbl.text = GoWildStrings.yourPasswordMustBeDifferentFromPreviousUsedPassword()
        newPasswordLbl.text = GoWildStrings.enterNewPassword()
        confirmPasswordLbl.text = GoWildStrings.confirmNewPassword()
        resetPasswordBtn.setTitle(GoWildStrings.reset_Password(), for: .normal)
    }
    
    func setUI(){
        self.backView.backgroundColor = AppColor.appBgColor()
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 50)
        titleLbl.textColor = AppColor.textLightYellow()
        subTitleLbl.font = Fonts.getSourceSansProRegularOf(size: 18)
        subTitleLbl.textColor = AppColor.textLightGrayColor()
        newPasswordLbl.textColor = AppColor.appWhiteColor()
        newPasswordLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        newPasswordTextField.textColor = AppColor.appWhiteColor()
        newPasswordTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        confirmPasswordLbl.textColor = AppColor.appWhiteColor()
        confirmPasswordLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        confirmPasswordTextField.textColor = AppColor.appWhiteColor()
        confirmPasswordTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        resetPasswordBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        resetPasswordBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
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
    
    @IBAction func didTapResetPasswordBtn(_ sender: UIButton){
        sender.showAnimation {
            self.view.endEditing(true)
            if !self.resetPasswordBtn.isAnimating{
                self.resetPasswordBtn.showLoading()
                let request = SetNewPasswordRequest(password: self.newPasswordTextField.text ?? "", otpCode: self.otpCode, phone: self.phoneNmb,email: self.email)
                self.viewModel.setNewPasswordWith(request: request, confirmPassword: self.confirmPasswordTextField.text ?? "")
            }
        }
    }
    
}


//MARK: - EXTENSION FOR SET NEW PASSWORD VIEWMODEL DELEGATES -

extension CreateNewPasswordVC: SetNewPasswordViewModelDelegates{
    
    func didGetSetNewPassword(response: SetNewPasswordResponse) {
        self.resetPasswordBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: response.responseMessage ?? GoWildStrings.passwordResetSuccessMessage()){
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func didGetSetNewPasswordResponseWith(error: String) {
        self.resetPasswordBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        self.resetPasswordBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        self.resetPasswordBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
}
