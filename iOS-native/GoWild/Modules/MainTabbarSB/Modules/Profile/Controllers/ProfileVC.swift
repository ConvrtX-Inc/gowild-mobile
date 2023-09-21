//
//  ProfileVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 29/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher

class ProfileVC: UIViewController {

    //MARK: - OUTLETS -
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var aboutMeLbl: UILabel!
    @IBOutlet weak var verificationBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    
    
    //MARK: - LIFE CYCLES -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateProfileImage()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.profile().capitalized
        verificationBtn.setTitle(GoWildStrings.selfieVerification(), for: .normal)
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        nameLbl.font = Fonts.getSourceSansProBoldOf(size: 20)
        nameLbl.textColor = AppColor.appWhiteColor()
        aboutLbl.font = Fonts.getSourceSansProBoldOf(size: 18)
        aboutLbl.textColor = AppColor.appWhiteColor()
        aboutMeLbl.font = Fonts.getSourceSansProRegularOf(size: 14)
        aboutMeLbl.textColor = AppColor.appWhiteColor()
        verificationBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        verificationBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        didTapUserProfile()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func updateProfileImage(){
        nameLbl.text = "\(UserManager.shared.firstName ?? "") \(UserManager.shared.lastName ?? "")"
        aboutLbl.text = GoWildStrings.aboutMe()
        aboutMeLbl.text = UserManager.shared.aboutMe ?? ""
        if let profileURL = URL(string: "\(UserManager.shared.getBaseURL())\(UserManager.shared.picture ?? "")"){
            self.profileImageView.kf.indicatorType = .activity
            self.profileImageView.kf.setImage(with: profileURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            self.profileImageView.image = R.image.ic_user_placeholder_image()
        }
    }
    
    private func navigateToSelfieVerificationVC(){
        guard let selfieVerificationVC = R.storyboard.profileSB.selfieVerificationVC() else {return}
        self.push(controller: selfieVerificationVC, hideBar: true, animated: true)
    }
    
    //MARK: - ACTIONS -
    
    private func didTapUserProfile(){
        self.profileImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if let userProfile = UserManager.shared.picture,
               !userProfile.isEmpty{
                let userPicURL = "\(UserManager.shared.getBaseURL())\(userProfile)"
                LightBoxVC.shared.showImage(with: userPicURL,inVC: self)
            }
        }
    }
    
    @IBAction func didTapSelfieVerificationBtn(_ sender: UIButton) {
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            guard let imageVerified = UserManager.shared.selfieVerified else {
                self.checkCameraPermission()
                return
            }
            if !imageVerified{
                self.checkCameraPermission()
            }else{
                AlertControllers.showAlert(inVC: self, message: GoWildStrings.yourSelfieAlreadyVerified())
            }
        }
    }
    

}


//MARK: - EXTENSION FOR CAMERA PERMISSSION -

extension ProfileVC{
    
    func checkCameraPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.navigateToSelfieVerificationVC()
                    }
                }
            }
        case .restricted:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.cameraPermissionError()){
                self.openAppSettings()
            }
        case .denied:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.cameraPermissionError()){
                self.openAppSettings()
            }
        case .authorized:
            DispatchQueue.main.async { [weak self] in
                self?.navigateToSelfieVerificationVC()
            }
        @unknown default:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
            return
        }
    }
    
}
