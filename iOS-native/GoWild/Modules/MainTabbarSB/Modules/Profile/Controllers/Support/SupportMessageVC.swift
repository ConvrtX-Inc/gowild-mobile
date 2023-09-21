//
//  SupportMessageVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 19/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Kingfisher

class SupportMessageVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var supportTableView: UITableView!{
        didSet{
            supportTableView.delegate = self
            supportTableView.dataSource = self
            supportTableView.register(R.nib.supportMessageCell)
        }
    }
    @IBOutlet weak var messageFieldBackView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    //MARK: - PROPERTIES -
    
    private var ticketMessagesVM = GetTicketMessageViewModel()
    private var sendMessageVM = SendSupportMessageViewModel()
    private var arrayOfMessages : [SupportTicketMessage] = []
    private var currentPage: Int = 0
    private var totalPage: Int = 0
    var ticketID: String = ""
    var status : String = ""
    private let refreshControl = UIRefreshControl()
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        ticketMessagesVM.delegates = self
        sendMessageVM.delegates = self
        getTicketMessages()
        listenNewMessage()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
        sendTicketIDToSocket()
        startObservingKeyboardChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
        stopObservingKeyboardChanges()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** SupportMessageVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.support().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.tintColor = AppColor.appWhiteColor() ?? .white
        supportTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didRefreshControl(_:)), for: .valueChanged)
        self.messageFieldBackView.isHidden = self.status == TicketStatusEnum.completed.rawValue ? true : false
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func sendTicketIDToSocket(){
        SocketHelper.shared.emitTicketIdInSupport(ticketID: self.ticketID)
    }
    
    private func listenNewMessage(){
        SocketHelper.shared.listenSupportMessage { [weak self] msg in
            if let msg = msg{
                self?.arrayOfMessages.append(msg)
                DispatchQueue.main.async {
                    self?.supportTableView.reloadData()
                    self?.supportTableView.scrollToBottomRow()
                }
            }
        }
    }
    
    @objc
    private func didRefreshControl(_ sender: UIRefreshControl){
        if Network.isAvailable{
            if currentPage < totalPage{
                self.getTicketMessages()
            }else{
                self.refreshControl.endRefreshing()
            }
        }else{
            self.refreshControl.endRefreshing()
        }
    }
    
    private func getTicketMessages(){
        if self.currentPage == 0{
            LoaderView.shared.showSpiner(inVC: self)
        }
        self.ticketMessagesVM.getTicketMessages(ticketID: self.ticketID, pageNmb: self.currentPage)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didTapSendBtn(_ sender: UIButton){
        sender.showAnimation {
            self.view.endEditing(true)
            let message = self.messageTextField.text?.removeExtraSpacingFromString() ?? ""
            self.messageTextField.text = message
            if !message.isEmpty{
                if SocketHelper.shared.isConnected() == 1{
                    let request = MsgSendFromUserToSupport(ticketID: self.ticketID, message: message, token: UserManager.shared.getAccessToken(), userID: "")
                    SocketHelper.shared.emitMsgFromUserToSupport(msg: request)
                    self.messageTextField.text = ""
                }else{
                    AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
                }
            }
        }
    }

}

//MARK: - EXTENSION FOR TICKET MESSAGES VIEWMODEL DELEGATES -

extension SupportMessageVC: GetTicketMessageViewModelDelegates{
    
    func didGetTicketMessages(response: GetTicketMessageResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.refreshControl.isRefreshing {self.refreshControl.endRefreshing()}
        if let currentPage = response.currentPage,
           let totalPage = response.totalPage{
            self.currentPage = currentPage
            self.totalPage = totalPage
        }
        if let messagesList = response.data{
            if !messagesList.isEmpty{
                for item in messagesList {
                    if self.currentPage == 1{
                        self.arrayOfMessages.append(item)
                    }else{
                        self.arrayOfMessages.insert(item, at: 0)
                    }
                }
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.supportTableView.reloadData()
            if self?.currentPage == 1{
                self?.supportTableView.scrollToBottomRow()
            }
        }
    }
    
    func didGetTicketMessagesResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.refreshControl.isRefreshing {refreshControl.endRefreshing()}
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.refreshControl.isRefreshing {refreshControl.endRefreshing()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.refreshControl.isRefreshing {refreshControl.endRefreshing()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}

//MARK: - EXTENSION FOR SEND MESSAGE VIEWMODEL DELEGATES -

extension SupportMessageVC: SendSupportMessageViewModelDelegates{
    
    func didGetSendTicketMessage(response: SendSupportMessageResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let message = response.data{
            self.arrayOfMessages.append(message)
        }
        DispatchQueue.main.async { [weak self] in
            self?.messageTextField.text = ""
            self?.supportTableView.reloadData()
        }
    }
    
    func didGetSendTicketMessageResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension SupportMessageVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureSupportMessageCell(at: indexPath)
    }
    
}

//MARK: - EXTESNION FOR CELL METHODS -

extension SupportMessageVC{
    
    private func configureSupportMessageCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.supportTableView.dequeueReusableCell(withIdentifier: .SupportMessageCell, for: indexPath) as! SupportMessageCell
        
        let message = self.arrayOfMessages[indexPath.row]
        cell.delegate = self
        cell.ticketNmbLbl.text = message.ticketID?.prefix(8).description.capitalized
        
        if let role = message.role{
            if role == TicketMessageRole.user.rawValue{
                if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(UserManager.shared.picture ?? "")"){
                    cell.userImageView.kf.indicatorType = .activity
                    cell.userImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
                }
                cell.nameLbl.text = "\(UserManager.shared.getFullName())"
            }else{
                cell.userImageView.image = R.image.ic_logo()
                cell.nameLbl.text = GoWildStrings.goWildAdmin()
            }
        }else{
            cell.userImageView.image = R.image.ic_logo()
            cell.nameLbl.text = GoWildStrings.goWildAdmin()
        }
        
        cell.messageLbl.text = message.message
        
        if let createdData = message.createdDate{
            cell.dateLbl.text = Utils.shared.getSupportTicket(date: createdData)
        }
        
        if indexPath.row == 0{
            cell.ticketStatusLbl.isHidden = false
            if self.status == TicketStatusEnum.completed.rawValue{
                cell.ticketStatusLbl.backgroundColor = AppColor.appTabbarBgColor()
                cell.ticketStatusLbl.text = GoWildStrings.completed()
            }else if self.status == TicketStatusEnum.pending.rawValue{
                cell.ticketStatusLbl.backgroundColor = AppColor.appYellowColor()
                cell.ticketStatusLbl.text = GoWildStrings.pending()
            }else{
                cell.ticketStatusLbl.backgroundColor = AppColor.textDarkGrayColor()
                cell.ticketStatusLbl.text = GoWildStrings.onHold()
            }
        }else{
            cell.ticketStatusLbl.isHidden = true
        }
        
        if let attachments = message.attachment,
           !attachments.isEmpty{
            cell.attachmentsCollectionView.isHidden = false
            cell.arrayOfAttachments = attachments
        }else{
            cell.attachmentsCollectionView.isHidden = true
        }
        
        return cell
    }
    
}

//MARK: - EXTENSION FOR SUPPORT MESSAGE CELL DELEGATES -

extension SupportMessageVC: SupportMessageCellDelegates{
    
    func didTapOnAttachment(of url: String) {
        if url.contains(find: .pdf){
            if let pdfURL = URL(string: url){
                UIApplication.shared.open(pdfURL)
            }
        }else{
            LightBoxVC.shared.showImage(with: url,inVC: self)
        }
    }
    
}

//MARK: - EXTENSION FOR SUPPORT KEYBOARD HANDLER -

extension SupportMessageVC: SupportKeyboardHandler{
    
}
