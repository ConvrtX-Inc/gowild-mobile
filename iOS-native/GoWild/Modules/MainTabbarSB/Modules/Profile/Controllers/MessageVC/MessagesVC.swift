//
//  MessagesVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher

class MessagesVC: UIViewController {

    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messagesTableView: UITableView!{
        didSet{
            messagesTableView.delegate = self
            messagesTableView.dataSource = self
            messagesTableView.register(R.nib.messageCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var inboxVM = InboxViewModel()
    private var messagesList : [InboxList] = []
    private var currentPage : Int = 0
    private var totalPage : Int = 0
    private var isPageRefreshing: Bool = false
    
    //MARK: - LIFE CYCLES -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        inboxVM.delegates = self
        getInboxList()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** InboxVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.messages().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getInboxList(){
        LoaderView.shared.showSpiner(inVC: self)
        self.isPageRefreshing = true
        self.inboxVM.getInboxList(currentPage: self.currentPage)
    }
    
    private func navigateToChatVC(userID: String,userName: String,userPicture: String,roomID: String){
        guard let chatVC = R.storyboard.messageSB.chatVC() else {return}
        chatVC.userID = userID
        chatVC.userName = userName
        chatVC.userPicture = userPicture
        chatVC.roomID = roomID
        self.push(controller: chatVC, hideBar: true, animated: true)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - EXTENSION FOR INBOX VIEWMODEL DELEGATES -

extension MessagesVC: InboxViewModelDelegates{
    
    func didGetInboxList(response: InboxResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        if let inboxList = response.data{
            if !inboxList.isEmpty{
                for list in inboxList {
                    self.messagesList.append(list)
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.messagesTableView.reloadData()
        }
        
    }
    
    func didGetInboxListResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}


//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension MessagesVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureMessageCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let userID = self.messagesList[indexPath.row].userID,
           let firstName = self.messagesList[indexPath.row].firstName,
           let lastName = self.messagesList[indexPath.row].lastName{
            let userPicture = self.messagesList[indexPath.row].picture
            let roomID = self.messagesList[indexPath.row].userID
            self.navigateToChatVC(userID: userID, userName: "\(firstName) \(lastName)", userPicture: userPicture ?? "",roomID: roomID ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isPageRefreshing {return}
        if (indexPath.row == (self.messagesList.count - 1)) && (currentPage < totalPage){
            self.getInboxList()
        }
    }
    
}

//MARK: - EXTENSION FOR MESSAGE CELL -

extension MessagesVC{
    
    private func configureMessageCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.messagesTableView.dequeueReusableCell(withIdentifier: .messageCell, for: indexPath) as! MessageCell
        let user = self.messagesList[indexPath.row]
        cell.nameLbl.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(user.picture ?? "")"){
            cell.profileImageView.kf.indicatorType = .activity
            cell.profileImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }
        return cell
    }
    
}
