//
//  MyRacesVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 03/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit

class MyRacesVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var myRacesCollectionView: UICollectionView!{
        didSet{
            myRacesCollectionView.delegate = self
            myRacesCollectionView.dataSource = self
            myRacesCollectionView.register(R.nib.nearbyAdventureCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var myRacesVM = TreasureHuntViewModel()
    private var arrayOfRaces : [TreasureHuntResponseData] = []
    private var currentPage = 0
    private var totalPage = 0
    private var isPageRefreshing : Bool = false
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        myRacesVM.delegates = self
        getMyRaces()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** MyRacesVC Deinit ***")
    }
    
    //MARK: - METHODS -

    @objc func setText(){
        titleLbl.text = GoWildStrings.myRaces().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getMyRaces(){
        if currentPage == 0{
            LoaderView.shared.showSpiner(inVC: self)
        }
        self.myRacesVM.getTreasureHuntOf(pageNmb: currentPage)
    }
    
    private func navigateToEWavierVC(){
        guard let eWavierVC = R.storyboard.authSB.eWaiverVC() else {return}
        eWavierVC.mode = .treasureHunt
        self.push(controller: eWavierVC, hideBar: true, animated: true)
    }
    
    private func navigateToEventVerifyVC(eventID: String){
        guard let eventVerifyVC = R.storyboard.mapSB.eventVerifyVC() else {return}
        eventVerifyVC.eventID = eventID
        self.push(controller: eventVerifyVC, hideBar: true, animated: true)
    }
    
    private func checkEventIsToday(date: String) -> Bool{
        if let eventDate = Utils.shared.getDateObjFromStringUsingChatGPT(date){
            let currentDate = Date()
            if eventDate <= currentDate{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    private func checkUserIsRegisterOrNot(){
        if !self.arrayOfRaces.isEmpty{
            let lastIndex = (self.arrayOfRaces.count - 1)
            if let currentUserHunt = self.arrayOfRaces[lastIndex].currentUserHunt,
               let treasureHunts = self.arrayOfRaces[lastIndex].treasureHunts,
               !treasureHunts.isEmpty{
                if treasureHunts.contains(where: {$0.id == currentUserHunt.id}){
                    if let index = treasureHunts.firstIndex(where: {$0.id == currentUserHunt.id}){
                        self.arrayOfRaces[lastIndex].treasureHunts?.remove(at: index)
                        self.arrayOfRaces[lastIndex].treasureHunts?.insert(currentUserHunt, at: index)
                    }
                }
            }
        }
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    

}


//MARK: - EXTENSION FOR MyRacesVC VIEWMODEL DELEGATES -

extension MyRacesVC: TreasureHuntViewModelDelegates{
    
    func didGetTreasureHunt(response: TreasureHuntResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        self.currentPage = response.currentPage ?? 0
        self.totalPage = response.totalPage ?? 0
        if let events = response.data{
            if !events.isEmpty{
                for event in events {
                    if let currentUserHunt = event.currentUserHunt{
                        Constants.printLogs("\(currentUserHunt)")
                       self.arrayOfRaces.append(event)
                    }
                }
                
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.myRacesCollectionView.reloadData()
        }
    }
    
    func didGetTreasureHuntResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        DispatchQueue.main.async { [weak self] in
            self?.myRacesCollectionView.reloadData()
        }
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


//MARK: - COLLECTION VIEW METHODS  -

extension MyRacesVC: CollectionViewMethods{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfRaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureMyRacesCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.myRacesCollectionView.frame.width
        let height = self.myRacesCollectionView.frame.height
        return CGSize(width: (width * 0.85), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isPageRefreshing {return}
        if (currentPage < totalPage) && (indexPath.row == (self.arrayOfRaces.count - 1)){
            isPageRefreshing = true
            getMyRaces()
        }
    }
    
}

extension MyRacesVC{
    
    private func configureMyRacesCell(at indexPath: IndexPath) -> UICollectionViewCell{
        let cell = myRacesCollectionView.dequeueReusableCell(withReuseIdentifier: .nearbyAdventureCell, for: indexPath) as! NearbyAdventureCell
        
        cell.registerbtnView.isHidden = false
        cell.companyView.isHidden = false
        cell.ratingView.isHidden = true
        cell.hidePostBtn.isHidden = true
        cell.milesView.isHidden = true
        cell.registerView.isHidden = false
        
        let myRace = self.arrayOfRaces[indexPath.row]
        
        if let huntImageURL = URL(string: "\(UserManager.shared.getBaseURL())\(myRace.picture ?? "")"){
            cell.postImageView.kf.indicatorType = .activity
            cell.postImageView.kf.setImage(with: huntImageURL)
        }
        
        cell.titleLbl.text = myRace.title
        cell.descriptionLbl.text = myRace.description
        cell.arrayOfSponsored = myRace.sponsors ?? []
        cell.arrayOfPeoples = myRace.treasureHunts ?? []
        cell.dateLbl.text = Utils.shared.getTreasureWildFeedDate(utcDate: myRace.eventDate ?? "")
        cell.timeLbl.text = Utils.shared.getTreasureWildFeedTime(utcDate: myRace.eventDate ?? "")
        let leftUsers = ((myRace.nmbOfParticipants ?? 0) - (myRace.treasureHunts?.count ?? 0))
        cell.leftLbl.text = "\(leftUsers)/\(myRace.nmbOfParticipants ?? 0) \(GoWildStrings.left())"
        
        if let currentUserHunt = myRace.currentUserHunt{
            if currentUserHunt.status == TreasureWildRegisterStatus.pending.rawValue{
                cell.registerBtn.setTitle(GoWildStrings.waitingForApproval().capitalized, for: .normal)
                cell.registerBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
                cell.registerBtn.setBackgroundImage(nil, for: .normal)
                cell.registerBtn.addTapGestureRecognizer {
                    cell.registerBtn.showAnimation {
                        Constants.printLogs(GoWildStrings.waitingForApproval())
                    }
                }
            }else{
                cell.registerBtn.setTitle(GoWildStrings.start().capitalized, for: .normal)
                cell.registerBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
                cell.registerBtn.setBackgroundImage(R.image.loginBtnBgImage(), for: .normal)
                cell.registerBtn.addTapGestureRecognizer { [weak self] in
                    guard let self = self else {return}
                    cell.registerBtn.showAnimation {
                        if let eventID = myRace.id{
                            self.navigateToEventVerifyVC(eventID: eventID)
                        }
                    }
                }
            }
        }else{
            cell.registerBtn.setTitle(GoWildStrings.notRegistered().capitalized, for: .normal)
            cell.registerBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
            cell.registerBtn.setBackgroundImage(nil, for: .normal)
            cell.registerBtn.addTapGestureRecognizer {
                cell.registerBtn.showAnimation {
                    Constants.printLogs("\(GoWildStrings.notRegistered())")
                }
            }
        }
        
        
        return cell
    }
    
}
