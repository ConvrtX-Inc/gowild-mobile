//
//  MyTrailsCreatedRouteVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher

class MyTrailsCreatedRouteVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var routeTableView: UITableView!{
        didSet{
            routeTableView.delegate = self
            routeTableView.dataSource = self
            routeTableView.register(R.nib.trailCreatedRouteCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var createdRouteVM = MyTrailsCreatedRouteViewModel()
    private var deleteRouteVM = DeleteCreatedRouteViewModel()
    private var arrayOfCreatedRoutes: [MyTrailsCreatedRouteData] = []
    private var currentPage: Int = 0
    private var totalPage: Int = 0
    
    //MARK: - LIFE CYCLE -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        createdRouteVM.delegates = self
        deleteRouteVM.delegates = self
        getCreatedRoutes()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** MyTrailsCreatedRouteVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        
    }
    
    func setUI(){
        
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getCreatedRoutes(){
        if currentPage == 0{
            LoaderView.shared.showSpiner(inVC: self)
        }
        self.createdRouteVM.getMyTrailsCreatedRoutes(currentPage: self.currentPage)
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
    
    private func shareActivity(routeLink: String){
        let completeLink = "\(DeepLinks.shared.route)\(routeLink)"
        let shareVC = UIActivityViewController(activityItems: [completeLink], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        shareVC.excludedActivityTypes = [.addToReadingList]
        self.present(shareVC, animated: true, completion: nil)
    
    }
    
    private func navigateToEditRouteVC(with route: MyTrailsCreatedRouteData){
        guard let newRouteVC = R.storyboard.myTrailsSB.myTrailsCreateNewRouteVC() else {return}
        newRouteVC.mode = .editRoute
        newRouteVC.delegates = self
        newRouteVC.currentTitle = route.title ?? GoWildStrings.newRoute()
        newRouteVC.currentRouteName = route.title ?? ""
        newRouteVC.routePath = route.path ?? ""
        newRouteVC.estimateTime = route.estimateTime ?? ""
        newRouteVC.distanceMiles = route.distanceMiles ?? 0.0
        newRouteVC.distanceMeters = route.distanceMeters ?? 0
        newRouteVC.startAddress = route.startLocation ?? ""
        newRouteVC.endAddress = route.endLocation ?? ""
        newRouteVC.pathImage = "\(UserManager.shared.getBaseURL())\(route.picture ?? "")"
        newRouteVC.sourceLatitude = route.start?.latitude ?? 0.0
        newRouteVC.sourceLongitude = route.start?.longitude ?? 0.0
        newRouteVC.destinationLatitude = route.end?.latitude ?? 0.0
        newRouteVC.destinationLongitude = route.end?.longitude ?? 0.0
        newRouteVC.routeID = route.id ?? ""
        self.push(controller: newRouteVC, hideBar: true, animated: true)
    }
    
    //MARK: - ACTIONNS -

    

}

//MARK: - EXTENSION FOR SAVED ROUTES VIEWMODEL DELEGATES -

extension MyTrailsCreatedRouteVC: MyTrailsCreatedRouteViewModelDelegates{
    
    func didGetMyTrailsCreatedRoute(response: MyTrailsCreatedRouteResponse) {
        
        LoaderView.shared.hideLoader(fromVC: self)
        if let currentPage = response.currentPage,
           let totalPage = response.totalPage{
            self.currentPage = currentPage
            self.totalPage = totalPage
        }
        
        if let routeList = response.data,
           !routeList.isEmpty{
            for list in routeList{
                self.arrayOfCreatedRoutes.append(list)
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.routeTableView.reloadData()
        }
    }
    
    func didGetMyTrailsCreatedRouteResponseWith(error: String) {
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

//MARK: - EXTENSION FOR ROUTE DELETE VIEW MODEL DELEGATES -

extension MyTrailsCreatedRouteVC: DeleteCreatedRouteViewModelDelegates{
    
    func didDeleteCreatedRoute(response: DeleteCreatedRouteResponse, routeID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let index = self.arrayOfCreatedRoutes.firstIndex(where: {$0.id == routeID}){
            self.arrayOfCreatedRoutes.remove(at: index)
            DispatchQueue.main.async { [weak self] in
                self?.routeTableView.reloadData()
            }
        }
    }
    
    func didGetDeleteCreatedRouteResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        DispatchQueue.main.async { [weak self] in
            self?.routeTableView.reloadData()
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension MyTrailsCreatedRouteVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfCreatedRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCreatedRouteCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (self.arrayOfCreatedRoutes.count - 1)) && (self.currentPage < self.totalPage){
            self.getCreatedRoutes()
        }
    }
    
}

//MARK: - EXTENSION FOR CELLS -

extension MyTrailsCreatedRouteVC{
    
    private func configureCreatedRouteCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.routeTableView.dequeueReusableCell(withIdentifier: .trailCreatedRouteCell, for: indexPath) as! TrailCreatedRouteCell
        let route = self.arrayOfCreatedRoutes[indexPath.row]
        cell.titleLbl.text = route.title
        cell.milesLbl.text = "\(Constants.getDistannceInMiles(distanceMiles: route.distanceMiles)) \(GoWildStrings.miles())"
        cell.durationLbl.text = route.estimateTime
        cell.meterLbl.text = "\(route.distanceMeters ?? 0)\(GoWildStrings.meter())"
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(route.picture ?? "")"){
            cell.mapView.kf.indicatorType = .activity
            cell.mapView.kf.setImage(with: imageURL)
        }
        
        cell.tryRouteBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if route.status == MyTrailsCreatedRouteEnum.approved.rawValue{
                if !LocationManager.shared.userDeniedLocation{
                    let start = HomeAdminRouteLocation(latitude: route.start?.latitude, longitude: route.start?.longitude)
                    let end = HomeAdminRouteLocation(latitude: route.end?.latitude, longitude: route.end?.longitude)
//                    let routeData: HomeAdminRouteResponseData = HomeAdminRouteResponseData(id: route.id, createdDate: route.createdDate, updatedDate: nil, userID: route.userID, title: route.title, start: start, end: end, description: route.description, role: route.role, picture: route.picture, miles: route.distanceMiles, duration: route.estimateTime, meters: route.distanceMeters, leaderboard: [], currentUserLeaderboard: nil, path: route.path, historicalEvents: route.historicalEvents)
//                    self.navigateToTryRouteVC(route: routeData)
                }else{
                    AlertControllers.showAlertMessage(inVC: self, title: GoWildStrings.alert(), message: GoWildStrings.locationEnabledError()) {
                        self.openAppSettings()
                    } cancel: {
                        self.dismiss(animated: true)
                    }
                }
            }else{
                AlertControllers.showAlert(inVC: self, message: GoWildStrings.routeIsNotApprovedByAdminError())
            }
        }
        
        cell.shareBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            self.shareActivity(routeLink: route.id ?? "")
        }
        
        cell.detailBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            let start = HomeAdminRouteLocation(latitude: route.start?.latitude, longitude: route.start?.longitude)
            let end = HomeAdminRouteLocation(latitude: route.end?.latitude, longitude: route.end?.longitude)
//            let routeDetail = HomeAdminRouteResponseData(id: route.id, createdDate: route.createdDate, updatedDate: route.updatedDate, userID: route.userID, title: route.title, start: start, end: end, description: route.description, role: route.role, saved: false, picture: route.picture, miles: route.distanceMiles, duration: route.estimateTime, meters: route.distanceMeters, leaderboard: nil, currentUserLeaderboard: nil, path: route.path, historicalEvents: route.historicalEvents)
//            self.navigateToRouteDetailVC(route: routeDetail)
        }
        
        cell.editRouteImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            self.navigateToEditRouteVC(with: route)
        }
        
        cell.deleteRouteImageView.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            guard let routeID = route.id else {return}
            LoaderView.shared.showSpiner(inVC: self)
            self.deleteRouteVM.getMyTrailsCreatedRoutes(routeID: routeID)
        }
        
        return cell
        
    }
    
}


//MARK: - EXTENSION FOR MyTrailsCreateNewRouteVCDelegates -

extension MyTrailsCreatedRouteVC: MyTrailsCreateNewRouteVCDelegates{
    
    func didDeleteRouteOf(routeID: String) {
        if let index = self.arrayOfCreatedRoutes.firstIndex(where: {$0.id == routeID}){
            self.arrayOfCreatedRoutes.remove(at: index)
            DispatchQueue.main.async { [weak self] in
                self?.routeTableView.reloadData()
            }
        }
    }
    
    func didUpdateRouteOf(route: MyTrailsCreatedRouteData) {
        if let index = self.arrayOfCreatedRoutes.firstIndex(where: {$0.id == route.id}){
            self.arrayOfCreatedRoutes.remove(at: index)
            self.arrayOfCreatedRoutes.insert(route, at: index)
            DispatchQueue.main.async { [weak self] in
                self?.routeTableView.reloadData()
            }
        }
    }
    
}
