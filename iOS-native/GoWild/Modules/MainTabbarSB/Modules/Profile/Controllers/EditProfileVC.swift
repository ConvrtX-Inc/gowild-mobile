//
//  EditProfileVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Kingfisher
import YPImagePicker
import TOCropViewController

class EditProfileVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var aboutMeLbl: UILabel!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var saveBtn: LoadingButton!
    
    
    //MARK: - PROPERTIES -
    
    private var editProfileViewModel = EditProfileViewModel()
    private var updateProfilePicViewModel = EditProfilePicViewModel()
    private var userImageData: Data?
    
    let picker: YPImagePicker = {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 1
        config.screens = [.photo, .library]
        let imgPiker = YPImagePicker(configuration: config)
        return imgPiker
    }()
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        editProfileViewModel.delegates = self
        updateProfilePicViewModel.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit {
        Constants.printLogs("**** EditProfileVC Deinit ****")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.editProfile().capitalized
        firstNameLbl.text = GoWildStrings.firstName()
        firstNameTextField.text = UserManager.shared.firstName
        lastNameLbl.text = GoWildStrings.lastName()
        lastNameTextField.text = UserManager.shared.lastName
        userNameLbl.text = GoWildStrings.userName()
        userNameTextField.text = UserManager.shared.username
        emailLbl.text = GoWildStrings.email()
        emailTextField.text = UserManager.shared.email
        emailTextField.isEnabled = false
        aboutMeLbl.text = GoWildStrings.aboutMe()
        if let aboutMe = UserManager.shared.aboutMe,
           !aboutMe.isEmpty{
            aboutMeTextView.text = aboutMe
            aboutMeTextView.textColor = AppColor.appWhiteColor()
        }else{
            aboutMeTextView.text = GoWildStrings.typeHere()
            aboutMeTextView.textColor = AppColor.textFieldBorderColor()
        }
        saveBtn.setTitle(GoWildStrings.save(), for: .normal)
        setUserImageView()
        didTapUserImageView()
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        firstNameLbl.textColor = AppColor.appWhiteColor()
        firstNameLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        firstNameTextField.textColor = AppColor.appWhiteColor()
        firstNameTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        lastNameLbl.textColor = AppColor.appWhiteColor()
        lastNameLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        lastNameTextField.textColor = AppColor.appWhiteColor()
        lastNameTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        userNameLbl.textColor = AppColor.appWhiteColor()
        userNameLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        userNameTextField.textColor = AppColor.appWhiteColor()
        userNameTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        emailLbl.textColor = AppColor.appWhiteColor()
        emailLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        emailTextField.textColor = AppColor.appWhiteColor()
        emailTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        aboutMeLbl.textColor = AppColor.appWhiteColor()
        aboutMeLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        aboutMeTextView.textColor = AppColor.textFieldBorderColor()
        aboutMeTextView.font = Fonts.getSourceSansProRegularOf(size: 14)
        aboutMeTextView.text = GoWildStrings.typeHere()
        aboutMeTextView.delegate = self
        saveBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        saveBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func setUserImageView(){
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
    
    private func didTapUserImageView(){
        self.profileImageView.addTapGestureRecognizer { [weak self] in
            self?.checkCameraPermission()
        }
    }
    
    @IBAction func didTapSaveBtn(_ sender: UIButton){
        sender.showAnimation {
            if !self.saveBtn.isAnimating{
                self.saveBtn.showLoading()
                let firstName = self.removeExtraSpacingFrom(name: self.firstNameTextField.text ?? "")
                let lastName = self.removeExtraSpacingFrom(name: self.lastNameTextField.text ?? "")
                let userName = self.removeExtraSpacingFrom(name: self.userNameTextField.text ?? "")
                let aboutMe = self.aboutMeTextView.text == GoWildStrings.typeHere() ? "" : self.aboutMeTextView.text
                let request = EditProfileRequest(firstName: firstName, lastName: lastName, aboutMe: aboutMe ?? "")
                self.editProfileViewModel.editUserWith(request: request,username: userName)
            }
        }
    }
    

}


//MARK: - EXTENSION FOR EditProfileViewModelDelegates -

extension EditProfileVC: EditProfileViewModelDelegates{
    
    func didEditUser(response: EditProfileResponse) {
        if let userImageData = self.userImageData{
            self.updateProfilePicViewModel.uploadUser(image: userImageData)
        }else{
            LoaderView.shared.hideLoader(fromVC: self)
            if self.saveBtn.isAnimating {self.saveBtn.hideLoading()}
            AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? "")
        }
        if let user = response.user{
            let newUser = UserManager.shared.convertUser(user: user)
            UserManager.shared.saveUser(user: newUser)
        }
        if self.userImageData == nil{
            NotificationCenter.default.post(name: .userUpdated, object: nil)
        }
    }
    
    func didEditUserResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.saveBtn.isAnimating {self.saveBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.saveBtn.isAnimating {self.saveBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.saveBtn.isAnimating {self.saveBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}

//MARK: - EXTENSION FOR EditProfilePicViewModelDelegates -

extension EditProfileVC: EditProfilePicViewModelDelegates{
    
    func didUpdateUserPicture(response: EditProfilePicResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.saveBtn.isAnimating {self.saveBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? "")
        if let user = response.user{
            let newUser = UserManager.shared.convertUser(user: user)
            UserManager.shared.saveUser(user: newUser)
            NotificationCenter.default.post(name: .userUpdated, object: nil)
        }
    }
    
    func didUpdateUserPictureResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.saveBtn.isAnimating {self.saveBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    
}

//MARK: - EXTENSION FOR TEXTVIEW DELEGATES -

extension EditProfileVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if aboutMeTextView.text == GoWildStrings.typeHere() {
            aboutMeTextView.text = ""
            aboutMeTextView.textColor = AppColor.appWhiteColor()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if aboutMeTextView.text.isEmpty{
            aboutMeTextView.text = GoWildStrings.typeHere()
            aboutMeTextView.textColor = AppColor.textFieldBorderColor()
        }
    }
    
}

//MARK: - EXTENSION FOR CAMERA & LIBRARY PERMISSIONS -

extension EditProfileVC{
    
    private func selectUserPhoto(){
        self.saveBtn.showLoading()
        self.picker.didFinishPicking { [weak self] items, cancelled in
            guard let self = self else {return}
            
            if cancelled{
                self.saveBtn.hideLoading()
            }
            if let photo = items.singlePhoto{
                DispatchQueue.global(qos: .background).async {
                    ImageCompressor.compress(image: photo.image, maxByte: 1000000) { imageReceived in
                        self.saveBtn.hideLoading()
                        if let imageReceived = imageReceived,
                           let imageData = imageReceived.pngData(){
                            if imageData.getSizeInMB() <= Constants.maxFileSize{
                                DispatchQueue.main.async {
                                    self.profileImageView.image = photo.image
                                }
                                self.userImageData = nil
                                self.userImageData = imageData
                                Constants.printLogs("Image Recieved: \(photo.image)")
                            }else{
                                AlertControllers.showAlert(inVC: self, message: GoWildStrings.imageSizeError())
                            }
                        }
                    }
                    
                }
            }
            self.picker.dismiss(animated: true, completion: nil)
        }
        self.present(self.picker, animated: true)
    }
    
    func checkCameraPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    self?.checkLibraryPermission()
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
                self?.checkLibraryPermission()
            }
        @unknown default:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
            return
        }
    }
    
    private func checkLibraryPermission(){
        let photos = PHPhotoLibrary.authorizationStatus()
        switch photos {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .authorized{
                    DispatchQueue.main.async { [weak self] in
                        self?.selectUserPhoto()
                    }
                }
            }
        case .restricted:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.libraryPermissionError()){
                self.openAppSettings()
            }
        case .denied:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.libraryPermissionError()){
                self.openAppSettings()
            }
        case .authorized:
            DispatchQueue.main.async { [weak self] in
                self?.selectUserPhoto()
            }
        case .limited:
            DispatchQueue.main.async { [weak self] in
                self?.selectUserPhoto()
            }
        @unknown default:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
            return
        }
    }
    
}

//MARK: - EXTENSION FOR IMAGE CROPER METHODS - {

extension EditProfileVC: TOCropViewControllerDelegate, UINavigationControllerDelegate{
    
    func openCropViewController(with image: UIImage){
        let vc = TOCropViewController(croppingStyle: .default, image: image)
        vc.aspectRatioPreset = .presetSquare
        vc.minimumAspectRatio = 1.0
        vc.aspectRatioPickerButtonHidden = true
        vc.toolbarPosition = .bottom
        vc.doneButtonTitle = GoWildStrings.done()
        vc.cancelButtonTitle = GoWildStrings.cancel()
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        self.saveBtn.hideLoading()
        cropViewController.dismiss(animated: true)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true)
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {return}
            ImageCompressor.compress(image: image, maxByte: 1000000) { imageReceived in
                self.saveBtn.hideLoading()
                if let imageReceived = imageReceived,
                   let imageData = imageReceived.pngData(){
                    if imageData.getSizeInMB() <= Constants.maxFileSize{
                        DispatchQueue.main.async {
                            self.profileImageView.image = image
                        }
                        self.userImageData = nil
                        self.userImageData = imageData
                        Constants.printLogs("Image Recieved: \(image)")
                    }else{
                        AlertControllers.showAlert(inVC: self, message: GoWildStrings.imageSizeError())
                    }
                }
            }
        }
    }
    
}


//MARK: - SPLIT USER NAME -

extension EditProfileVC{
    
    private func removeExtraSpacingFrom(name: String) -> String{
        return name.components(separatedBy:.whitespacesAndNewlines).filter { $0.count > 0 }.joined(separator: " ")
    }
    
}
