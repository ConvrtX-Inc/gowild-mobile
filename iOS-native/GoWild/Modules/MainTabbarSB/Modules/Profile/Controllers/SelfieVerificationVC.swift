//
//  SelfieVerificationVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit
import AVFoundation

class SelfieVerificationVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var prepareLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var submitBtn: LoadingButton!
    
    
    //MARK: - PROPERTIES -
    
    private var selfieVerifyVM: SelfieVerificationViewModel = SelfieVerificationViewModel()
    private var captureSession: AVCaptureSession!
    private var stillImageOutput: AVCapturePhotoOutput!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var profileImage = UIImage()
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        selfieVerifyVM.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Setup your camera here...
        self.setupFrontCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** SelfieVerificationVC Deinit ***")
    }

    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.selfieVerification().capitalized
        prepareLbl.text = GoWildStrings.prepareToScanYourFace()
        descriptionLbl.text = GoWildStrings.makeSureYouAreInAWellLitRoomDescription()
        submitBtn.setTitle(GoWildStrings.submit(), for: .normal)
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func verifySelfie(imageData: Data){
        LoaderView.shared.showSpiner(inVC: self)
        self.captureSession.stopRunning()
        self.selfieVerifyVM.getSelfieVerification(imageOne: imageData, imageTwo: imageData)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func didTapSubmitBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.proceedToTakePicture()
        }
    }
    

}

//MARK: - EXTENSIONN FOR SELFIE VERIFICATION VIEWMODEL DELEGATES -

extension SelfieVerificationVC: SelfieVerificationViewModelDelegates{
    
    func didGetSelfieVerification(response: SelfieVerificationResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let isVerified = response.selfieVerified,
           isVerified{
            let currentUser = UserManager.shared
            currentUser.selfieVerified = isVerified
            UserManager.shared.saveUser(user: currentUser)
            AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? ""){ [weak self] in
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            AlertControllers.showAlert(inVC: self, message: response.message ?? ""){ [weak self] in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.captureSession.startRunning()
                }
            }
        }
    }
    
    func didGetSelfieVerificationResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error){ [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.captureSession.startRunning()
            }
        }
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){ [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.captureSession.startRunning()
            }
        }
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}

//MARK: - EXTENSION FOR CAMERA SETUP -

extension SelfieVerificationVC{
    
    private func setupFrontCamera(){
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        guard let frontCamera = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: .front) else {
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            //Step 9
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize front camera:  \(error.localizedDescription)")
        }
    }
    
    fileprivate func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(videoPreviewLayer)
        //Step12
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            //Step 13
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.cameraView.bounds
            }
        }
    }
    
    fileprivate func proceedToTakePicture(){
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
}

//MARK: - EXTENSION FOR AVCapturePhotoCaptureDelegate -

extension SelfieVerificationVC: AVCapturePhotoCaptureDelegate{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation()
        else { return }
        self.verifySelfie(imageData: imageData)
    }
    
}
