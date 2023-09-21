//
//  PostDetailVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit

class PostDetailVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var postTableView: UITableView!{
        didSet{
            postTableView.delegate = self
            postTableView.dataSource = self
            postTableView.register(R.nib.homeFriendsPostCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var retrieveOnePostVM = RetrieveOnePostViewModel()
    private var likePostViewModel = LikePostViewModel()
    private var sharePostViewModel = PostShareViewModel()
    var arrayOfPost: [RetrievePostResponseData] = []
    var postID: String = ""
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveOnePostVM.delegates = self
        likePostViewModel.delegates = self
        sharePostViewModel.delegates = self
        getOnePost()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** PostDetailVC Deinit ***")
    }
    

    //MARK: - METHODS -
    
    private func getOnePost(){
        LoaderView.shared.showSpiner(inVC: self)
        self.retrieveOnePostVM.retrieveOnePostWith(postID: self.postID)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - EXTENSION FOR RETRIEVE ONE POST VIEWMODEL DELEGATES -

extension PostDetailVC: RetrieveOnePostViewModelDelegates{
        
    func didRetrieveOnePost(response: RetrieveOnePostResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let post = response.data{
            if arrayOfPost.contains(where: {$0.id == postID}){
                self.arrayOfPost.removeAll()
                self.arrayOfPost.append(post)
            }else{
                self.arrayOfPost.append(post)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.postTableView.reloadData()
        }
    }
    
    func didRetrieveOnePostResponseWith(error: String) {
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

//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension PostDetailVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configurePostCell(indexPath)
    }
    
}

//MARK: - EXTENSION FOR POST CELL -

extension PostDetailVC{
    
    private func configurePostCell(_ indexPath: IndexPath) -> UITableViewCell{
        let cell = postTableView.dequeueReusableCell(withIdentifier: .homeFriendsPostCell, for: indexPath) as! HomeFriendsPostCell
        
        let post = self.arrayOfPost[indexPath.row]
        
        if let user = post.user{
            cell.friendNameLbl.text = ("\(user.firstName ?? "") \(user.lastName ?? "")")
        }else{
            cell.friendNameLbl.text = ("\(GoWildStrings.anonymous())")
        }
        
        if let utcDate = post.createdDate{
            let postDate = Utils.shared.getPostFeedDate(utcDate: utcDate)
            cell.postTimeLbl.text = postDate
        }else{
            cell.postTimeLbl.text = post.createdDate
        }
        cell.postDescriptionLbl.text = post.description
        cell.postLikeCountLbl.text = self.getPost(counters: post.likes)
        cell.postCommentCountLbl.text = self.getPost(counters: post.comments)
        cell.postShareCountLbl.text = self.getPost(counters: post.share)
        cell.postViewCountLbl.text = self.getPost(counters: post.views)
        
        if let attachment = post.attachment,
           !attachment.isEmpty{
            cell.attachmentLbl.isHidden = false
            let attachmentStr = "\(UserManager.shared.getBaseURL())\(attachment[0].attachment ?? "")"
            cell.attachmentLbl.text = attachmentStr
            cell.attachmentLbl.addTapGestureRecognizer {
                if let url = URL(string: attachmentStr){
                    UIApplication.shared.open(url)
                }
            }
        }else{
            cell.attachmentLbl.isHidden = true
        }
        
        setupPostFriends(likes: post.likes, userLikes: post.userLikes?.count, on: cell.friendsLikeLbl)
        setupPostLikeImages(userLikes: post.userLikes?.count, userLikesURL: post.userLikes, imageOne: cell.friendOneImageView, imageTwo: cell.friendTwoImageView, imageThree: cell.friendThreeImageView,imagesStackView: cell.likeImagesStackView)
        
        if let userImage = post.user?.userPhoto{
            if let userImageURL = URL(string: "\(UserManager.shared.getBaseURL())\(userImage)"){
                cell.friendImageView.kf.indicatorType = .activity
                cell.friendImageView.kf.setImage(with: userImageURL, placeholder: R.image.ic_user_placeholder_image())
            }
            if !userImage.isEmpty{
                cell.friendImageView.addTapGestureRecognizer { [weak self] in
                    guard let self = self else {return}
                    let userPicURL = "\(UserManager.shared.getBaseURL())\(userImage)"
                    LightBoxVC.shared.showImage(with: userPicURL,inVC: self)
                }
            }
        }else{
            cell.friendImageView.image = R.image.ic_user_placeholder_image()
        }
        
        if let postImage = post.picture,
           !postImage.isEmpty{
            cell.postImageView.isHidden = false
            cell.imageHeightConstrain.constant = (self.view.frame.width - 64)
            if let postImageURL = URL(string: "\(UserManager.shared.getBaseURL())\(postImage)"){
                cell.postImageView.kf.indicatorType = .activity
                cell.postImageView.kf.setImage(with: postImageURL)
            }
            cell.postImageView.addTapGestureRecognizer { [weak self] in
                guard let self = self else {return}
                let userPicURL = "\(UserManager.shared.getBaseURL())\(postImage)"
                LightBoxVC.shared.showImage(with: userPicURL,inVC: self)
            }
            
        }else{
            cell.postImageView.isHidden = true
        }
        
        cell.postShareImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            guard let postID = post.id else {return}
            if let share = self.arrayOfPost[indexPath.row].share{
                self.arrayOfPost[indexPath.row].share = share + 1
            }else{
                self.arrayOfPost[indexPath.row].share = 1
            }
            self.sharePostViewModel.sharePost(with: postID, at: indexPath.row)
            self.shareActivity(profileLink: "\(postID)")
        }
        
        cell.postCommentImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            guard let postID = post.id else {return}
            self.navigateToCommentVC(with: postID,at: indexPath.row)
        }
        
        cell.postLikeImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            guard let postID = post.id else {return}
            let request = LikePostRequest(postFeedId: postID)
            self.likePostViewModel.likePostsWith(request: request,at: indexPath.row)
        }
        
        cell.postViewImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if let postID = self.arrayOfPost[indexPath.row].id{
                self.retrieveOnePostVM.retrieveOnePostWith(postID: postID)
            }
        }
        
        return cell
    }
    
}


//MARK: - EXTENSION FOR METHODS -

extension PostDetailVC{
    
    func navigateToCommentVC(with postID: String,at index: Int){
        guard let commentVC = R.storyboard.homeSB.commentVC() else {return}
        commentVC.postID = postID
        commentVC.index = index
        commentVC.delegate = self
        self.present(commentVC, animated: true)
    }
    
    private func shareActivity(profileLink: String){
        let completeLink: String = "\(DeepLinks.shared.post)\(profileLink)"
        let shareVC = UIActivityViewController(activityItems: [completeLink], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        shareVC.excludedActivityTypes = [.addToReadingList]
        self.present(shareVC, animated: true, completion: nil)
    
    }
    
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

//MARK: - EXTENSION FOR PostShareViewModelDelegates -

extension PostDetailVC: PostShareViewModelDelegates{
    
    func didSharePost(response: PostShareResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        DispatchQueue.main.async { [weak self] in
            self?.postTableView.reloadData()
        }
    }
    
    func didSharePostResponseWith(error: String,at index: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if index < arrayOfPost.count{
            if let shareCount = self.arrayOfPost[index].share,
               shareCount > 0{
                self.arrayOfPost[index].share = (shareCount - 1)
                DispatchQueue.main.async { [weak self] in
                    self?.postTableView.reloadData()
                }
            }
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR LikePostViewModelDelegates -

extension PostDetailVC: LikePostViewModelDelegates{
    
    func didLikePosts(response: LikePostResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let index = self.arrayOfPost.firstIndex(where: {$0.id == response.data?.id}){
            if let updatedPost = response.data{
                self.arrayOfPost.remove(at: index)
                self.arrayOfPost.insert(updatedPost, at: index)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.postTableView.reloadData()
        }
    }
    
    func didLikePostsResponseWith(error: String,at index: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        if index < arrayOfPost.count{
            if let likeCount = self.arrayOfPost[index].likes,
               likeCount > 0{
                self.arrayOfPost[index].likes = (likeCount - 1)
                DispatchQueue.main.async { [weak self] in
                    self?.postTableView.reloadData()
                }
            }
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}


//MARK: - EXTENSION FOR COMMENT VC DELEGATES -

extension PostDetailVC: CommentVCDelegate{
    
    func didAddNewComment(at index: Int,isSearching: Bool) {
        if let comments = self.arrayOfPost[index].comments{
            self.arrayOfPost[index].comments = comments + 1
        }else{
            self.arrayOfPost[index].comments = 1
        }
        DispatchQueue.main.async { [weak self] in
            self?.postTableView.reloadData()
        }
    }
    
}
