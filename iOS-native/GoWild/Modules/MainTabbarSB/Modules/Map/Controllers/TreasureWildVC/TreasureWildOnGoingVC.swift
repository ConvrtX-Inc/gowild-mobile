//
//  TreasureWildOnGoingVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 21/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class TreasureWildOnGoingVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var adventureCollectionView : UICollectionView!{
        didSet{
            adventureCollectionView.delegate = self
            adventureCollectionView.dataSource = self
            adventureCollectionView.register(R.nib.nearbyAdventureCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var treasureWildVM = TreasureHuntViewModel()
    private var arrayOfEvents : [TreasureHuntResponseData] = []
    private var currentPage = 0
    private var totalPage = 0
    private var isPageRefreshing : Bool = false
    
    //MARK: - LIFE CYCLE -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        treasureWildVM.delegates = self
        getTreasureHunts()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** TreasureWildOnGoingVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        
    }
    
    func setUI(){
        
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getTreasureHunts(){
        if currentPage == 0{
            LoaderView.shared.showSpiner(inVC: self)
        }
        self.treasureWildVM.getTreasureHuntOf(pageNmb: currentPage)
    }
    
    private func navigateToEWavierVC(){
        guard let eWavierVC = R.storyboard.authSB.eWaiverVC() else {return}
        eWavierVC.mode = .treasureHunt
        self.push(controller: eWavierVC, hideBar: true, animated: true)
    }
    
    private func navigateToEventVerifyVC(eventID: String,location: TreasureHuntLocation){
        guard let eventVerifyVC = R.storyboard.mapSB.eventVerifyVC() else {return}
        eventVerifyVC.eventID = eventID
        eventVerifyVC.location = location
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
        /*
        let eventStartAt = Int(Utils.shared.getTreasureWildFeedEventStartDate(utcDate: date).0) ?? 1
        let currentDay = Calendar.current.dateComponents([.day], from: Date()).day ?? 1
        if currentDay == eventStartAt{
            return true
        }else{
            return false
        }
         */
    }
    
    private func checkUserIsRegisterOrNot(){
        if !self.arrayOfEvents.isEmpty{
            let lastIndex = (self.arrayOfEvents.count - 1)
            if let currentUserHunt = self.arrayOfEvents[lastIndex].currentUserHunt,
               let treasureHunts = self.arrayOfEvents[lastIndex].treasureHunts,
               !treasureHunts.isEmpty{
                if treasureHunts.contains(where: {$0.id == currentUserHunt.id}){
                    if let index = treasureHunts.firstIndex(where: {$0.id == currentUserHunt.id}){
                        self.arrayOfEvents[lastIndex].treasureHunts?.remove(at: index)
                        self.arrayOfEvents[lastIndex].treasureHunts?.insert(currentUserHunt, at: index)
                    }
                }
            }
        }
    }

    //MARK: - ACTIONS -
    

}


//MARK: - EXTENSION FOR TREASURE HUNT VIEWMODEL DELEGATES -

extension TreasureWildOnGoingVC: TreasureHuntViewModelDelegates{
    
    func didGetTreasureHunt(response: TreasureHuntResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        self.currentPage = response.currentPage ?? 0
        self.totalPage = response.totalPage ?? 0
        if let events = response.data{
            if !events.isEmpty{
                for event in events {
                    if let status = event.status,
                       let eventDate = event.eventDate{
                        if checkEventIsToday(date: eventDate) && status == TreasureWildCardStatus.pending.rawValue{
                            self.arrayOfEvents.append(event)
//                            self.checkUserIsRegisterOrNot()
                        }
                    }
                }
                
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.adventureCollectionView.reloadData()
        }
    }
    
    func didGetTreasureHuntResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        isPageRefreshing = false
        DispatchQueue.main.async { [weak self] in
            self?.adventureCollectionView.reloadData()
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

extension TreasureWildOnGoingVC: CollectionViewMethods{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureNearbyAdventureCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.adventureCollectionView.frame.width
        let height = self.adventureCollectionView.frame.height
        return CGSize(width: (width * 0.85), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isPageRefreshing {return}
        if (currentPage < totalPage) && (indexPath.row == (self.arrayOfEvents.count - 1)){
            isPageRefreshing = true
            getTreasureHunts()
        }
    }
    
}

extension TreasureWildOnGoingVC{
    
    private func configureNearbyAdventureCell(at indexPath: IndexPath) -> UICollectionViewCell{
        let cell = adventureCollectionView.dequeueReusableCell(withReuseIdentifier: .nearbyAdventureCell, for: indexPath) as! NearbyAdventureCell
        
        cell.registerbtnView.isHidden = false
        cell.companyView.isHidden = false
        cell.ratingView.isHidden = true
        cell.hidePostBtn.isHidden = true
        cell.milesView.isHidden = true
        cell.registerView.isHidden = false
        
        let treasureHunt = self.arrayOfEvents[indexPath.row]
        
        if let huntImageURL = URL(string: "\(UserManager.shared.getBaseURL())\(treasureHunt.picture ?? "")"){
            cell.postImageView.kf.indicatorType = .activity
            cell.postImageView.kf.setImage(with: huntImageURL)
        }
        
        cell.titleLbl.text = treasureHunt.title
        cell.descriptionLbl.text = treasureHunt.description
        cell.arrayOfSponsored = treasureHunt.sponsors ?? []
        cell.arrayOfPeoples = treasureHunt.treasureHunts ?? []
        cell.dateLbl.text = Utils.shared.getTreasureWildFeedDate(utcDate: treasureHunt.eventDate ?? "")
        cell.timeLbl.text = Utils.shared.getTreasureWildFeedTime(utcDate: treasureHunt.eventDate ?? "")
        let leftUsers = ((treasureHunt.nmbOfParticipants ?? 0) - (treasureHunt.treasureHunts?.count ?? 0))
        cell.leftLbl.text = "\(leftUsers)/\(treasureHunt.nmbOfParticipants ?? 0) \(GoWildStrings.left())"
        
        
        if let winnerID = treasureHunt.winnerId,
           !winnerID.isEmpty{
            
            cell.registerBtn.setTitle(GoWildStrings.completed().capitalized, for: .normal)
            cell.registerBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
            cell.registerBtn.setBackgroundImage(nil, for: .normal)
            cell.registerBtn.addTapGestureRecognizer {
                cell.registerBtn.showAnimation {
                    Constants.printLogs("\(GoWildStrings.completed())")
                }
            }
            
        }else{
            
            if let currentUserHunt = treasureHunt.currentUserHunt{
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
                            if let eventID = treasureHunt.id,
                               let location = treasureHunt.location{
                                self.navigateToEventVerifyVC(eventID: eventID,location: location)
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
            
        }
        
        
        return cell
    }
    
}
