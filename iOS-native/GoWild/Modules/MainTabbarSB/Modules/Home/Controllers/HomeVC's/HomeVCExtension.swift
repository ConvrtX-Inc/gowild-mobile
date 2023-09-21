//
//  HomeVCExtension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import AVFoundation
import MobileCoreServices
import Photos
import YPImagePicker
import TOCropViewController
import Kingfisher

//MARK: - EXTENSION FOR CreatePostViewModelDelegates -

extension HomeVC: CreatePostViewModelDelegates{
    
    func didCreateNewPost(response: CreatePostResponse) {
        if self.selectedImageData != nil || self.selectedAttachmentData != nil{
            if let postID = response.data?.id{
                DispatchQueue.global(qos: .background).async { [weak self] in
                    guard let self = self else {return}
                    self.updatePostImageViewModel.updatePostImageWith(postID: postID, imageData: self.selectedImageData, attachmentData: self.selectedAttachmentData)
                }
            }else{
                self.createPostBtn.hideLoading()
                AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
            }
        }else{
            self.createPostBtn.hideLoading()
            self.postTextView.text = GoWildStrings.newPostTextViewPlaceholder()
            self.selectedImageData = nil
            self.selectAttachmentBtn = nil
            self.view.endEditing(true)
            if let newPost = response.data{
                self.arrayOfPost.insert(newPost, at: 0)
                DispatchQueue.main.async { [weak self] in
                    self?.homeFeedsPostTableView.reloadData()
                }
            }
            AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? "")
        }
    }
    
    func didCreateNewPostResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.createPostBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR PostUpdatePictureViewModel -

extension HomeVC: PostUpdatePictureViewModelDelegates{
    
    func didUpdatePostImage(response: PostUpdatePictureResponse) {
        self.createPostBtn.hideLoading()
        self.postTextView.text = GoWildStrings.newPostTextViewPlaceholder()
        self.selectedImageData = nil
        self.selectAttachmentBtn = nil
        self.view.endEditing(true)
        if let newPost = response.data{
            self.arrayOfPost.insert(newPost, at: 0)
            DispatchQueue.main.async { [weak self] in
                self?.postPhotoImageView.image = nil
                self?.postPhotoBackView.isHidden = true
                self?.homeFeedsPostTableView.reloadData()
            }
        }
        AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? "")
    }
    
    func didUpdatePostImageResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.createPostBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR SUGGESTED FRIENDS VIEWMODEL DELEGATES -

extension HomeVC: SuggestedFriendsViewModelDelegates{
    
    func didGetSuggestedFriends(response: SuggestedFriendsResponse) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.retrievePostsViewModel.retrievePosts()
        }
        if let suggestedFriends = response.data{
            if !suggestedFriends.isEmpty{
                self.suggestedFriends = suggestedFriends
            }else{
                self.suggestedFriends.removeAll()
            }
        }
        /*
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            if self.suggestedFriends.count > 0 {
                self.seeAllFriendsBtn.isHidden = false
                self.suggestedFriendTableView.isHidden = false
            }else{
                self.seeAllFriendsBtn.isHidden = true
                self.suggestedFriendTableView.isHidden = true
            }
            self.suggestedFriendTableView.reloadData()
        }
         */
    }
    
    func didGetSuggestedFriendsResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR SendFriendRequestViewModelDelegates -

extension HomeVC: SendFriendRequestViewModelDelegates{
    
    func didSendFriendRequest(response: SendFriendRequestResponse,index: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if index < self.suggestedFriends.count{
            self.suggestedFriends.remove(at: index)
        }
        DispatchQueue.main.async { [weak self] in
            self?.suggestedFriendTableView.reloadData()
        }
    }
    
    func didSendFriendRequestResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR MY FRIENDS VIEWMODEL DELEGATES -

extension HomeVC: MyFriendsViewModelDelegates{
    
    func didGetAllMyFriends(response: MyFriendsResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let myFriends = response.data{
            if !myFriends.isEmpty{
                self.myFriends = myFriends
            }else{
                self.myFriends.removeAll()
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            if self.myFriends.count > 0 {
                self.suggestedFriendTableView.isHidden = false
            }else{
                self.suggestedFriendTableView.isHidden = true
            }
            self.suggestedFriendTableView.reloadData()
        }
    }
    
    func didGetAllMyFriendsResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR DeleteFriendViewModel DELEGATES -

extension HomeVC: DeleteFriendViewModelDelegates{
    
    func didDeleteFriend(response: DeleteFriendResponse,friendID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let index = self.myFriends.firstIndex(where: {$0.id == friendID}){
            self.myFriends.remove(at: index)
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            if self.myFriends.count > 0 {
                self.suggestedFriendTableView.isHidden = false
            }else{
                self.suggestedFriendTableView.isHidden = true
            }
            self.suggestedFriendTableView.reloadData()
        }
    }
    
    func didDeleteFriendResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR DELETE SUGGESTED FRIENDS VIEWMODEL DELEGATES -

extension HomeVC: SuggestedDeleteViewModelDelegates{
 
    func didDeleteSuggestedFriend(response: SuggestedDeleteResponse,friendID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let index = self.suggestedFriends.firstIndex(where: {$0.id == friendID}){
            self.suggestedFriends.remove(at: index)
        }
        DispatchQueue.main.async { [weak self] in
            self?.suggestedFriendTableView.reloadData()
        }
    }
    
    func didDeleteSuggestedFriendResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR RetrievePostsViewModelDelegates -

extension HomeVC: RetrievePostViewModelDelegates{
    
    func didRetrievePosts(response: RetrievePostResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let postList = response.data{
            if !postList.isEmpty{
                self.arrayOfPost.removeAll()
                self.arrayOfPost = postList
            }else{
                self.arrayOfPost.removeAll()
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            if self.suggestedFriends.count > 0 {
                self.seeAllFriendsBtn.isHidden = false
                self.suggestedFriendTableView.isHidden = false
            }else{
                self.seeAllFriendsBtn.isHidden = true
                self.suggestedFriendTableView.isHidden = true
            }
            self.suggestedFriendTableView.reloadData()
            self.homeFeedsPostTableView.reloadData()
        }
    }
    
    func didRetrievePostsResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR RETRIEVE ONE POST VIEWMODEL DELEGATES -

extension HomeVC: RetrieveOnePostViewModelDelegates{
        
    func didRetrieveOnePost(response: RetrieveOnePostResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if isSearching{
            if let index = self.arrayOfSearchPost.firstIndex(where: {$0.id == response.data?.id}){
                if let postViews = response.data?.views{
                    self.arrayOfSearchPost[index].views = postViews
                }else{
                    self.arrayOfSearchPost[index].views = 1
                }
            }
            if let index = self.arrayOfPost.firstIndex(where: {$0.id == response.data?.id}){
                if let postViews = response.data?.views{
                    self.arrayOfPost[index].views = postViews
                }else{
                    self.arrayOfPost[index].views = 1
                }
            }
        }else{
            if let index = self.arrayOfPost.firstIndex(where: {$0.id == response.data?.id}){
                if let postViews = response.data?.views{
                    self.arrayOfPost[index].views = postViews
                }else{
                    self.arrayOfPost[index].views = 1
                }
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.homeFeedsPostTableView.reloadData()
        }
    }
    
    func didRetrieveOnePostResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR LikePostViewModelDelegates -

extension HomeVC: LikePostViewModelDelegates{
    
    func didLikePosts(response: LikePostResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if isSearching{
            if let index = self.arrayOfSearchPost.firstIndex(where: {$0.id == response.data?.id}){
                if let updatedPost = response.data{
                    self.arrayOfSearchPost.remove(at: index)
                    self.arrayOfSearchPost.insert(updatedPost, at: index)
                }
            }
            if let index = self.arrayOfPost.firstIndex(where: {$0.id == response.data?.id}){
                if let updatedPost = response.data{
                    self.arrayOfPost.remove(at: index)
                    self.arrayOfPost.insert(updatedPost, at: index)
                }
            }
        }else{
            if let index = self.arrayOfPost.firstIndex(where: {$0.id == response.data?.id}){
                if let updatedPost = response.data{
                    self.arrayOfPost.remove(at: index)
                    self.arrayOfPost.insert(updatedPost, at: index)
                }
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.homeFeedsPostTableView.reloadData()
        }
    }
    
    func didLikePostsResponseWith(error: String,at index: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if index < arrayOfPost.count{
            if let likeCount = self.arrayOfPost[index].likes,
               likeCount > 0{
                self.arrayOfPost[index].likes = (likeCount - 1)
                DispatchQueue.main.async { [weak self] in
                    self?.homeFeedsPostTableView.reloadData()
                }
            }
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR PostShareViewModelDelegates -

extension HomeVC: PostShareViewModelDelegates{
    
    func didSharePost(response: PostShareResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        DispatchQueue.main.async { [weak self] in
            self?.homeFeedsPostTableView.reloadData()
        }
    }
    
    func didSharePostResponseWith(error: String,at index: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if index < arrayOfPost.count{
            if let shareCount = self.arrayOfPost[index].share,
               shareCount > 0{
                self.arrayOfPost[index].share = (shareCount - 1)
                DispatchQueue.main.async { [weak self] in
                    self?.homeFeedsPostTableView.reloadData()
                }
            }
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR FRIEND REQUEST VC DELEGATES -

extension HomeVC: FriendRequestVCDelegates{
    
    func didDeleteSuggestedFriendOf(id: String) {
        if let index = self.suggestedFriends.firstIndex(where: {$0.id == id}){
            self.suggestedFriends.remove(at: index)
        }
        DispatchQueue.main.async { [weak self] in
            self?.suggestedFriendTableView.reloadData()
        }
    }
    
    func didAddSuggestedFriendOf(id: String) {
        if let index = self.suggestedFriends.firstIndex(where: {$0.id == id}){
            self.suggestedFriends.remove(at: index)
        }
        DispatchQueue.main.async { [weak self] in
            self?.suggestedFriendTableView.reloadData()
        }
    }
    
}

//MARK: - EXTENSION FOR NAVIGATION METHODS -

extension HomeVC{
    
    func navigateToCommentVC(with postID: String,at index: Int){
        guard let commentVC = R.storyboard.homeSB.commentVC() else {return}
        commentVC.postID = postID
        commentVC.index = index
        commentVC.isSearching = isSearching
        commentVC.delegate = self
        self.present(commentVC, animated: true)
    }
    
}

//MARK: - EXTENSION FOR COMMENT VC DELEGATES -

extension HomeVC: CommentVCDelegate{
    
    func didAddNewComment(at index: Int,isSearching: Bool) {
        if isSearching{
            if let comments = self.arrayOfSearchPost[index].comments{
                self.arrayOfSearchPost[index].comments = comments + 1
            }else{
                self.arrayOfSearchPost[index].comments = 1
            }
            if let postID = self.arrayOfSearchPost[index].id{
                if let postIndex = self.arrayOfPost.firstIndex(where: {$0.id == postID}){
                    if let comments = self.arrayOfPost[postIndex].comments{
                        self.arrayOfPost[postIndex].comments = comments + 1
                    }else{
                        self.arrayOfPost[postIndex].comments = 1
                    }
                }
            }
        }else{
            if let comments = self.arrayOfPost[index].comments{
                self.arrayOfPost[index].comments = comments + 1
            }else{
                self.arrayOfPost[index].comments = 1
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.homeFeedsPostTableView.reloadData()
        }
    }
    
}

//MARK: - EXTENSION FOR PHOTO PICKER -

extension HomeVC{
    
    private func selectPhoto(){
        self.createPostBtn.showLoading()
        self.picker.didFinishPicking { [weak self] items, cancelled in
            guard let self = self else {return}
            
            if cancelled {
                self.createPostBtn.hideLoading()
            }
            if let photo = items.singlePhoto{
                DispatchQueue.main.async {
                    self.openCropViewController(with: photo.image)
                }
                /*
                ImageCompressor.compress(image: photo.image, maxByte: 1000000) { imageReceived in
                    self.createPostBtn.hideLoading()
                    if let imageReceived = imageReceived,
                       let imageData = imageReceived.pngData(){
                        if imageData.getSizeInMB() <= Constants.maxFileSize{
                            self.selectedImageData = nil
                            self.selectedImageData = imageData
                            Constants.printLogs("Image Recieved: \(photo.image)")
                        }else{
                            AlertControllers.showAlert(inVC: self, message: GoWildStrings.imageSizeError())
                        }
                    }
                }
                */
                
            }
            self.picker.dismiss(animated: true, completion: nil)
        }
        self.present(self.picker, animated: true)
    }
    
}


//MARK: - EXTENSION FOR CAMERA & LIBRARY PERMISSIONS -

extension HomeVC{
    
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
    
    func showDocuments(){
        self.createPostBtn.showLoading()
        let documentVC = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentVC.delegate = self
        documentVC.allowsMultipleSelection = true
        documentVC.modalPresentationStyle = .formSheet
        self.present(documentVC, animated: true, completion: nil)
    }
    
}

//MARK: - EXTENSION FOR DOCUMENT PICKER DELEGATES -

extension HomeVC: UIDocumentMenuDelegate, UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        self.createPostBtn.hideLoading()
        for url in urls{
            guard let data = NSData(contentsOf: url) else {
                return
            }
            let fileData = data as Data
            if fileData.getSizeInMB() <= Constants.maxFileSize{
                DispatchQueue.main.async { [weak self] in
                    self?.postAttachmentImageView.isHidden = false
                    self?.postAttachmentDeleteBtn.isHidden = false
                    self?.selectedAttachmentData = fileData
                    self?.postPhotoBackView.isHidden = false
                    if self?.selectedImageData == nil{
                        self?.postPhotoImageView.isHidden = true
                        self?.postPhotoDeleteBtn.isHidden = true
                    }
                }
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
        self.createPostBtn.hideLoading()
        self.dismiss(animated: true, completion: nil)
        
    }
}


//MARK: -  EXTENSION FOR POST CELL METHODS -

extension HomeVC{
    
    func getPost(counters: Int?) -> String{
        if let counters = counters{
            if counters > 999{
                let newLikes = (counters / 1000)
                return "\(newLikes)k"
            }else{
                return "\(counters)"
            }
        }else{
            return "0"
        }
    }
    
    func setupPostFriends(likes: Int?,userLikes: Int?,on viewLbl: UILabel){
        if let likes = likes,
        let userLikes = userLikes{
            if likes > 0{
                viewLbl.isHidden = false
                let newLikes = (likes - userLikes)
                if newLikes == 0{
                    viewLbl.text = ""
                }else if newLikes > 8{
                    viewLbl.text = "+8 \(GoWildStrings.likes())"
                }else{
                    viewLbl.text = "+\(newLikes) \(GoWildStrings.likes())"
                }
            }else{
                viewLbl.isHidden = true
            }
        }else{
            viewLbl.isHidden = true
            viewLbl.text = "0 \(GoWildStrings.likes())"
        }
    }
    
    func setupPostLikeImages(userLikes: Int?,userLikesURL: [String]?,imageOne: UIImageView,imageTwo: UIImageView,imageThree: UIImageView,imagesStackView: UIStackView){
        if let userLikes = userLikes,
        let userLikesURL = userLikesURL,
           !userLikesURL.isEmpty{
            if userLikes == 1{
                
                imageOne.isHidden = false
                imageTwo.isHidden = true
                imageThree.isHidden = true
                imagesStackView.isHidden = false
                
                if let imageOneURL = URL(string: "\(UserManager.shared.getBaseURL())\(userLikesURL[0])"){
                    imageOne.kf.indicatorType = .activity
                    imageOne.kf.setImage(with: imageOneURL,placeholder: R.image.ic_user_placeholder_image())
                }
                
            }else if userLikes == 2{
                
                imageOne.isHidden = false
                imageTwo.isHidden = false
                imageThree.isHidden = true
                imagesStackView.isHidden = false
                
                if let imageOneURL = URL(string: "\(UserManager.shared.getBaseURL())\(userLikesURL[0])"){
                    imageOne.kf.indicatorType = .activity
                    imageOne.kf.setImage(with: imageOneURL,placeholder: R.image.ic_user_placeholder_image())
                }
                
                if let imageTwoURL = URL(string: "\(UserManager.shared.getBaseURL())\(userLikesURL[1])"){
                    imageTwo.kf.indicatorType = .activity
                    imageTwo.kf.setImage(with: imageTwoURL,placeholder: R.image.ic_user_placeholder_image())
                }
                
            }else if userLikes == 3{
                
                imageOne.isHidden = false
                imageTwo.isHidden = false
                imageThree.isHidden = false
                imagesStackView.isHidden = false
                
                if let imageOneURL = URL(string: "\(UserManager.shared.getBaseURL())\(userLikesURL[0])"){
                    imageOne.kf.indicatorType = .activity
                    imageOne.kf.setImage(with: imageOneURL,placeholder: R.image.ic_user_placeholder_image())
                }
                
                if let imageTwoURL = URL(string: "\(UserManager.shared.getBaseURL())\(userLikesURL[1])"){
                    imageTwo.kf.indicatorType = .activity
                    imageTwo.kf.setImage(with: imageTwoURL,placeholder: R.image.ic_user_placeholder_image())
                }
                
                if let imageThreeURL = URL(string: "\(UserManager.shared.getBaseURL())\(userLikesURL[2])"){
                    imageThree.kf.indicatorType = .activity
                    imageThree.kf.setImage(with: imageThreeURL,placeholder: R.image.ic_user_placeholder_image())
                }else{
                    
                    imageOne.isHidden = true
                    imageTwo.isHidden = true
                    imageThree.isHidden = true
                    imagesStackView.isHidden = true
                    
                }
                
            }
        }else{
            imageOne.isHidden = true
            imageTwo.isHidden = true
            imageThree.isHidden = true
            imagesStackView.isHidden = true
        }
    }
    
}


//MARK: - EXTENSION FOR SEARCH BAR -

extension HomeVC{
    
    @objc func handleSearchBar(_ searchBarField: UITextField) {
            
            NSObject.cancelPreviousPerformRequests(
                    withTarget: self,
                    selector: #selector(self.getTextFromSearchField),
                    object: searchBarField)
                self.perform(
                    #selector(self.getTextFromSearchField),
                    with: searchBarField,
                    afterDelay: 0.5)
        }
        
        @objc func getTextFromSearchField(textField: UITextField) {
            if let text = textField.text{
                if text.isEmpty{
                    isSearching = false
                    searchField.text = ""
                    self.homeFeedsPostTableView.reloadData()
                }else{
                    isSearching = true
                    arrayOfSearchPost = arrayOfPost.filter({$0.title?.localizedCaseInsensitiveContains(text) ?? false})
                    self.homeFeedsPostTableView.reloadData()
                }
            }else{
                isSearching = false
                searchField.text = ""
                self.homeFeedsPostTableView.reloadData()
            }
        }
    
}


//MARK: - EXTENSION FOR IMAGE CROPER METHODS - {

extension HomeVC: TOCropViewControllerDelegate, UINavigationControllerDelegate{
    
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
        self.createPostBtn.hideLoading()
        cropViewController.dismiss(animated: true)
        AlertControllers.showAlert(inVC: self, message: GoWildStrings.postImagePickCancelError())
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true)
        self.compress(image: image)
        
    }
    
    private func compress(image: UIImage){
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let weakSelf = self else {return}
            ImageCompressor.compress(image: image, maxByte: 1000000) { imageReceived in
                weakSelf.createPostBtn.hideLoading()
                if let imageReceived = imageReceived,
                   let imageData = imageReceived.pngData(){
                    if imageData.getSizeInMB() <= Constants.maxFileSize{
                        weakSelf.selectedImageData = nil
                        weakSelf.selectedImageData = imageData
                        DispatchQueue.main.async {
                            weakSelf.postPhotoImageView.isHidden = false
                            weakSelf.postPhotoDeleteBtn.isHidden = false
                            weakSelf.postPhotoImageView.image = image
                            weakSelf.postPhotoBackView.isHidden = false
                            if weakSelf.selectedAttachmentData == nil{
                                weakSelf.postAttachmentImageView.isHidden = true
                                weakSelf.postAttachmentDeleteBtn.isHidden = true
                            }
                        }
                        Constants.printLogs("Image Recieved: \(image)")
                    }else{
                        AlertControllers.showAlert(inVC: weakSelf, message: GoWildStrings.imageSizeError())
                    }
                }
            }
        }
    }
    
}

//MARK: - EXTENSION FOR CLLOCATION DELEGATES -

extension HomeVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            LocationManager.shared.lat = String(location.coordinate.latitude)
            LocationManager.shared.long = String(location.coordinate.longitude)
        }
    }
    
}

extension HomeVC{
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(didUserUpdateInfo), name: .userUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didMapStyleUpdate), name: .mapStyleChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkDeepLinkURL), name: UIApplication.didBecomeActiveNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(didTapOnPushNotification(_:)), name: .pushReceived, object: nil)
    }
    
    @objc
    private func didUserUpdateInfo(){
        self.retrievePostsViewModel.retrievePosts()
    }
    
    @objc
    func didMapStyleUpdate(){
        DispatchQueue.main.async { [weak self] in
            self?.loadMap = true
        }
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
}

//MARK: - EXTENSION FOR PUSH RECEIVED -

extension HomeVC{
    
    @objc
    private func didTapOnPushNotification(_ notification: NSNotification){
        if let notificationObj = notification.object as? [String: Any]{
            if let type = notificationObj[.pushType] as? String{
                if let pushType = PushTypes(rawValue: type){
                    switch pushType {
                    case .inbox:
                        guard let inboxVC = R.storyboard.messageSB.messagesVC() else {return}
                        self.push(controller: inboxVC, hideBar: true, animated: true)
                    case .gowild:
                        Constants.printLogs("GoWild Notification")
                    case .routes:
                        guard let myTrailsVC = R.storyboard.myTrailsSB.myTrailsVC() else {return}
                        self.push(controller: myTrailsVC, hideBar: true, animated: true)
                    case .support:
                        guard let supportVC = R.storyboard.supportSB.supportVC() else {return}
                        self.push(controller: supportVC, hideBar: true, animated: true)
                    case .treasureChest:
                        guard let treasureChestVC = R.storyboard.mapSB.treasureWildVC() else {return}
                        self.push(controller: treasureChestVC, hideBar: true, animated: true)
                    case .notification:
                        guard let notificationVC = R.storyboard.profileSB.notificationsVC() else {return}
                        self.push(controller: notificationVC, hideBar: true, animated: true)
                    case .approve:
                        guard let myTrailsVC = R.storyboard.myTrailsSB.myTrailsVC() else {return}
                        self.push(controller: myTrailsVC, hideBar: true, animated: true)
                    case .push:
                        guard let notificationVC = R.storyboard.profileSB.notificationsVC() else {return}
                        self.push(controller: notificationVC, hideBar: true, animated: true)
                    }
                }
            }
        }
    }
    
}


//MARK: - DEEP LINK METHODS -

extension HomeVC{
    
    @objc
    func checkDeepLinkURL(){
        if Utils.shared.getDeepLinkState(){
            if let deepLinkObj = Utils.shared.getDeepLinkObj(){
                if let path = deepLinkObj[._path] as? String,
                   let id = deepLinkObj[._id] as? String{
                    if path == ._post{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            guard let postDetailVC = R.storyboard.homeSB.postDetailVC() else {return}
                            postDetailVC.postID = id
                            Utils.shared.setDeepLink(state: false)
                            Utils.shared.setDeepLink(obj: [:])
                            self.push(controller: postDetailVC, hideBar: true, animated: true)
                        }
                    }else if path == ._route{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            guard let routeDetailVC = R.storyboard.runWildSB.routeDetailVC() else {return}
                            routeDetailVC.mode = .deepLink
                            routeDetailVC.routeID = id
                            Utils.shared.setDeepLink(state: false)
                            Utils.shared.setDeepLink(obj: [:])
                            self.push(controller: routeDetailVC, hideBar: true, animated: true)
                        }
                    }
                }
            }
        }
    }
    
}
