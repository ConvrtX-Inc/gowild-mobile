//
//  FriendRequestVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher

protocol FriendRequestVCDelegates: AnyObject{
    func didDeleteSuggestedFriendOf(id: String)
    func didAddSuggestedFriendOf(id: String)
}

class FriendRequestVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var friendsTableView: UITableView!{
        didSet{
            friendsTableView.delegate = self
            friendsTableView.dataSource = self
            friendsTableView.register(R.nib.homeSuggestedFriendsCell)
            friendsTableView.estimatedSectionHeaderHeight = 44.0
            friendsTableView.sectionHeaderHeight = UITableView.automaticDimension
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var suggestedFriendsViewModel = SuggestedFriendsViewModel()
    private var friendRequestViewModel = FriendRequestViewModel()
    private var acceptRequestViewModel = FriendRequestAcceptViewModel()
    private var deleteFriendViewModel = DeleteFriendViewModel()
    private var sendFriendRequestViewModel = SendFriendRequestViewModel()
    private var deleteSuggestedViewModel = SuggestedDeleteViewModel()
    private var friendsRequest: [SuggestedFriendsResponseData] = []
    private var searchFriendsRequest: [SuggestedFriendsResponseData] = []
    private var suggestedFriends: [SuggestedFriendsResponseData] = []
    private var searchSuggestedFriends: [SuggestedFriendsResponseData] = []
    private var isSearching: Bool = false
    weak var delegate : FriendRequestVCDelegates?
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        suggestedFriendsViewModel.delegates = self
        friendRequestViewModel.delegates = self
        acceptRequestViewModel.delegates = self
        deleteFriendViewModel.delegates = self
        sendFriendRequestViewModel.delegates = self
        deleteSuggestedViewModel.delegates = self
        LoaderView.shared.showSpiner(inVC: self)
        friendRequestViewModel.getAllFriendsRequest()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** FriendRequestVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.friendRequest().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        searchTextField.textColor = AppColor.appWhiteColor()
        searchTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        searchTextField.addTarget(self, action: #selector(handleSearchBar(_:)), for: .editingChanged)
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

}

//MARK: - EXTENSION FOR FRIENDS Request VIEWMODEL DELEGATES -

extension FriendRequestVC: FriendRequestViewModelDelegates{
    
    func didGetFriendsRequest(response: FriendRequestResponse) {
        self.suggestedFriendsViewModel.getSuggestedFriends()
        if let friendsRequest = response.recieved{
            if !friendsRequest.isEmpty{
                for friend in friendsRequest{
                    let newFriend = SuggestedFriendsResponseData(id: friend.id, firstName: friend.firstName, lastName: friend.lastName, fullName: "\(friend.firstName ?? "") \(friend.lastName ?? "")", username: friend.username, email: friend.email, phoneNo: friend.phoneNo, picture: friend.picture, connection: friend.connection)
                    self.friendsRequest.append(newFriend)
                }
            }
        }
    }
    
    func didGetFriendsRequestResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR SUGGESTED FRIENDS VIEWMODEL DELEGATES -

extension FriendRequestVC: SuggestedFriendsViewModelDelegates{
    
    func didGetSuggestedFriends(response: SuggestedFriendsResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let suggestedFriends = response.data{
            if !suggestedFriends.isEmpty{
                for friend in suggestedFriends {
                    let newFriend = SuggestedFriendsResponseData(id: friend.id, firstName: friend.firstName, lastName: friend.lastName, fullName: "\(friend.firstName ?? "") \(friend.lastName ?? "")", username: friend.username, email: friend.email, phoneNo: friend.phoneNo, picture: friend.picture, connection: friend.connection)
                    self.suggestedFriends.append(newFriend)
                }
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.friendsTableView.reloadData()
        }
    }
    
    func didGetSuggestedFriendsResponseWith(error: String) {
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

//MARK: - EXTENSION FOR SendFriendRequestViewModelDelegates -

extension FriendRequestVC: SendFriendRequestViewModelDelegates{
    
    func didSendFriendRequest(response: SendFriendRequestResponse,index: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if isSearching{
            if index < self.searchSuggestedFriends.count{
                if let userID = self.searchSuggestedFriends[index].id{
                    self.delegate?.didAddSuggestedFriendOf(id: userID)
                    if let userIndex = self.suggestedFriends.firstIndex(where: {$0.id == userID}){
                        self.suggestedFriends.remove(at: userIndex)
                    }
                }
                self.searchSuggestedFriends.remove(at: index)
            }
        }else{
            if index < self.suggestedFriends.count{
                self.delegate?.didAddSuggestedFriendOf(id: self.suggestedFriends[index].id ?? "")
                self.suggestedFriends.remove(at: index)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.friendsTableView.reloadData()
        }
    }
    
    func didSendFriendRequestResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR FriendRequestAcceptViewModelDelegates

extension FriendRequestVC: FriendRequestAcceptViewModelDelegates{
    
    func didAcceptFriendRequest(response: FriendRequestAcceptResponse,userID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if isSearching{
            if let index = self.searchFriendsRequest.firstIndex(where: {$0.id == userID}){
                self.searchFriendsRequest.remove(at: index)
            }
            if let index = self.friendsRequest.firstIndex(where: {$0.id == userID}){
                self.friendsRequest.remove(at: index)
            }
        }else{
            if let index = self.friendsRequest.firstIndex(where: {$0.id == userID}){
                self.friendsRequest.remove(at: index)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.friendsTableView.reloadData()
        }
    }
    
    func didAcceptFriendRequestResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR DeleteFriendViewModel DELEGATES -

extension FriendRequestVC: DeleteFriendViewModelDelegates{
    
    func didDeleteFriend(response: DeleteFriendResponse,friendID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if isSearching{
            if let index = self.searchFriendsRequest.firstIndex(where: {$0.connection?.id == friendID}){
                self.searchFriendsRequest.remove(at: index)
            }
            if let index = self.friendsRequest.firstIndex(where: {$0.connection?.id == friendID}){
                self.friendsRequest.remove(at: index)
            }
        }else{
            if let index = self.friendsRequest.firstIndex(where: {$0.connection?.id == friendID}){
                self.friendsRequest.remove(at: index)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.friendsTableView.reloadData()
        }
    }
    
    func didDeleteFriendResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR DELETE SUGGESTED FRIENDS VIEWMODEL DELEGATES -

extension FriendRequestVC: SuggestedDeleteViewModelDelegates{
 
    func didDeleteSuggestedFriend(response: SuggestedDeleteResponse,friendID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.delegate?.didDeleteSuggestedFriendOf(id: friendID)
        if isSearching{
            if let index = self.searchSuggestedFriends.firstIndex(where: {$0.id == friendID}){
                self.searchSuggestedFriends.remove(at: index)
            }
            if let index = self.suggestedFriends.firstIndex(where: {$0.id == friendID}){
                self.suggestedFriends.remove(at: index)
            }
        }else{
            if let index = self.suggestedFriends.firstIndex(where: {$0.id == friendID}){
                self.suggestedFriends.remove(at: index)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.friendsTableView.reloadData()
        }
    }
    
    func didDeleteSuggestedFriendResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension FriendRequestVC: ListViewMethods{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching{
            return self.searchSuggestedFriends.isEmpty ? 1 : 2
        }else{
            return self.suggestedFriends.isEmpty ? 1 : 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if isSearching{
                return self.searchFriendsRequest.count
            }else{
                return self.friendsRequest.count
            }
        case 1:
            if isSearching{
                return self.searchSuggestedFriends.count
            }else{
                return self.suggestedFriends.count
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            if isSearching{
                return configureSearchFriendsRequestCell(at: indexPath)
            }else{
                return configureFriendsRequestCell(at: indexPath)
            }
        case 1:
            if isSearching{
                return configureSearchSuggestedFriendsCell(at: indexPath)
            }else{
                return configureSuggestedFriendsCell(at: indexPath)
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 1:
            return self.friendRequestSectionHeaderView(with: GoWildStrings.suggestedFriend())
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 1:
            return UITableView.automaticDimension
        default:
            return 0.0
        }
        
    }
    
}

//MARK: - EXTENSION FOR Cells METHODS -

extension FriendRequestVC{
    
    private func configureFriendsRequestCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = friendsTableView.dequeueReusableCell(withIdentifier: .homeSuggestedFriendsCell, for: indexPath) as! HomeSuggestedFriendsCell
        cell.backView.backgroundColor = .clear
        
        cell.addFriendBtn.tintColor = AppColor.appWhiteColor()
        cell.addFriendBtn.setImage(R.image.ic_accept_request(), for: .normal)
        cell.removeFriendBtn.tintColor = AppColor.appRedColor()
        cell.removeFriendBtn.setImage(R.image.ic_cancel_request(), for: .normal)
        
        let friend = self.friendsRequest[indexPath.row]
        cell.friendNameLbl.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")"
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(friend.picture ?? "")"){
            cell.friendImageView.kf.indicatorType = .activity
            cell.friendImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            cell.friendImageView.image = R.image.ic_user_placeholder_image()
        }
        
        cell.addFriendBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            cell.addFriendBtn.showAnimation {
                LoaderView.shared.showSpiner(inVC: self)
                let request = FriendRequestAcceptRequest(id: friend.id ?? "")
                self.acceptRequestViewModel.getAllFriendsRequest(request: request, userID: friend.id ?? "")
            }
        }
        cell.removeFriendBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            cell.removeFriendBtn.showAnimation {
                LoaderView.shared.showSpiner(inVC: self)
                self.deleteFriendViewModel.deleteFriendWith(friendID: friend.connection?.id ?? "")
            }
        }
        return cell
    }
    
    //Search Friend Request Cell
    private func configureSearchFriendsRequestCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = friendsTableView.dequeueReusableCell(withIdentifier: .homeSuggestedFriendsCell, for: indexPath) as! HomeSuggestedFriendsCell
        cell.backView.backgroundColor = .clear
        
        cell.addFriendBtn.tintColor = AppColor.appWhiteColor()
        cell.addFriendBtn.setImage(R.image.ic_accept_request(), for: .normal)
        cell.removeFriendBtn.tintColor = AppColor.appRedColor()
        cell.removeFriendBtn.setImage(R.image.ic_cancel_request(), for: .normal)
        
        let friend = self.searchFriendsRequest[indexPath.row]
        cell.friendNameLbl.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")"
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(friend.picture ?? "")"){
            cell.friendImageView.kf.indicatorType = .activity
            cell.friendImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            cell.friendImageView.image = R.image.ic_user_placeholder_image()
        }
        
        cell.addFriendBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            cell.addFriendBtn.showAnimation {
                LoaderView.shared.showSpiner(inVC: self)
                let request = FriendRequestAcceptRequest(id: friend.id ?? "")
                self.acceptRequestViewModel.getAllFriendsRequest(request: request, userID: friend.id ?? "")
            }
        }
        cell.removeFriendBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            cell.removeFriendBtn.showAnimation {
                LoaderView.shared.showSpiner(inVC: self)
                self.deleteFriendViewModel.deleteFriendWith(friendID: friend.connection?.id ?? "")
            }
        }
        return cell
    }
    
    private func configureSuggestedFriendsCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = friendsTableView.dequeueReusableCell(withIdentifier: .homeSuggestedFriendsCell, for: indexPath) as! HomeSuggestedFriendsCell
        
        cell.backView.backgroundColor = .clear
        cell.addFriendBtn.tintColor = .clear
        cell.addFriendBtn.setImage(R.image.ic_add_friend_icon(), for: .normal)
        cell.removeFriendBtn.tintColor = .clear
        cell.removeFriendBtn.setImage(R.image.ic_delete_friend_icon(), for: .normal)
        
        let friend = self.suggestedFriends[indexPath.row]
        cell.friendNameLbl.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")"
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(friend.picture ?? "")"){
            cell.friendImageView.kf.indicatorType = .activity
            cell.friendImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            cell.friendImageView.image = R.image.ic_user_placeholder_image()
        }
        
        cell.addFriendBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            cell.addFriendBtn.showAnimation {
                LoaderView.shared.showSpiner(inVC: self)
                let request = SendFriendRequest(email: friend.email ?? "")
                self.sendFriendRequestViewModel.sendFriendRequestWith(request: request, index: indexPath.row)
            }
        }
        cell.removeFriendBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            cell.removeFriendBtn.showAnimation {
                if let friendID = friend.id{
                    LoaderView.shared.showSpiner(inVC: self)
                    self.deleteSuggestedViewModel.deleteSuggestedFriendOf(id: friendID)
                }
            }
        }
        
        return cell
    }
    
    //Search Suggested Friend Cell
    private func configureSearchSuggestedFriendsCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = friendsTableView.dequeueReusableCell(withIdentifier: .homeSuggestedFriendsCell, for: indexPath) as! HomeSuggestedFriendsCell
        
        cell.backView.backgroundColor = .clear
        cell.addFriendBtn.tintColor = .clear
        cell.addFriendBtn.setImage(R.image.ic_add_friend_icon(), for: .normal)
        cell.removeFriendBtn.tintColor = .clear
        cell.removeFriendBtn.setImage(R.image.ic_delete_friend_icon(), for: .normal)
        
        let friend = self.searchSuggestedFriends[indexPath.row]
        cell.friendNameLbl.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")"
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(friend.picture ?? "")"){
            cell.friendImageView.kf.indicatorType = .activity
            cell.friendImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            cell.friendImageView.image = R.image.ic_user_placeholder_image()
        }
        
        cell.addFriendBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            cell.addFriendBtn.showAnimation {
                LoaderView.shared.showSpiner(inVC: self)
                let request = SendFriendRequest(email: friend.email ?? "")
                self.sendFriendRequestViewModel.sendFriendRequestWith(request: request, index: indexPath.row)
            }
        }
        cell.removeFriendBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            cell.removeFriendBtn.showAnimation {
                if let friendID = friend.id{
                    LoaderView.shared.showSpiner(inVC: self)
                    self.deleteSuggestedViewModel.deleteSuggestedFriendOf(id: friendID)
                }
            }
        }
        
        return cell
    }
    
}

//MARK: - EXTENSION FOR FRIENDS HEADER VIEW -

extension FriendRequestVC{
    
    private func friendRequestSectionHeaderView(with title: String) -> UIView{
        let headerView = UIView()
        let sectionTitle = UILabel(frame: CGRect(x: 25, y: 0, width: (self.friendsTableView.frame.width - 50), height: 40))
        sectionTitle.numberOfLines = 1
        sectionTitle.font = Fonts.getSourceSansProBoldOf(size: 20)
        sectionTitle.textColor = AppColor.appWhiteColor()
        sectionTitle.text = title
        headerView.backgroundColor = R.color.appChatBgColor()
        headerView.addSubview(sectionTitle)
        return headerView
    }
    
}

//MARK: - EXTENSION FOR SEARCH BAR -

extension FriendRequestVC{
    
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
                    searchTextField.text = ""
                    self.friendsTableView.reloadData()
                }else{
                    isSearching = true
                    searchFriendsRequest = friendsRequest.filter({$0.fullName?.localizedCaseInsensitiveContains(text) ?? false})
                    searchSuggestedFriends = suggestedFriends.filter({$0.fullName?.localizedCaseInsensitiveContains(text) ?? false})
                    self.friendsTableView.reloadData()
                }
            }else{
                isSearching = false
                searchTextField.text = ""
                self.friendsTableView.reloadData()
            }
        }
    
}
