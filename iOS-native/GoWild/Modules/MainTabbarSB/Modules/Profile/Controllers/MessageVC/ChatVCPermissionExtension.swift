//
//  ChatVCPermissionExtension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 03/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import YPImagePicker
import Photos
import TOCropViewController
import MobileCoreServices

//MARK: - EXTENSION FOR PHOTO PICKER -

extension ChatVC{
    
    private func selectPhoto(){
//        self.createPostBtn.showLoading()
        self.picker.didFinishPicking { [weak self] items, cancelled in
            guard let self = self else {return}
            
            if let photo = items.singlePhoto{
                DispatchQueue.main.async {
                    self.openCropViewController(with: photo.image)
                }
                
            }
            self.picker.dismiss(animated: true, completion: nil)
        }
        self.present(self.picker, animated: true)
    }
    
    func showDocuments(){
        let documentVC = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentVC.delegate = self
        documentVC.allowsMultipleSelection = true
        documentVC.modalPresentationStyle = .formSheet
        self.present(documentVC, animated: true, completion: nil)
    }
    
}


//MARK: - EXTENSION FOR CAMERA & LIBRARY PERMISSIONS -

extension ChatVC{
    
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


//MARK: - EXTENSION FOR IMAGE CROPER METHODS - {

extension ChatVC: TOCropViewControllerDelegate, UINavigationControllerDelegate{
    
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
//        self.createPostBtn.hideLoading()
        cropViewController.dismiss(animated: true)
        AlertControllers.showAlert(inVC: self, message: GoWildStrings.postImagePickCancelError())
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true)
        self.compress(image: image)
        
    }
    
    private func compress(image: UIImage){
        ImageCompressor.compress(image: image, maxByte: 1000000) { [weak self] imageReceived in
            guard let weakSelf = self else {return}
            if let imageReceived = imageReceived,
               let imageData = imageReceived.jpegData(compressionQuality: 1.0){
                if imageData.getSizeInMB() <= Constants.maxFileSize{
                    DispatchQueue.main.async {
                        LoaderView.shared.showSpiner(inVC: weakSelf)
                        weakSelf.sendAttachmentMsgVM.sendAttachmentOf(friendID: weakSelf.userID, attachmentData: imageData, type: .png)
                    }
                }else{
                    AlertControllers.showAlert(inVC: weakSelf, message: GoWildStrings.imageSizeError())
                }
            }
        }
    }
    
}


//MARK: - EXTENSION FOR DOCUMENT PICKER DELEGATES -

extension ChatVC: UIDocumentMenuDelegate, UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls{
            guard let data = NSData(contentsOf: url) else {
                return
            }
            let fileData = data as Data
            if fileData.getSizeInMB() <= Constants.maxFileSize{
                LoaderView.shared.showSpiner(inVC: self)
                self.sendAttachmentMsgVM.sendAttachmentOf(friendID: self.userID, attachmentData: fileData, type: .pdf)
            }else{
                AlertControllers.showAlert(inVC: self, message: GoWildStrings.attachmentSizeError())
            }
        }
        
    }


    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        self.dismiss(animated: true, completion: nil)
        
    }
}
