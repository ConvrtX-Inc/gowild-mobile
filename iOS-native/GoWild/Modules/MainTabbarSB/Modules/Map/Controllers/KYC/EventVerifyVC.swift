//
//  EventVerifyVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import SVPinView
import CoreLocation

class EventVerifyVC: UIViewController {

    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var otpView: SVPinView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var resendOTPBtn: LoadingButton!
    @IBOutlet weak var submitBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    private var registerTreasureHuntVM = RegisterTreasureHuntViewModel()
    private var verifyTreasureHuntVM = VerifyTreasureHuntViewModel()
    private var resendCodeVM = ResendCodeTreasureHuntViewModel()
    var eventID : String = ""
    private var currentPin : String = ""
    var location: TreasureHuntLocation?
    private let locationManager = CLLocationManager()
    private var currentCoordinates: CLLocation?
    
    //MARK: - LIFE CYCLES -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        configureSVPinView()
        self.setupLocation()
        registerTreasureHuntVM.delegates = self
        verifyTreasureHuntVM.delegates = self
        resendCodeVM.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        self.stopLocation()
        Constants.printLogs("*** EventVerifyVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.registrationNumber()
        descriptionLbl.text = GoWildStrings.informationFromYourRegistration()
        submitBtn.setTitle(GoWildStrings.submit(), for: .normal)
    }
    
    func setUI(){
        titleLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 18)
        titleLbl.textColor = AppColor.appWhiteColor()
        descriptionLbl.font = Fonts.getSourceSansProRegularOf(size: 14)
        descriptionLbl.textColor = AppColor.textDarkGrayColor()
        resendOTPBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 14)
        resendOTPBtn.setTitleColor(AppColor.appRedColor(), for: .normal)
        resendOTPBtn.titleLabel?.text = GoWildStrings.resendRegistrationNumber()
        resendOTPBtn.underline()
        submitBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        submitBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1
        locationManager.headingFilter = 1
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func stopLocation(){
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didTapResendBtn(_ sender: UIButton){
        sender.showAnimation {
            if !self.eventID.isEmpty{
                LoaderView.shared.showSpiner(inVC: self)
                let request = ResendCodeTreasureHuntRequest(treasureChestId: self.eventID)
                self.resendCodeVM.resendTreasureHunt(request: request)
            }
        }
    }
    
    @IBAction func didTapSubmitBtn(_ sender: UIButton){
        sender.showAnimation {
            if self.currentCoordinates != nil{
                LoaderView.shared.showSpiner(inVC: self)
                let request = VerifyTreasureHuntRequest(treasureChestId: self.eventID, code: self.currentPin)
                self.verifyTreasureHuntVM.verifyTreasureHunt(request: request)
            }else{
                self.showLocationPopup(inVC: self) {
                    self.openAppSettings()
                } cancel: {
                    self.dismiss(animated: true)
                }
            }
        }
    }

}

//MARK: - EXNTENSION FOR REGISTER TREASURE VM DELEGATES -

extension EventVerifyVC: RegisterTreasureHuntViewModelDelegates{
    
    func didGetRegisterTreasureHunt(response: RegisterTreasureHuntResponse,eventID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
    }
    
    func didGetRegisterTreasureHuntResponseWith(error: String) {
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

//MARK: - EXNTENSION FOR VERIFY TREASURE VM DELEGATES -

extension EventVerifyVC: VerifyTreasureHuntViewModelDelegates{
    
    func didVerifyTreasureHunt(response: VerifyTreasureHuntResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        /*
        AlertControllers.showAlert(inVC: self,title: GoWildStrings.success() ,message: response.message ?? ""){
            self.navigationController?.popToViewController(of: TreasureWildVC.self, animated: true)
        }
         */
        if !LocationManager.shared.userDeniedLocation{
            guard let tryTreasureChestVC = R.storyboard.tryRouteSB.mapBoxTryTreasureChestVC() else {return}
            tryTreasureChestVC.chestLocation = self.location
            tryTreasureChestVC.chestID = self.eventID
            tryTreasureChestVC.currentCoordinates = self.currentCoordinates ?? CLLocation()
            self.push(controller: tryTreasureChestVC, hideBar: true, animated: true)
//            guard let tryTreasureChestVC = R.storyboard.tryRouteSB.tryTreasureChestVC() else {return}
//            tryTreasureChestVC.chestLocation = self.location
//            tryTreasureChestVC.chestID = self.eventID
//            self.push(controller: tryTreasureChestVC, hideBar: true, animated: true)
        }else{
            AlertControllers.showAlertMessage(inVC: self, title: GoWildStrings.alert(), message: GoWildStrings.locationEnabledError()) {
                self.openAppSettings()
            } cancel: {
                self.dismiss(animated: true)
            }
        }
    }
    
    func didVerifyTreasureHuntResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR ResendCodeTreasureHuntViewModel DELEGATES -

extension EventVerifyVC: ResendCodeTreasureHuntViewModelDelegates {
    
    func didResendRegisterTreasureHunt(response: ResendCodeTreasureHuntResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? "")
    }
    
    func didResendRegisterTreasureHuntResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR SVPIN CONFIGURE METHODS -

extension EventVerifyVC{
    
    private func configureSVPinView(){
        otpView.style = .box
        otpView.font = Fonts.getSourceSansProBoldOf(size: 20) ?? .boldSystemFont(ofSize: 20)
        otpView.keyboardType = .numberPad
        otpView.keyboardAppearance = .default
//        pinView.becomeFirstResponderAtIndex = 0
        otpView.didFinishCallback = { [weak self] pin in
            self?.currentPin = pin
        }
        otpView.didChangeCallback = { [weak self] pin in
            self?.currentPin = pin
        }
    }
    
}



//MARK: - EXTENSION FOR CLLOCATION DELEGATES -

extension EventVerifyVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        self.currentCoordinates = location
        
    }
    
}
