//
//  CommentVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher
import IQKeyboardManagerSwift

protocol CommentVCDelegate: AnyObject{
    func didAddNewComment(at index: Int,isSearching: Bool)
}

class CommentVC: UIViewController {

    //MARK: - OUTLETS -
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendBtn: LoadingButton!
    @IBOutlet weak var commentsTableView: UITableView!{
        didSet{
            commentsTableView.delegate = self
            commentsTableView.dataSource = self
            commentsTableView.register(R.nib.commentCell)
        }
    }
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    //MARK: - PROPERTIES -
    
    private var allCommentViewModel = PostAllCommentsViewModel()
    private var addCommentViewModel = PostAddCommentViewModel()
    private var comments : [PostComment] = []
    weak var delegate: CommentVCDelegate?
    var postID : String = ""
    var index : Int = 0
    var isSearching : Bool = false
    
    //MARK: - LIFE CYCLES -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        allCommentViewModel.delegates = self
        addCommentViewModel.delegates = self
        getAllComments()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
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
    
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.comments()
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        messageTextField.textColor = AppColor.appWhiteColor()
        messageTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getAllComments(){
        LoaderView.shared.showSpiner(inVC: self)
        let request = PostAllCommentsRequest(postFeedId: self.postID)
        self.allCommentViewModel.getAllCommentWith(request: request)
    }
    
    //MARK: - ACTIONS -

    @IBAction func didTapCancelBtn(_ sender: UIButton){
        sender.showAnimation {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func didTapSendBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.view.endEditing(true)
            if !self.sendBtn.isAnimating{
                self.sendBtn.showLoading()
                let message = self.messageTextField.text?.removeExtraSpacingFromString() ?? ""
                self.messageTextField.text = message
                let request = PostAddCommentRequest(postFeedId: self.postID, message: message)
                self.addCommentViewModel.addNewCommentWith(request: request)
            }
        }
    }
    
}

//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension CommentVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCommentCell(at: indexPath)
    }
    
}

//MARK: - EXTENSION FOR Cell METHODS -

extension CommentVC{
    
    private func configureCommentCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.commentsTableView.dequeueReusableCell(withIdentifier: .commentCell, for: indexPath) as! CommentCell
        
        let comment = self.comments[indexPath.row]
        cell.nameLbl.text = "\(comment.user?.firstName ?? "") \(comment.user?.lastName ?? "")"
        cell.commentLbl.text = "\(comment.message ?? "")"
        cell.commentView.roundCorners(corners: [.topRight,.bottomLeft,.bottomRight], radius: 15)
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(comment.user?.picture ?? "")"){
            cell.profileImageView.kf.indicatorType = .activity
            cell.profileImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            cell.profileImageView.image = R.image.ic_user_placeholder_image()
        }
        
        return cell
    }
    
}

//MARK: - EXTENSION FOR ALL COMMENTS VIEW MODEL DELEGATES -

extension CommentVC: PostAllCommentsViewModelDelegates{
    
    func didGetAllCommentsOnPost(response: PostAllCommentsResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let comments = response.data{
            if !comments.isEmpty{
                self.comments = comments
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.commentsTableView.scrollToBottomRow()
            self?.commentsTableView.reloadData()
        }
    }
    
    func didGetAllCommentsOnPostResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.sendBtn.isAnimating {self.sendBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.sendBtn.isAnimating {self.sendBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}

//MARK: - EXTENSION FOR ADD COMMENT VIEW MODEL DELEGATES -

extension CommentVC: PostAddCommentViewModelDelegates{
    
    func didAddNewCommentOnPost(response: PostAddCommentResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.sendBtn.hideLoading()
        self.delegate?.didAddNewComment(at: self.index, isSearching: self.isSearching)
        if let message = response.data{
            self.comments.append(message)
        }
        DispatchQueue.main.async { [weak self] in
            self?.messageTextField.text = ""
            self?.commentsTableView.scrollToBottomRow()
            self?.commentsTableView.reloadData()
        }
    }
    
    func didAddNewCommentOnPostResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.sendBtn.hideLoading()
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR KeyboardHandler -

extension CommentVC: KeyboardHandler{
    
    
}
