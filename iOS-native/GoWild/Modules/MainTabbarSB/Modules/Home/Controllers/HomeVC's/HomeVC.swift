//
//  HomeVC.swift
//  GoWild
//
//  Created by APPLE on 11/14/22.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMaps
import CoreLocation
import YPImagePicker
import Kingfisher
import MapboxMaps
class HomeVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    
    // Section One....
    @IBOutlet weak var routeSectionView: UIView!
    @IBOutlet weak var routeLbl: UILabel!
    @IBOutlet weak var routeSectionBtn: UIButton!{
        didSet{
            routeSectionBtn.setImage(R.image.ic_chevron_right(), for: .normal)
            routeSectionBtn.setImage(R.image.ic_chevron_down(), for: .selected)
        }
    }
    @IBOutlet weak var routeSubSectionView: UIView!
    
    //Section Two....
    @IBOutlet weak var nearbySectionView: UIView!
    @IBOutlet weak var nearbyLbl: UILabel!
    @IBOutlet weak var nearbyCountLbl: PaddingLabel!
    @IBOutlet weak var nearbySectionBtn: UIButton!{
        didSet{
            nearbySectionBtn.setImage(R.image.ic_chevron_right(), for: .normal)
            nearbySectionBtn.setImage(R.image.ic_chevron_down(), for: .selected)
        }
    }
    @IBOutlet weak var nearbySubSectionView: UIView!
    @IBOutlet weak var mapViewContainer: UIView!
//    GMSMapView!{
//        didSet{
//            mapView.delegate = self
//        }
//    } 
    @IBOutlet weak var mapOverlayBtn: UIButton!
    @IBOutlet weak var mapZoomInBtn: UIButton!
    @IBOutlet weak var mapZoomOutBtn: UIButton!
    @IBOutlet weak var historicalSwitch: UISwitch!
    @IBOutlet weak var mapHeaderView: UIView!{
        didSet{
            mapHeaderView.clipsToBounds = true
            mapHeaderView.layer.cornerRadius = 20
            mapHeaderView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    @IBOutlet weak var seeAllRoutesUpBtn: UIButton!
    @IBOutlet weak var suggestedRoutesLbl: UILabel!
    @IBOutlet weak var seeAllRoutesBtn: UIButton!
    @IBOutlet weak var routeTableView: ContentSizedTableView!{
        didSet{
            routeTableView.delegate = self
            routeTableView.dataSource = self
            routeTableView.register(R.nib.homeRouteSubCell)
        }
    }
    
    //Section Three....
    @IBOutlet weak var goWildFeedSectionView: UIView!
    @IBOutlet weak var goWildFeedLbl: UILabel!
    @IBOutlet weak var goWildFeedSectionBtn: UIButton!{
        didSet{
            goWildFeedSectionBtn.setImage(R.image.ic_chevron_right(), for: .normal)
            goWildFeedSectionBtn.setImage(R.image.ic_chevron_down(), for: .selected)
        }
    }
    @IBOutlet weak var goWildFeedSubSectionView: UIView!
    @IBOutlet weak var nearbyAdventureCollectionView: UICollectionView!{
        didSet{
            nearbyAdventureCollectionView.delegate = self
            nearbyAdventureCollectionView.dataSource = self
            nearbyAdventureCollectionView.register(R.nib.nearbyAdventureCell)
        }
    }
    @IBOutlet weak var editPostBtn: UIButton!
    
    @IBOutlet weak var customSegmentView: UIView!
    @IBOutlet weak var myFeedView: UIView!
    @IBOutlet weak var myFeedLbl: UILabel!
    @IBOutlet weak var myFeedBtn: UIButton!
    @IBOutlet weak var myFriendView: UIView!
    @IBOutlet weak var myFriendLbl: UILabel!
    @IBOutlet weak var myFriendBtn: UIButton!
    @IBOutlet weak var createPostBackView: UIView!
    @IBOutlet weak var currentUserImageView: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var postPhotoBackView: UIView!
    @IBOutlet weak var postPhotoImageView: UIImageView!
    @IBOutlet weak var postPhotoDeleteBtn: UIButton!
    @IBOutlet weak var postAttachmentImageView: UIImageView!
    @IBOutlet weak var postAttachmentDeleteBtn: UIButton!
    @IBOutlet weak var createPostBtn: LoadingButton!
    @IBOutlet weak var selectImageBtn: UIButton!
    @IBOutlet weak var selectAttachmentBtn: UIButton!
    @IBOutlet weak var friendsHeaderView: UIView!
    @IBOutlet weak var fullMapView: UIView!
    @IBOutlet weak var seeAllFriendsBtn: UIButton!{
        didSet{
            seeAllFriendsBtn.semanticContentAttribute = .forceRightToLeft
        }
    }
    @IBOutlet weak var suggestedFriendTableView: ContentSizedTableView!{
        didSet{
            suggestedFriendTableView.delegate = self
            suggestedFriendTableView.dataSource = self
            suggestedFriendTableView.register(R.nib.homeSuggestedFriendsCell)
            suggestedFriendTableView.register(R.nib.messageCell)
        }
    }
    @IBOutlet weak var homeFeedsPostTableView: ContentSizedTableView!{
        didSet{
            homeFeedsPostTableView.delegate = self
            homeFeedsPostTableView.dataSource = self
            homeFeedsPostTableView.register(R.nib.homeFriendsPostCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    var retrieveRoutesViewModel = HomeRetrieveRouteViewModel()
    var saveRouteViewModel = SaveRouteViewModel()
    private var nearbyAdventureVM = TreasureHuntViewModel()
    var retrievePostsViewModel = RetrievePostViewModel()
    private var retrieveOnePostViewModel = RetrieveOnePostViewModel()
    private var suggestedFriendsViewModel = SuggestedFriendsViewModel()
    private var myFriendsViewModel = MyFriendsViewModel()
    private var likePostViewModel = LikePostViewModel()
    private var sharePostViewModel = PostShareViewModel()
    private var createPostViewModel = CreatePostViewModel()
    var updatePostImageViewModel = PostUpdatePictureViewModel()
    private var sendFriendRequestViewModel = SendFriendRequestViewModel()
    private var deleteFriendViewModel = DeleteFriendViewModel()
    private var deleteSuggestedViewModel = SuggestedDeleteViewModel()
    
    var arrayOfPost: [RetrievePostResponseData] = []
    var arrayOfNearbyEvents : [TreasureHuntResponseData] = []
    var arrayOfSearchPost: [RetrievePostResponseData] = []
    var arrayOfAdminRoutes : [HomeAdminRouteResponseData] = []
    var arrayOfCurrentRoutes: [HomeAdminRouteResponseData] = []
    var suggestedFriends : [SuggestedFriendsResponseData] = []
    var myFriends : [MyFriendsResponseData] = []
    var isSearching : Bool = false
    var isPageRefreshing : Bool = false
    var currentPage = 0
    var totalPage = 0
    
    ///Routes Properties....
    var currentSelectedRouteIndex : Int = 0{
        didSet{
            self.routeTableView.reloadData()
        }
    }
    var currentRouteListLastIndex : Int = 0
    var currentRouteCellCount : Int = 3
    var routesCurrentPage : Int = 0
    var routesTotalPage : Int = 0
    var routePath : String = ""
    var sourceLatitude : Double = 0.0
    var sourceLongitude : Double = 0.0
    var destinationLatitude : Double = 0.0
    var destinationLongitude : Double = 0.0
    var historicalEvents: [HomeAdminRouteHistoricalLocation] = []
    var mapZoom : Float = 16.0
    var viewAngle: Double = 30.0
    var loadMap : Bool = false{
        didSet{
            if isMapExtended == true {
                self.setMapBox(container: fullMapView)
            } else {
                self.setMapBox(container: mapViewContainer)
            }
        }
    }
    
    let picker: YPImagePicker = {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 1
        config.screens = [.photo, .library]
        config.showsPhotoFilters = false
        let imgPiker = YPImagePicker(configuration: config)
        return imgPiker
    }()
    
    var selectedImageData: Data?
    var selectedAttachmentData: Data?
    var locationManager = CLLocationManager()
    var mapView: MapView!
    var pointAnnotationManager: PointAnnotationManager!
    var polylineAnnotationManager: PolylineAnnotationManager!
    var isMapExtended = false
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        setupGoWildFeed()
        startUpdatingLocation()
//        initMapView()
        retrieveRoutesViewModel.delegates = self
        saveRouteViewModel.delegates = self
        nearbyAdventureVM.delegates = self
        retrievePostsViewModel.delegates = self
        retrieveOnePostViewModel.delegates = self
        suggestedFriendsViewModel.delegates = self
        likePostViewModel.delegates = self
        sharePostViewModel.delegates = self
        createPostViewModel.delegates = self
        updatePostImageViewModel.delegates = self
        myFriendsViewModel.delegates = self
        sendFriendRequestViewModel.delegates = self
        deleteFriendViewModel.delegates = self
        deleteSuggestedViewModel.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProfileImage()
        self.checkDeepLinkURL()
        LoaderView.shared.hideLoader(fromVC: self)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        self.removeObservers()
        stopUpdatingLocation()
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = Constants.userNameWithGreetings()
        routeLbl.text = GoWildStrings.routes().capitalized
        nearbyLbl.text = GoWildStrings.nearbyAdventures().capitalized
        goWildFeedLbl.text = GoWildStrings.goWildFeed().capitalized
        suggestedRoutesLbl.text = GoWildStrings.suggestedRoutes()
        myFeedLbl.text = GoWildStrings.myFeed()
        myFriendLbl.text = GoWildStrings.myFriends()
        createPostBtn.setTitle(GoWildStrings.post(), for: .normal)
        searchField.addTarget(self, action: #selector(handleSearchBar(_:)), for: .editingChanged)
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 22)
        titleLbl.textColor = AppColor.appWhiteColor()
        searchField.textColor = AppColor.appWhiteColor()
        searchField.font = Fonts.getSourceSansProRegularOf(size: 14)
        didTapSettingImageView()
        routeLbl.font = Fonts.getForegenRoughOneFontOf(size: 14)
        routeLbl.textColor = AppColor.appWhiteColor()
        nearbyLbl.font = Fonts.getForegenRoughOneFontOf(size: 14)
        nearbyLbl.textColor = AppColor.appWhiteColor()
        nearbyCountLbl.font = Fonts.getForegenRoughOneFontOf(size: 14)
        nearbyCountLbl.textColor = AppColor.appWhiteColor()
        nearbyCountLbl.backgroundColor = AppColor.appTabbarBgColor()
        nearbyCountLbl.layer.cornerRadius = nearbyCountLbl.frame.height / 1.9
        nearbyCountLbl.isHidden = true
        goWildFeedLbl.font = Fonts.getForegenRoughOneFontOf(size: 14)
        goWildFeedLbl.textColor = AppColor.appWhiteColor()
        suggestedRoutesLbl.textColor = AppColor.bgBlackColor()
        myFeedBtnSelected()
        postTextView.font = Fonts.getSourceSansProRegularOf(size: 14)
        postTextView.delegate = self
        postTextView.text = GoWildStrings.newPostTextViewPlaceholder()
        postTextView.textColor = AppColor.appWhiteColor()
        mapOverlayBtn.isHidden = true
        seeAllFriendsBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 14)
        seeAllFriendsBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        seeAllFriendsBtn.titleLabel?.text = GoWildStrings.seeAll()
        seeAllFriendsBtn.underline()
        createPostBtn.titleLabel?.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
        createPostBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        createPostBtn.backgroundColor = AppColor.textLightOrangeColor()
        didTapUserProfile()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
        self.addObservers()
    }
    
    private func startUpdatingLocation(){
        if !LocationManager.shared.userDeniedLocation{
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private func stopUpdatingLocation(){
        locationManager.stopUpdatingLocation()
    }
    
    private func updateProfileImage(){
        titleLbl.text = Constants.userNameWithGreetings()
        if let profileURL = URL(string: "\(UserManager.shared.getBaseURL())\(UserManager.shared.picture ?? "")"){
            self.userImageView.kf.indicatorType = .activity
            self.userImageView.kf.setImage(with: profileURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            self.userImageView.image = R.image.ic_user_placeholder_image()
        }
        if let profileURL = URL(string: "\(UserManager.shared.getBaseURL())\(UserManager.shared.picture ?? "")"){
            self.currentUserImageView.kf.indicatorType = .activity
            self.currentUserImageView.kf.setImage(with: profileURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            self.currentUserImageView.image = R.image.ic_user_placeholder_image()
        }
    }
    
    private func setupGoWildFeed(){
        self.routeSubSectionView.isHidden = true
        self.routeSectionBtn.isSelected = false
        self.nearbySubSectionView.isHidden = true
        self.nearbySectionBtn.isSelected = false
        self.goWildFeedSubSectionView.isHidden = true
        self.goWildFeedSectionBtn.isSelected = false
        self.postPhotoBackView.isHidden = true
//        LoaderView.shared.showSpiner(inVC: self)
//        DispatchQueue.global(qos: .background).async { [weak self] in
//            guard let self = self else {return}
//            self.suggestedFriendsViewModel.getSuggestedFriends()
//        }
    }
    
    func getTreasureHunts(){
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {return}
            self.nearbyAdventureVM.getTreasureHuntOf(pageNmb: self.currentPage)
        }
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

    private func didTapSettingImageView(){
        userImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            guard let settingVC = R.storyboard.profileSB.settingVC() else {return}
            self.push(controller: settingVC, hideBar: true, animated: true)
        }
    }
    
    private func didTapUserProfile(){
        self.currentUserImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if let userProfile = UserManager.shared.picture,
               !userProfile.isEmpty{
                let userPicURL = "\(UserManager.shared.getBaseURL())\(userProfile)"
                LightBoxVC.shared.showImage(with: userPicURL,inVC: self)
            }
        }
    }
    func didTapMap() {
        if mapView != nil {
            if isMapExtended == false {
                self.mapView.addTapGestureRecognizer { [weak self] in
                    guard let self = self else {return}
                    self.isMapExtended = true
                    if self.isMapExtended {
                        Constants.printLogs("Full Map: ****")
                        self.mapView = nil
                        self.setMapBox(container: self.fullMapView)
                        self.fullMapView.cornerRadius = 24
                        self.mapViewContainer.showAnimation {
                            self.fullMapView.isHidden = false
                            self.bgView.alpha = 0.2
                        }
                    }
                    
                }
            }else {
                self.routeSectionView.isUserInteractionEnabled = false
                self.bgView.addTapGestureRecognizer { [weak self] in
                    guard let self = self else {return}
                    self.isMapExtended = false
                    self.fullMapView.showAnimation {
                        self.mapView = nil
                        Constants.printLogs("Original Map: ****")
                        self.bgView.alpha = 1
                        self.fullMapView.isHidden = true
                        self.routeSectionView.isUserInteractionEnabled = true
                        self.bgView.gestureRecognizers?.forEach { recognizer in
                            self.bgView.removeGestureRecognizer(recognizer)
                        }
                        self.bgView.willRemoveSubview(self.fullMapView)
                    }
                }
            }
        }
    }
    
    
    @IBAction func didTapRouteSectionBtn(_ sender: UIButton) {
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            if LocationManager.shared.userDeniedLocation{
                self.showLocationPopup(inVC: self) {
                    self.openAppSettings()
                } cancel: {
                    self.dismiss(animated: true)
                }
            }else{
                self.setRouteSection()
            }
        }
    }
    
    
    
    @IBAction func didTapMapOverlayBtn(_ sender: UIButton) {
        sender.showAnimation {
            guard let mapOverlayVC = R.storyboard.homeSB.mapOverlayVC() else {return}
            self.push(controller: mapOverlayVC, hideBar: true, animated: true)
        }
    }
    
    
    @IBAction func didTapZoomInBtn(_ sender: UIButton) {
        sender.showAnimation {
            if self.mapZoom < 21.0{
                self.mapZoom += 1
                self.mapView.mapboxMap.onEvery(event: .cameraChanged) { [weak self] _ in
                    guard let self = self else {return}
                    self.mapZoom = Float(self.mapView.cameraState.zoom)
            }
                // Declare an animator that changes the map's zoom level.
                let zoomAnimator = self.mapView.camera.makeAnimator(duration: 0.5, curve: .easeIn) { [weak self] (transition) in
                    transition.zoom.toValue = CGFloat(self?.mapZoom ?? 4)
                }
                zoomAnimator.startAnimation()
            }
        }
    }
    
    
    @IBAction func didTapZoomOutBtn(_ sender: UIButton) {
        sender.showAnimation {
            if self.mapZoom > 2.0{
                self.mapZoom -= 1
                self.mapView.mapboxMap.onEvery(event: .cameraChanged) { [weak self] _ in
                    guard let self = self else {return}
                    self.mapZoom = Float(self.mapView.cameraState.zoom)
            }
                // Declare an animator that changes the map's zoom level.
                let zoomAnimator = self.mapView.camera.makeAnimator(duration: 0.5, curve: .easeOut) { [weak self] (transition) in
                    transition.zoom.toValue = CGFloat(self?.mapZoom ?? 4)
                }
                zoomAnimator.startAnimation()
//                self.mapView.animate(toZoom: self.mapZoom)
            }
        }
    }
    
    @IBAction func didTapHistoricalSwitch(_ sender: UISwitch) {
        self.loadMap = true
    }
    
    @IBAction func didTapSeeAllRoutesUpBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.didGetPreviousAdminRoutes()
        }
    }
    
    
    @IBAction func didTapSeeAllRoutesBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.didGetNewAdminRoutes()
        }
    }
    
    
    @IBAction func didTapNearbySectionBtn(_ sender: UIButton){
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            self.setNearbyAdventureSection()
        }
    }
    
    @IBAction func didTapGoWildFeedSectionBtn(_ sender: UIButton){
        sender.showAnimation {
            if !self.goWildFeedSectionBtn.isSelected {
                LoaderView.shared.showSpiner(inVC: self)
                if self.myFeedBtn.isSelected{
                    self.suggestedFriendsViewModel.getSuggestedFriends()
                }else{
                    self.myFriendsViewModel.getAllMyFriends()
                }
            }
            self.goWildFeedSectionBtn.isSelected = !self.goWildFeedSectionBtn.isSelected
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else {return}
                self.goWildFeedSubSectionView.isHidden = !self.goWildFeedSubSectionView.isHidden
            }
        }
    }
    
    @IBAction func didTapCustomSegmentBtn(_ sender: UIButton) {
        if sender.tag == 0{
            self.myFeedBtnSelected()
        }else{
            self.myFriendsBtnSelected()
        }
    }
    
    @IBAction func didTapSelectedImagesBtn(_ sender: UIButton) {
        sender.showAnimation {
            if !self.createPostBtn.isAnimating{
                self.checkCameraPermission()
            }
        }
    }
    
    @IBAction func didTapAttachmentBtn(_ sender: UIButton) {
        sender.showAnimation {
            if !self.createPostBtn.isAnimating{
                self.showDocuments()
            }
        }
    }
    
    @IBAction func didTapPostPhotoDeleteBtn(_ sender: UIButton) {
        sender.showAnimation { [weak self] in
            guard let weakSelf = self else {return}
            weakSelf.selectedImageData = nil
            weakSelf.postPhotoImageView.image = nil
            DispatchQueue.main.async {
                weakSelf.postPhotoImageView.isHidden = true
                weakSelf.postPhotoDeleteBtn.isHidden = true
                if weakSelf.selectedAttachmentData == nil{
                    weakSelf.postPhotoBackView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func didTapPostAttachmentDeleteBtn(_ sender: UIButton){
        sender.showAnimation { [weak self] in
            guard let weakSelf = self else {return}
            weakSelf.selectedAttachmentData = nil
            weakSelf.postAttachmentImageView.image = nil
            DispatchQueue.main.async {
                weakSelf.postAttachmentImageView.isHidden = true
                weakSelf.postAttachmentDeleteBtn.isHidden = true
                if weakSelf.selectedImageData == nil{
                    weakSelf.postPhotoBackView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func didTapSeeAllFriendsBtn(_ sender: UIButton) {
        sender.showAnimation {
            if self.myFeedBtn.isSelected{
                guard let friendRequestVC = R.storyboard.homeSB.friendRequestVC() else {return}
                friendRequestVC.delegate = self
                self.push(controller: friendRequestVC, hideBar: true, animated: true)
            }
            /*
            else{
                guard let messagesVC = R.storyboard.profileSB.messagesVC() else {return}
                self.push(controller: messagesVC, hideBar: true, animated: true)
            }
             */
        }
    }
    
    
    @IBAction func didTapCreateNewPostBtn(_ sender: UIButton) {
        sender.showAnimation {
            if !self.createPostBtn.isAnimating{
                self.createPostBtn.showLoading()
                let title = "\(UserManager.shared.firstName ?? "") \(UserManager.shared.lastName ?? "")"
                let request = CreatePostRequest(title: title, description: self.postTextView.text, isPublished: true)
                self.createPostViewModel.createNewPostWith(request: request)
            }
        }
    }
    
    
    @IBAction func didTapEditPostBtn(_ sender: UIButton) {
        sender.showAnimation {
            
        }
    }
    

}


//MARK: - LIST VIEW METHODS -

extension HomeVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case routeTableView:
            return arrayOfCurrentRoutes.count
        case suggestedFriendTableView:
            if myFeedBtn.isSelected{
                if self.suggestedFriends.count > 2{
                    return 2
                }else{
                    return self.suggestedFriends.count
                }
            }else{
                return self.myFriends.count
            }
//            return self.myFeedBtn.isSelected == true ? self.suggestedFriends.count : 7
        case homeFeedsPostTableView:
            if isSearching{
                return arrayOfSearchPost.count
            }else{
                return arrayOfPost.count
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView{
        case routeTableView:
            return configureHomeRouteCell(at: indexPath)
        case suggestedFriendTableView:
            return self.myFeedBtn.isSelected ? configureFriendSuggestedCell(at: indexPath) : configureFriendsCell(at: indexPath)
        case homeFeedsPostTableView:
            if isSearching{
                return configureHomeFeedsSearchPostCell(at: indexPath)
            }else{
                return configureHomeFeedsPostCell(at: indexPath)
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.suggestedFriendTableView{
            if !self.myFeedBtn.isSelected{
                if let userID = self.myFriends[indexPath.row].user?.id,
                   let firstName = self.myFriends[indexPath.row].user?.firstName,
                   let lastName = self.myFriends[indexPath.row].user?.lastName{
                    let userPicture = self.myFriends[indexPath.row].user?.picture
                    let roomID = self.myFriends[indexPath.row].fromUserID == UserManager.shared.id ? self.myFriends[indexPath.row].toUserID : self.myFriends[indexPath.row].fromUserID
                    self.navigateToChatVC(userID: userID, userName: "\(firstName) \(lastName)", userPicture: userPicture ?? "",roomID: roomID ?? "")
                }
            }
        }else if tableView == self.routeTableView{
            if self.currentSelectedRouteIndex == indexPath.row {return}
            self.currentSelectedRouteIndex = indexPath.row
            self.createMapRoutesAt(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == self.suggestedFriendTableView && self.myFriendBtn.isSelected{
            
            let deleteAction = UIContextualAction(style: .normal, title: "") { action, view, completion  in
                if indexPath.row < self.myFriends.count{
                    if let friendID = self.myFriends[indexPath.row].id{
                        LoaderView.shared.showSpiner(inVC: self)
                        self.deleteFriendViewModel.deleteFriendWith(friendID: friendID)
                    }
                }
                completion(true)
            }
            
            deleteAction.backgroundColor = R.color.appRedColor()
            deleteAction.image = R.image.ic_delete_icon()
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }else{
            return nil
        }
    }
    
}

//MARK: - HOME FRIEND SUGGESTED CELL -

extension HomeVC{
    
    private func configureFriendSuggestedCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = suggestedFriendTableView.dequeueReusableCell(withIdentifier: .homeSuggestedFriendsCell, for: indexPath) as! HomeSuggestedFriendsCell
        
        cell.backView.backgroundColor = self.myFeedBtn.isSelected == true ? AppColor.bgBlackColor() : AppColor.appLightGreenBgColor()
        
        let friend = self.suggestedFriends[indexPath.row]
        cell.friendNameLbl.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")"
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(friend.picture ?? "")"){
            cell.friendImageView.kf.indicatorType = .activity
            cell.friendImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            cell.friendImageView.image = R.image.ic_user_placeholder_image()
        }
        
        cell.friendImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if let friendsImage = friend.picture,
               !friendsImage.isEmpty{
                let userPicURL = "\(UserManager.shared.getBaseURL())\(friendsImage)"
                LightBoxVC.shared.showImage(with: userPicURL,inVC: self)
            }
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
    
    private func configureFriendsCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.suggestedFriendTableView.dequeueReusableCell(withIdentifier: .messageCell, for: indexPath) as! MessageCell
        
        let friend = self.myFriends[indexPath.row].user
        cell.nameLbl.text = "\(friend?.firstName ?? "") \(friend?.lastName ?? "")"
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(friend?.picture ?? "")"){
            cell.profileImageView.kf.indicatorType = .activity
            cell.profileImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }else{
            cell.profileImageView.image = R.image.ic_user_placeholder_image()
        }
        
        cell.profileImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if let friendsImage = friend?.picture,
               !friendsImage.isEmpty{
                let userPicURL = "\(UserManager.shared.getBaseURL())\(friendsImage)"
                LightBoxVC.shared.showImage(with: userPicURL,inVC: self)
            }
        }
        
        return cell
    }
    
}

//MARK: - HOME FEEDS POST CELL -

extension HomeVC{
    
    private func configureHomeFeedsPostCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = homeFeedsPostTableView.dequeueReusableCell(withIdentifier: .homeFriendsPostCell, for: indexPath) as! HomeFriendsPostCell
        
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
                self.retrieveOnePostViewModel.retrieveOnePostWith(postID: postID)
            }
        }
        
        return cell
    }
    
    //Search Post Cell
    private func configureHomeFeedsSearchPostCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = homeFeedsPostTableView.dequeueReusableCell(withIdentifier: .homeFriendsPostCell, for: indexPath) as! HomeFriendsPostCell
        
        let post = self.arrayOfSearchPost[indexPath.row]
        
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
            if let postIndex = self.arrayOfPost.firstIndex(where: {$0.id == postID}){
                if let share = self.arrayOfPost[postIndex].share{
                    self.arrayOfPost[postIndex].share = share + 1
                }else{
                    self.arrayOfPost[postIndex].share = 1
                }
            }
            if let share = self.arrayOfSearchPost[indexPath.row].share{
                self.arrayOfSearchPost[indexPath.row].share = share + 1
            }else{
                self.arrayOfSearchPost[indexPath.row].share = 1
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
            if let postID = self.arrayOfSearchPost[indexPath.row].id{
                self.retrieveOnePostViewModel.retrieveOnePostWith(postID: postID)
            }
        }
        
        return cell
    }
    
}


//MARK: - SECTION TWO METHODS -

extension HomeVC: CollectionViewMethods{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfNearbyEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureNearbyAdventureCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.nearbyAdventureCollectionView.frame.width
        let height = self.nearbyAdventureCollectionView.frame.height
        return CGSize(width: (width * 0.80), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isPageRefreshing {return}
        if (currentPage < totalPage) && (indexPath.row == (self.arrayOfNearbyEvents.count - 1)){
            isPageRefreshing = true
            getTreasureHunts()
        }
    }
    
}


//MARK: - EXTENSION FOR CUSTOM SEGMENT BUTTONS -

extension HomeVC{
    
    private func myFeedBtnSelected(){
        self.myFeedBtn.isSelected = true
        self.myFriendBtn.isSelected = false
        myFeedView.backgroundColor = AppColor.textLightOrangeColor()
        myFeedLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        myFeedLbl.textColor = AppColor.appWhiteColor()
        myFriendView.backgroundColor = AppColor.appOrangeBgColor()
        myFriendLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        myFriendLbl.textColor = AppColor.textLightOrangeColor()
        createPostBackView.isHidden = false
        self.suggestedFriendTableView.isHidden = false
        self.homeFeedsPostTableView.isHidden = false
        DispatchQueue.main.async { [weak self] in
            if self?.suggestedFriends.count ?? 0 > 0{
                self?.seeAllFriendsBtn.isHidden = false
            }else{
                self?.seeAllFriendsBtn.isHidden = true
            }
            self?.friendsHeaderView.backgroundColor = AppColor.bgBlackColor()
            self?.suggestedFriendTableView.backgroundColor = AppColor.bgBlackColor()
            self?.suggestedFriendTableView.reloadData()
        }
    }
    
    private func myFriendsBtnSelected(){
        self.myFeedBtn.isSelected = false
        self.myFriendBtn.isSelected = true
        myFeedView.backgroundColor = AppColor.appOrangeBgColor()
        myFeedLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        myFeedLbl.textColor = AppColor.textLightOrangeColor()
        myFriendView.backgroundColor = AppColor.textLightOrangeColor()
        myFriendLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        myFriendLbl.textColor = AppColor.appWhiteColor()
        createPostBackView.isHidden = true
        self.suggestedFriendTableView.isHidden = false
        self.homeFeedsPostTableView.isHidden = true
        DispatchQueue.main.async { [weak self] in
            self?.seeAllFriendsBtn.isHidden = true
            self?.friendsHeaderView.backgroundColor = AppColor.appChatBgColor()
            self?.suggestedFriendTableView.backgroundColor = AppColor.appChatBgColor()
            self?.suggestedFriendTableView.reloadData()
        }
        LoaderView.shared.showSpiner(inVC: self)
        self.myFriendsViewModel.getAllMyFriends()
    }
    
    private func shareActivity(profileLink: String){
        let completeLink: String = "\(DeepLinks.shared.post)\(profileLink)"
        let shareVC = UIActivityViewController(activityItems: [completeLink], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        shareVC.excludedActivityTypes = [.addToReadingList]
        self.present(shareVC, animated: true, completion: nil)
    
    }
    
}


//MARK: - EXTENSION FOR TEXTVIEW DELEGATES -

extension HomeVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if postTextView.text == GoWildStrings.newPostTextViewPlaceholder() {
            postTextView.text = ""
            postTextView.textColor = AppColor.appWhiteColor()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if postTextView.text.isEmpty{
            postTextView.text = GoWildStrings.newPostTextViewPlaceholder()
            postTextView.textColor = AppColor.appWhiteColor()
        }
    }
    
}
