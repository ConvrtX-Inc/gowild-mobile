//
//  NewTicketVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 20/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Photos
import YPImagePicker

protocol CreateTicketDelegate: AnyObject{
    func didNewTicketCreated(ticket: SupportTicketList)
}

class NewTicketVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var photosCollectionView: UICollectionView!{
        didSet{
            photosCollectionView.delegate = self
            photosCollectionView.dataSource = self
            photosCollectionView.register(R.nib.supportPicCell)
        }
    }
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var attachLbl: UILabel!
    @IBOutlet weak var sendBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    private var createTicketVM = CreateTicketViewModel()
    private var updateAttachmentVM = UpdateTicketAttachmentViewModel()
    private var arrayOfImagesData : [Data] = []
    weak var delegates : CreateTicketDelegate?
    
    private let picker: YPImagePicker = {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 3
        config.screens = [.library]
        config.showsPhotoFilters = false
        let imgPiker = YPImagePicker(configuration: config)
        return imgPiker
    }()
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        didTapCameraImageView()
        createTicketVM.delegates = self
        updateAttachmentVM.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** NewTicketVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.support().capitalized
        subjectLbl.text = GoWildStrings.subject()
        subjectTextField.placeholder = GoWildStrings.writeSubjectHerePlaceholder()
        messageLbl.text = GoWildStrings.yourMessage()
        messageTextView.text = GoWildStrings.whatWouldYouLikeToTellUs()
        attachLbl.text = GoWildStrings.attachImagesOrProof()
        sendBtn.setTitle(GoWildStrings.sendMessage(), for: .normal)
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        subjectLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        subjectLbl.textColor = AppColor.appWhiteColor()
        subjectTextField.textColor = AppColor.bgBlackColor()
        messageLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        messageLbl.textColor = AppColor.appWhiteColor()
        messageTextView.textColor = AppColor.supportPlaceHolderColor()
        messageTextView.font = Fonts.getSourceSansProRegularOf(size: 14)
        messageTextView.delegate = self
        attachLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        attachLbl.textColor = AppColor.appWhiteColor()
        sendBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        sendBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
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
    
    private func didTapCameraImageView(){
        self.cameraImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            self.checkCameraPermission()
        }
    }
    
    @IBAction func didTapSendBtn(_ sender: UIButton){
        sender.showAnimation {
            self.view.endEditing(true)
            LoaderView.shared.showSpiner(inVC: self)
            let subject = self.subjectTextField.text?.removeExtraSpacingFromString() ?? ""
            self.subjectTextField.text = subject
            let message = self.messageTextView.text?.removeExtraSpacingFromString() ?? ""
            self.messageTextView.text = message
            let request = CreateTicketRequest(subject: subject, message: message)
            self.createTicketVM.createTicketWith(request: request)
        }
    }

}

//MARK: - EXTENSION FOR HomeRetrieveRouteViewModelDelegates -

extension NewTicketVC: CreateTicketViewModelDelegates{
    
    func didCreateTicket(response: CreateTicketResponse) {
        if let newTicket = response.data{
            self.delegates?.didNewTicketCreated(ticket: newTicket)
        }
        if self.arrayOfImagesData.isEmpty{
            LoaderView.shared.hideLoader(fromVC: self)
            AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? ""){
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            if let ticketID = response.data?.id,
               let messageID = response.data?.messageID{
                let request = UpdateTicketAttachmentRequest(messageID: messageID)
                self.updateAttachmentVM.updateTicket(id: ticketID, images: self.arrayOfImagesData,request: request)
            }
        }
    }
    
    func didCreateTicketResponseWith(error: String) {
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

//MARK: - EXTENBSION FOR UpdateTicketAttachmentViewModel DELEGATES -

extension NewTicketVC: UpdateTicketAttachmentViewModelDelegates{
    
    func didUpdateTicketAttachments(response: UpdateTicketAttachmentResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? ""){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func didUpdateTicketAttachmentsResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR COLLECTION VIEW METHODS -

extension NewTicketVC: CollectionViewMethods{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfImagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configurePicCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 84.0, height: 84.0)
    }
    
}

//MARK: - EXTENSION FOR COLLECTION VIEW CELLS METHODS -

extension NewTicketVC{
    
    private func configurePicCell(at indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.photosCollectionView.dequeueReusableCell(withReuseIdentifier: .supportPicCell, for: indexPath) as! SupportPicCell
        
        let selectedImage = self.arrayOfImagesData[indexPath.row]
        cell.attachmentImageView.image = UIImage(data: selectedImage)
        cell.deleteBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if (indexPath.row < (self.arrayOfImagesData.count)){
                self.arrayOfImagesData.remove(at: indexPath.row)
                self.photosCollectionView.reloadData()
            }
        }
        
        return cell
    }
    
}

//MARK: - EXTENSION FOR TEXTVIEW DELEGATES -

extension NewTicketVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTextView.text == GoWildStrings.whatWouldYouLikeToTellUs() {
            messageTextView.text = ""
            messageTextView.textColor = AppColor.bgBlackColor()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTextView.text.isEmpty{
            messageTextView.text = GoWildStrings.whatWouldYouLikeToTellUs()
            messageTextView.textColor = AppColor.supportPlaceHolderColor()
        }
    }
    
}


//MARK: - EXTENSION FOR PHOTO PICKER -

extension NewTicketVC{
    
    private func selectPhoto(){
        self.sendBtn.showLoading()
        
        self.picker.didFinishPicking { [weak self] items, cancelled in
            guard let self = self else {return}
            if cancelled{
                self.sendBtn.hideLoading()
            }
            
            if !items.isEmpty{
                self.arrayOfImagesData.removeAll()
                for index in (0...(items.count - 1)) {
                    switch items[index] {
                    case .photo(let photo):
                        
                        DispatchQueue.global(qos: .background).async {
                            ImageCompressor.compress(image: photo.image, maxByte: 1000000) { imageReceived in
                                
                                if let imageReceived = imageReceived,
                                   let imageData = imageReceived.pngData()
                                {
                                    if imageData.getSizeInMB() <= Constants.maxFileSize{
                                        self.arrayOfImagesData.append(imageData)
                                    }else{
                                        DispatchQueue.main.async {
                                            AlertControllers.showAlert(inVC: self, message: GoWildStrings.imageSizeError())
                                        }
                                    }
                                    if index == (items.count - 1){
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            self.sendBtn.hideLoading()
                                            self.photosCollectionView.reloadData()
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                    case .video(let video):
                        print(video)
                    }
                }
            }
            
            self.picker.dismiss(animated: true, completion: nil)
        }
        self.present(self.picker, animated: true)
    }
    
}


//MARK: - EXTENSION FOR CAMERA & LIBRARY PERMISSIONS -

extension NewTicketVC{
    
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
                        self?.selectPhoto()
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
                self?.selectPhoto()
            }
        case .limited:
            DispatchQueue.main.async { [weak self] in
                self?.selectPhoto()
            }
        @unknown default:
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
            return
        }
    }
    
}
