//
//  ChatVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import IQKeyboardManagerSwift
import Kingfisher
import YPImagePicker

class ChatVC: MessagesViewController{

    //MARK: - OUTLETS -
    
    
    //MARK: - PROPERTIES -
    
    private var messagesVM = MessagesViewModel()
    var sendAttachmentMsgVM = SendAttachmentMsgViewModel()
    private var deleteMessagesVM = DeleteChatViewModel()
    private var currentPage : Int = 0
    private var totalPage : Int = 0
    private var isPageRefreshing: Bool = false
    var roomID : String = ""
    var userID : String = ""
    var userName : String = ""
    var userPicture : String = ""
    
    var currentUser: Sender = Sender(senderId: "01", displayName: "John Doe")
    var otherUser: Sender = Sender(senderId: "02", displayName: "Daisy John")
    var arrayOfMessages: [Message] = [Message]() {
        didSet {
            self.messagesCollectionView.reloadData()
           
        }
    }
    var isMessageSelected: Bool = false
    var messagesFromServer: [String] = [String]()
    
    var headerView: ChatHeaderView = {
        let view = ChatHeaderView()
        return view
    }()
    
    let picker: YPImagePicker = {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 1
        config.screens = [.photo, .library]
        config.showsPhotoFilters = false
        let imgPiker = YPImagePicker(configuration: config)
        return imgPiker
    }()
    
    private(set) lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "")
        control.tintColor = AppColor.appWhiteColor() ?? .white
        control.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
        return control
    }()
    
    //MARK: - LIFE CYCLES -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        self.connectBothUsers()
        getRoomID()
        receiveMessageFromClient()
        receiveMessageFromTriggerApi()
        recieveMessageObj()
        messagesVM.delegates = self
        sendAttachmentMsgVM.delegates = self
        deleteMessagesVM.delegates = self
        getMessages()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
        self.setScrollViewTopHeightToAutomatic()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
        self.setScrollViewTopHeightToNever()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** ChatVC Deinit ***")
    }

    //MARK: - METHODS -
    
    @objc func setText(){
       
    }
    
    func setUI(){
        setupMessageView()
        headerView.titleLabel.text = self.userName
        currentUser = Sender(senderId: "\(String(describing: UserManager.shared.id))", displayName: UserManager.shared.getFullName())
        otherUser = Sender(senderId: "\(self.userID)", displayName: self.userName)
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(self.userPicture)"){
            headerView.userImageView.kf.indicatorType = .activity
            headerView.userImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }
        
        let backButton = UIBarButtonItem(image: R.image.ic_back_icon(), style: .plain, target: self, action: #selector(didTapBackBtn))
        backButton.tintColor = AppColor.appYellowColor()
        navigationItem.rightBarButtonItem?.tintColor = UIColor.appYellowColor
        
        let showMoreButton = UIBarButtonItem(image: R.image.ic_show_more_btn_image(), style: .plain, target: self, action: #selector(didTapShowMoreBtn))
        showMoreButton.tintColor = AppColor.appYellowColor()
        navigationItem.leftBarButtonItem?.tintColor = UIColor.appYellowColor
        
        let userProfileView = UIBarButtonItem(customView: headerView)
        navigationItem.leftBarButtonItems = [backButton, userProfileView]
        navigationItem.rightBarButtonItems = [showMoreButton]
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = AppColor.appChatBgColor()
        didTapOtherUserProfileImageView()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    func getMessages(){
        if self.roomID.isEmpty {return}
        if currentPage == 0{
            LoaderView.shared.showSpiner(inVC: self)
        }
        isPageRefreshing = true
        self.messagesVM.getMessagesOf(roomID: self.roomID, currentPage: self.currentPage)
    }
    
    @objc
    private func loadMoreMessages() {
        self.refreshControl.beginRefreshing()
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else {return}
            if (self.currentPage < self.totalPage) {
                self.getMessages()
            }else{
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    //MARK: - ACTIONS -
    
    @objc
    private func didTapBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapShowMoreBtn(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: GoWildStrings.deleteConversation(), style: .destructive) { [weak self] action in
            guard let self = self else {return}
            if ((!self.userID.isEmpty) && (!self.arrayOfMessages.isEmpty)){
                LoaderView.shared.showSpiner(inVC: self)
                self.deleteMessagesVM.deleteChhatOf(friendID: self.userID)
            }
        }
        
        let cancelAction = UIAlertAction(title: GoWildStrings.cancel(), style: .cancel) { [weak self] action in
            self?.dismiss(animated: true)
        }
        
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true)
    }
    
    @objc
    func didTapCameraBtn(){
        self.checkCameraPermission()
    }
    
    @objc
    func didTapAttachmentBtn(){
        self.showDocuments()
    }
    
    private func didTapOtherUserProfileImageView(){
        self.headerView.userImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if !self.userPicture.isEmpty{
                let userPicURL = "\(UserManager.shared.getBaseURL())\(self.userPicture)"
                LightBoxVC.shared.showImage(with: userPicURL,inVC: self)
            }
        }
    }
    

}


//MARK: - EXTENSION FOR MESSAGES VIEWMODE DELEGATES -

extension ChatVC:  MessagesViewModelDelegates{
    
    func didGetMessages(response: MessagesResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        if self.refreshControl.isRefreshing {self.refreshControl.endRefreshing()}
        if let currentPage = response.currentPage,
           let totalPage = response.totalPage,
           let messages = response.data{
            self.currentPage = currentPage
            self.totalPage = totalPage
            if !messages.isEmpty{
                for message in messages {
                    if !(message.message?.isEmpty ?? false){
                        
                        let messageObj = Message(sender: message.userID == UserManager.shared.id ? self.currentUser : self.otherUser, messageId: message.id ?? "", sentDate: Date(), kind: .text(message.message ?? ""))
                        self.arrayOfMessages.insert(messageObj, at: 0)
                        
                    }else if !(message.attachment?.isEmpty ?? false){
                        if let attachment = message.attachment{
                            
                            if attachment.contains(find: .pdf){
                                let messageObj = Message(sender: message.userID == UserManager.shared.id ? self.currentUser : self.otherUser, messageId: message.id ?? "", sentDate: Date(), kind: .text("\(UserManager.shared.getBaseURL())\(message.attachment ?? "")"))
                                self.arrayOfMessages.insert(messageObj, at: 0)
                                
                            }else{
                                
                                let messageObj = Message(sender: message.userID == UserManager.shared.id ? self.currentUser : self.otherUser, messageId: message.id ?? "", sentDate: Date(), kind: .photo(Media(url: URL(string: "\(UserManager.shared.getBaseURL())\(message.attachment ?? "")"),placeholderImage: R.image.ic_user_placeholder_image() ?? UIImage(), size: self.getPhotoSize())))
                                self.arrayOfMessages.insert(messageObj, at: 0)
                                
                            }
                        }
                    }
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.messagesCollectionView.reloadData()
            if self?.currentPage == 1{
                self?.messagesCollectionView.scrollToLastItem()
            }
        }
    }
    
    func didGetMessagesResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        if self.refreshControl.isRefreshing {self.refreshControl.endRefreshing()}
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        if self.refreshControl.isRefreshing {self.refreshControl.endRefreshing()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        if self.refreshControl.isRefreshing {self.refreshControl.endRefreshing()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
    
}

//MARK: - EXTENSION FOR SEND ATTACHMENT VIEWMODEL DELEGATES -

extension ChatVC: SendAttachmentMsgViewModelDelegates{
    
    func didSendAttachmentMessages(response: SendAttachmentMsgResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        
        if let msgObj = response.data{
            self.sendAttachmentsToSocket(attachment: msgObj)
            if !(msgObj.attachment?.isEmpty ?? false){
                if let attachment = msgObj.attachment{
                    
                    if attachment.contains(find: .pdf){
                        let messageObj = Message(sender: msgObj.userID == UserManager.shared.id ? self.currentUser : self.otherUser, messageId: msgObj.id ?? "", sentDate: Date(), kind: .text("\(UserManager.shared.getBaseURL())\(msgObj.attachment ?? "")"))
                        self.arrayOfMessages.append(messageObj)
                        
                    }else{
                        
                        let messageObj = Message(sender: msgObj.userID == UserManager.shared.id ? self.currentUser : self.otherUser, messageId: msgObj.id ?? "", sentDate: Date(), kind: .photo(Media(url: URL(string: "\(UserManager.shared.getBaseURL())\(msgObj.attachment ?? "")"),placeholderImage: R.image.ic_user_placeholder_image() ?? UIImage(), size: self.getPhotoSize())))
                        self.arrayOfMessages.append(messageObj)
                        
                    }
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.messagesCollectionView.reloadData()
            self?.messagesCollectionView.scrollToLastItem()
        }
        
    }
    
    func didSendAttachmentMessagesResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR DELETE CHAT VIEWMODEL DELEGATES -

extension ChatVC: DeleteChatViewModelDelegates{
    
    func didGetDeleteChat(response: DeleteChatResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.arrayOfMessages.removeAll()
        DispatchQueue.main.async { [weak self] in
            self?.messagesCollectionView.reloadData()
        }
    }
    
    func didGetDeleteChatResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}
