//
//  MyTrailsSavedRouteVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit

class MyTrailsSavedRouteVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var routeTableView: UITableView!{
        didSet{
            routeTableView.delegate = self
            routeTableView.dataSource = self
            routeTableView.register(R.nib.trailSavedRouteCell)
        }
    }
    
    
    //MARK: - PROPERTIES -
    
    private var savedRouteListVM = MyTrailsSavedRouteViewModel()
    private var saveRouteVM = SaveRouteViewModel()
    private var arrayOfSavedRoutes : [MyTrailsSavedRouteListData] = []
    private var currentPage: Int = 0
    private var totalPage: Int = 0
    
    //MARK: - LIFE CYCLE -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        savedRouteListVM.delegates = self
        saveRouteVM.delegates = self
        getSavedRoutes()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** MyTrailsSavedRouteVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        
    }
    
    func setUI(){
        
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getSavedRoutes(){
        if currentPage == 0{
            LoaderView.shared.showSpiner(inVC: self)
        }
        self.savedRouteListVM.getMyTrailsSavedRoutesOf(pageNmb: self.currentPage)
    }
    
    private func navigateToTryRouteVC(route: HomeAdminRouteResponseData){
        guard let tryRouteVC = R.storyboard.tryRouteSB.tryRouteVC() else {return}
        tryRouteVC.route = route
        self.push(controller: tryRouteVC, hideBar: true, animated: true)
    }
    
    private func navigateToRouteDetailVC(route: HomeAdminRouteResponseData){
        guard let routeDetailVC = R.storyboard.runWildSB.routeDetailVC() else {return}
        routeDetailVC.route = route
        self.push(controller: routeDetailVC, hideBar: true, animated: true)
    }
    
    private func getLeaderboardList(route: MyTrailsSavedRouteListData) -> [SaveRoutesLeaderboardData]{
        if let leaderboard = route.leaderboard,
           !leaderboard.isEmpty{
            var leaderboardList = leaderboard
            if let currentUserLeaderboard = route.currentUserLeaderboard,
               let userRank = currentUserLeaderboard.rank{
                
                if !leaderboardList.contains(where: {$0.id == currentUserLeaderboard.id}){
                    switch userRank{
                    case 1:
                        leaderboardList.insert(currentUserLeaderboard, at: 0)
                    case 2:
                        leaderboardList.insert(currentUserLeaderboard, at: 1)
                    case 3:
                        leaderboardList.insert(currentUserLeaderboard, at: 2)
                    default:
                        leaderboardList.append(currentUserLeaderboard)
                    }
                    return leaderboardList
                }else{
                    return leaderboardList
                }
                    
            }else{
                let currentUserLeaderboard = SaveRoutesLeaderboardData(id: UUID().uuidString, image: UserManager.shared.picture, name: UserManager.shared.firstName, userID: UserManager.shared.id, rank: 0)
                leaderboardList.append(currentUserLeaderboard)
                return leaderboardList
            }
        }else{
            return []
        }
    }
    
    //MARK: - ACTIONNS -

    

}

//MARK: - EXTENSION FOR SAVED ROUTES VIEWMODEL DELEGATES -

extension MyTrailsSavedRouteVC: MyTrailsSavedRouteViewModelDelegates{
    
    func didGetMyTrailsSavedRoute(response: MyTrailsSavedRouteResponse) {
        
        LoaderView.shared.hideLoader(fromVC: self)
        if let currentPage = response.currentPage,
           let totalPage = response.totalPage{
            self.currentPage = currentPage
            self.totalPage = totalPage
        }
        
        if let savedList = response.data,
           !savedList.isEmpty{
            for list in savedList {
                var newObj = list
                newObj.leaderboard = self.getLeaderboardList(route: list)
                self.arrayOfSavedRoutes.append(newObj)
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.routeTableView.reloadData()
        }
    }
    
    func didGetMyTrailsSavedRouteResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        DispatchQueue.main.async { [weak self] in
            self?.routeTableView.reloadData()
        }
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

extension MyTrailsSavedRouteVC: ListViewMethods{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfSavedRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureSavedRouteCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (self.arrayOfSavedRoutes.count - 1)) && (self.currentPage < self.totalPage){
            self.getSavedRoutes()
        }
    }
    
}

//MARK: - EXTENSION FOR CELLS -

extension MyTrailsSavedRouteVC{
    
    private func configureSavedRouteCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.routeTableView.dequeueReusableCell(withIdentifier: .trailSavedRouteCell, for: indexPath) as! TrailSavedRouteCell
        
        let route = self.arrayOfSavedRoutes[indexPath.row]
        cell.titleLbl.text = route.route?.title
        cell.milesLbl.text = "\(Constants.getDistannceInMiles(distanceMiles: route.route?.distanceMiles)) \(GoWildStrings.miles())"
        cell.durationLbl.text = route.route?.estimateTime
        cell.meterLbl.text = "\(route.route?.distanceMeters ?? 0)\(GoWildStrings.meter())"
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(route.route?.picture ?? "")"){
            cell.mapView.kf.indicatorType = .activity
            cell.mapView.kf.setImage(with: imageURL)
        }
        
        if let leaderboard = route.leaderboard,
           !leaderboard.isEmpty{
            cell.leaderboardTableView.isHidden = false
            cell.arrayOfLeaderboard = leaderboard
        }else{
            cell.leaderboardTableView.isHidden = true
            cell.arrayOfLeaderboard = []
        }
        
        cell.tryRouteBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if route.currentUserLeaderboard == nil{
                if !LocationManager.shared.userDeniedLocation{
                    let start = HomeAdminRouteLocation(latitude: route.route?.start?.latitude, longitude: route.route?.start?.longitude)
                    let end = HomeAdminRouteLocation(latitude: route.route?.end?.latitude, longitude: route.route?.end?.longitude)
//                    let routeData: HomeAdminRouteResponseData = HomeAdminRouteResponseData(id: route.route?.id, createdDate: route.route?.createdDate, updatedDate: nil, userID: route.route?.userID, title: route.route?.title, start: start, end: end, description: route.route?.description, role: route.route?.role, picture: route.route?.picture, miles: route.route?.distanceMiles, duration: route.route?.estimateTime, meters: route.route?.distanceMeters, leaderboard: [], currentUserLeaderboard: nil, path: route.route?.path, polyline: route.polyline, historicalEvents: route.route?.historicalEvents)
//                    self.navigateToTryRouteVC(route: routeData)
                }else{
                    AlertControllers.showAlertMessage(inVC: self, title: GoWildStrings.alert(), message: GoWildStrings.locationEnabledError()) {
                        self.openAppSettings()
                    } cancel: {
                        self.dismiss(animated: true)
                    }
                }
            }else{
                AlertControllers.showAlert(inVC: self, message: GoWildStrings.alreadyTryThisRouteError())
            }
        }
        
        cell.saveBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            let request = SaveRouteRequest(routeID: route.routeID ?? "")
            LoaderView.shared.showSpiner(inVC: self)
            self.saveRouteVM.getMyTrailsCreatedRoutes(request: request)
        }
        
        cell.detailBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            let start = HomeAdminRouteLocation(latitude: route.route?.start?.latitude, longitude: route.route?.start?.longitude)
            let end = HomeAdminRouteLocation(latitude: route.route?.end?.latitude, longitude: route.route?.end?.longitude)
//            let routeObj = HomeAdminRouteResponseData(id: route.route?.id, createdDate: route.route?.createdDate, updatedDate: "", userID: route.route?.userID, title: route.route?.title, start: start, end: end, description: route.route?.description, role: route.route?.role, picture: route.route?.picture, miles: route.route?.distanceMiles, duration: route.route?.estimateTime, meters: route.route?.distanceMeters, leaderboard: [], currentUserLeaderboard: nil, path: route.route?.path, polyline: route.polyline, historicalEvents: route.route?.historicalEvents)
//            self.navigateToRouteDetailVC(route: routeObj)
        }
        
        return cell
    }
    
}


//MARK: - EXTENSION FOR SaveRouteViewModel DELEGATES -

extension MyTrailsSavedRouteVC: SaveRouteViewModelDelegates{
    
    func didGetSaveUnSaveRoute(response: SaveRouteResponse, with routeID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let index = self.arrayOfSavedRoutes.firstIndex(where: {$0.routeID == routeID}){
            self.arrayOfSavedRoutes.remove(at: index)
        }
        DispatchQueue.main.async { [weak self] in
            self?.routeTableView.reloadData()
        }
    }
    
    func didGetSaveUnSaveRouteResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        DispatchQueue.main.async { [weak self] in
            self?.routeTableView.reloadData()
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}
