//
//  EventRegisterVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 21/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import PhoneNumberKit
import IQDropDownTextField
import YPImagePicker
import Kingfisher

class EventRegisterVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backgroungImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNmbLbl: UILabel!
    @IBOutlet weak var phoneNmbTextField: PhoneNumberTextField!
    @IBOutlet weak var adventureImageView: UIImageView!{
        didSet{
            adventureImageView.clipsToBounds = true
            adventureImageView.roundCorners(corners: [.allCorners], radius: 20.0)
        }
    }
    @IBOutlet weak var adventureImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var companyTitleLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dobTextField: IQDropDownTextField!
    @IBOutlet weak var frontIDLbl: UILabel!
    @IBOutlet weak var frontIDImageView: UIImageView!
    @IBOutlet weak var backIDLbl: UILabel!
    @IBOutlet weak var backIDImageView: UIImageView!
    @IBOutlet weak var submitBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    private var updateUserViewModel = UpdateUserViewModel()
    private var updatePicturesViewModel = UpdateUserPicturesViewModel()
    private var registerTreasureHuntVM = RegisterTreasureHuntViewModel()
    
    let picker: YPImagePicker = {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 1
        config.screens = [.photo, .library]
        config.showsPhotoFilters = false
        let imgPiker = YPImagePicker(configuration: config)
        return imgPiker
    }()
    
    var selectedFirstImageData: Data?
    var selectedSecondImageData: Data?
    var eventID : String = ""
    var companyTitle: String = ""
    private var userPhoneNmb : String{
        return "+\(phoneNmbTextField.phoneNumber?.countryCode ?? 123)\(phoneNmbTextField.phoneNumber?.nationalNumber ?? 456)"
    }
    var eventPicture: String = ""
    
    //MARK: - LIFE CYCELS -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        configurePhoneNumberKit()
        updateUserViewModel.delegates = self
        updatePicturesViewModel.delegates = self
        registerTreasureHuntVM.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** EventRegisterVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.registration().capitalized
        companyTitleLbl.text = self.companyTitle
        fullNameLbl.text = GoWildStrings.fullName()
        fullNameTextField.text = "\(UserManager.shared.firstName ?? "") \(UserManager.shared.lastName ?? "")"
        emailLbl.text = GoWildStrings.email()
        emailTextField.text = UserManager.shared.email
        phoneNmbLbl.text = GoWildStrings.phoneNumber()
        phoneNmbTextField.text = UserManager.shared.phoneNo
        genderLbl.text = GoWildStrings.gender()
        genderTextField.text = UserManager.shared.gender
        dobLbl.text = GoWildStrings.dob()
        setDateOfBirth()
        frontIDLbl.text = GoWildStrings.frontID()
        backIDLbl.text = GoWildStrings.backID()
        submitBtn.setTitle(GoWildStrings.submit(), for: .normal)
        if let eventImageURL = URL(string: self.eventPicture){
            self.adventureImageView.kf.indicatorType = .activity
            self.adventureImageView.kf.setImage(with: eventImageURL, placeholder: R.image.ic_adventure_image())
        }
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        companyTitleLbl.font = Fonts.getForegenRoughOneFontOf(size: 24)
        companyTitleLbl.textColor = AppColor.appWhiteColor()
        fullNameLbl.textColor = AppColor.appWhiteColor()
        fullNameLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        fullNameTextField.textColor = AppColor.appWhiteColor()
        fullNameTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        fullNameTextField.isEnabled = false
        emailLbl.textColor = AppColor.appWhiteColor()
        emailLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        emailTextField.textColor = AppColor.appWhiteColor()
        emailTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        emailTextField.isEnabled = false
        phoneNmbLbl.textColor = AppColor.appWhiteColor()
        phoneNmbLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        phoneNmbTextField.textColor = AppColor.appWhiteColor()
        phoneNmbTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        if let phoneNmb = UserManager.shared.phoneNo,
           !phoneNmb.isEmpty{
            phoneNmbTextField.isEnabled = false
        }else{
            phoneNmbTextField.isEnabled = true
        }
        genderLbl.textColor = AppColor.appWhiteColor()
        genderLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        genderTextField.textColor = AppColor.appWhiteColor()
        genderTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        dobLbl.textColor = AppColor.appWhiteColor()
        dobLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        dobTextField.textColor = AppColor.appWhiteColor()
        dobTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        configureDatePickerView()
        frontIDLbl.textColor = AppColor.appWhiteColor()
        frontIDLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        frontIDImageView.image = R.image.ic_front_id_card_image()
        addFrontIDImageViewSelector()
        backIDLbl.textColor = AppColor.appWhiteColor()
        backIDLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        backIDImageView.image = R.image.ic_back_ic_card_image()
        addBackIDImageViewSelector()
        submitBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        submitBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func setDateOfBirth(){
        if let dob = UserManager.shared.birthDate,
           !dob.isEmpty{
//            let dateOfBirth = Utils.shared.getUserDateOfBirth(dob: dob)
            dobTextField.selectedItem = dob
        }
    }
    
    //MARK: - ACTIONS -

    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func didTapGenderBtn(_ sender: UIButton) {
        sender.showAnimation {
            guard let genderVC = R.storyboard.mapSB.genderVC() else {return}
            genderVC.delegate = self
            self.present(genderVC, animated: true)
        }
    }
    
    private func addFrontIDImageViewSelector(){
        self.frontIDImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if !self.submitBtn.isAnimating{
                self.checkCameraPermissionFor(frontID: true)
            }
        }
    }
    
    private func addBackIDImageViewSelector(){
        self.backIDImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if !self.submitBtn.isAnimating{
                self.checkCameraPermissionFor(frontID: false)
            }
        }
    }
    
    @IBAction func didTapSubmitBtn(_ sender: UIButton) {
        sender.showAnimation {
            if !self.submitBtn.isAnimating{
                self.submitBtn.showLoading()
                self.view.endEditing(true)
                let fullName = self.removeExtraSpacingFrom(name: self.fullNameTextField.text ?? "")
                let firstName = self.split(fullName: fullName).0
                let lastName = self.split(fullName: fullName).1
                let request = UpdateUserRequest(firstName: firstName, lastName: lastName, gender: self.genderTextField.text ?? "", birthDate: self.dobTextField.selectedItem)
                let images: [Data?] = [self.selectedFirstImageData ?? nil, self.selectedSecondImageData ?? nil]
                self.updateUserViewModel.updateUserWith(request: request,phoneNmb: self.userPhoneNmb,isValidNmb: self.phoneNmbTextField.isValidNumber,images: images)
            }
        }
    }
    
}

//MARK: - EXTENSION FOR UpdateUserViewModelDelegates

extension EventRegisterVC: UpdateUserViewModelDelegates{
    
    func didUpdateUser(response: UpdateUserResponse) {
        
        let request = RegisterTreasureHuntRequest(treasureChestId: self.eventID)
        self.registerTreasureHuntVM.registerTreasureHunt(request: request, eventID: eventID)
        
        if let firstImage = self.selectedFirstImageData,
           let secondImage = self.selectedSecondImageData{
            self.updatePicturesViewModel.updateUserWith(images: [firstImage, secondImage])
        }
        if let user = response.user{
            let newUser = UserManager.shared.convertUser(user: user)
            UserManager.shared.saveUser(user: newUser)
        }
    }
    
    func didUpdateUserResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.submitBtn.isAnimating {self.submitBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.submitBtn.isAnimating {self.submitBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.submitBtn.isAnimating {self.submitBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}

//MARK: - EXTENSION FOR USER UPDATE PICTURES VIEWMODEL DELEGATES -

extension EventRegisterVC: UpdateUserPicturesViewModelDelegates{
    
    func didUpdateUserPictures(response: UpdateUserPicturesResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.submitBtn.isAnimating {self.submitBtn.hideLoading()}
        if let user = response.user{
            let newUser = UserManager.shared.convertUser(user: user)
            UserManager.shared.saveUser(user: newUser)
        }
    }
    
    func didUpdateUserPicturesResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.submitBtn.isAnimating {self.submitBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXNTENSION FOR REGISTER TREASURE VM DELEGATES -

extension EventRegisterVC: RegisterTreasureHuntViewModelDelegates{
    
    func didGetRegisterTreasureHunt(response: RegisterTreasureHuntResponse,eventID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? ""){
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func didGetRegisterTreasureHuntResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR GENDER SELECTION DELEGATES -

extension EventRegisterVC: GenderVCDelegates{
    
    func didSelectGenderOf(name: String) {
        self.genderTextField.text = name
    }
    
}

//MARK: - EXTENSION FOR METHODS -

extension EventRegisterVC{
    
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
    
    private func configureDatePickerView(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = .userDateOfBirthFormat
        dobTextField.dropDownMode = .datePicker
        dobTextField.dateFormatter = dateFormatter
        dobTextField.datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
    }
    
}

//MARK: - EXTENSION FOR SELECT PHOTO METHODS -

extension EventRegisterVC{
    
    private func selectPhotoFor(frontID: Bool){
        self.submitBtn.showLoading()
        self.picker.didFinishPicking { [weak self] items, cancelled in
            guard let self = self else {return}

            if cancelled{
                self.submitBtn.hideLoading()
            }
            if let photo = items.singlePhoto{
                DispatchQueue.global(qos: .background).async {
                    ImageCompressor.compress(image: photo.image, maxByte: 1000000) { imageReceived in
                        self.submitBtn.hideLoading()
                        if let imageReceived = imageReceived,
                           let imageData = imageReceived.pngData(){
                            if imageData.getSizeInMB() <= Constants.maxFileSize{
                                if frontID{
                                    DispatchQueue.main.async {
                                        self.frontIDImageView.image = photo.image
                                    }
                                    self.selectedFirstImageData = nil
                                    self.selectedFirstImageData = imageData
                                }else{
                                    DispatchQueue.main.async {
                                        self.backIDImageView.image = photo.image
                                    }
                                    self.selectedSecondImageData = nil
                                    self.selectedSecondImageData = imageData
                                }
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
    
}

//MARK: - SPLIT USER NAME -

extension EventRegisterVC{
    
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
                    return (fullName, fullName)
                }
            }else if fullName.contains(find: "."){
                if let firstName = fullName.components(separatedBy: ".").first,
                   let lastName = fullName.components(separatedBy: ".").last{
                    return (firstName, lastName)
                }else{
                    return (fullName, fullName)
                }
            }else{
                return (fullName, fullName)
            }
        }else{
            return ("", "")
        }
    }
    
}


//MARK: - EXTENSION FOR CAMERA & LIBRARY PERMISSIONS -

extension EventRegisterVC{
    
    func checkCameraPermissionFor(frontID: Bool){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    self?.checkLibraryPermissionFor(frontID: frontID)
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
                self?.checkLibraryPermissionFor(frontID: frontID)
            }
        @unknown default:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
            return
        }
    }
    
    private func checkLibraryPermissionFor(frontID: Bool){
        let photos = PHPhotoLibrary.authorizationStatus()
        switch photos {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .authorized{
                    DispatchQueue.main.async { [weak self] in
                        self?.selectPhotoFor(frontID: frontID)
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
                self?.selectPhotoFor(frontID: frontID)
            }
        case .limited:
            DispatchQueue.main.async { [weak self] in
                self?.selectPhotoFor(frontID: frontID)
            }
        @unknown default:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
            return
        }
    }
    
}
