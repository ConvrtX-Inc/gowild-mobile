//
//  RunWildVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 28/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit
import GoogleMaps
import Kingfisher
import MapboxMaps

class RunWildVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var mapOverlayBtn: UIButton!
    @IBOutlet weak var mapZoomInBtn: UIButton!
    @IBOutlet weak var mapZoomOutBtn: UIButton!
    @IBOutlet weak var historicalSwitch: UISwitch!
    @IBOutlet weak var suggestedRoutesView: UIView!
    @IBOutlet weak var previousRoutesBtn: UIButton!
    @IBOutlet weak var suggestedRoutesLbl: UILabel!
    @IBOutlet weak var routesTableBackView: UIView!
    @IBOutlet weak var routesTableView: UITableView!{
        didSet{
            routesTableView.delegate = self
            routesTableView.dataSource = self
            routesTableView.register(R.nib.homeRouteSubCell)
        }
    }
    @IBOutlet weak var nextRoutesBtn: UIButton!
    @IBOutlet weak var routeTableBackViewHeightConstrain: NSLayoutConstraint!
    
    
    //MARK: - PROPERTIES -
    
    var retrieveAdminRoutesVM = HomeRetrieveRouteViewModel()
    var saveRouteViewModel = SaveRouteViewModel()
    var arrayOfRoutes : [HomeAdminRouteResponseData] = []
    var arrayOfCurrentRoutes : [HomeAdminRouteResponseData] = []
    var currentPage : Int = 0
    var totalPage : Int = 0
    var currentSelectedRouteIndex : Int = 0{
        didSet{
            self.routesTableView.reloadData()
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
    var viewAngle: Double = 30.0
    var mapZoom : Float = 16.0
    var loadMap : Bool = false{
        didSet{
            self.setMapBox()
        }
    }
    var mapView: MapView!
    var pointAnnotationManager: PointAnnotationManager!
    var polylineAnnotationManager: PolylineAnnotationManager!
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        retrieveAdminRoutesVM.delegates = self
        saveRouteViewModel.delegates = self
        getAdminRoutes()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** RunWildVC Deinit ***")
        removeObservers()
    }
    
    //MARK: - METHODS -

    @objc func setText(){
        titleLbl.text = GoWildStrings.runWildTitle().capitalized
        suggestedRoutesLbl.text = GoWildStrings.suggestedRoutes()
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
//        self.mapView.delegate = self
//        self.mapViewContainer.bringSubviewToFront(self.mapOverlayBtn)
//        self.mapViewContainer.bringSubviewToFront(self.mapZoomInBtn)
//        self.mapViewContainer.bringSubviewToFront(self.mapZoomOutBtn)
//        self.historicalSwitch.isOn = false
        suggestedRoutesView.roundCorners([.topLeft, .topRight], radius: 20)
        suggestedRoutesLbl.font = Fonts.getSourceSansProRegularOf(size: 12)
        suggestedRoutesLbl.textColor = AppColor.bgBlackColor()
        self.backView.isHidden = true
        setTableBackViewHeight()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
        addObservers()
    }
    
    private func getAdminRoutes(){
        LoaderView.shared.showSpiner(inVC: self)
        self.retrieveAdminRoutesVM.retrieveAdminRoutes(currentPage: self.currentPage)
    }
    
    private func setTableBackViewHeight(){
        switch self.arrayOfCurrentRoutes.count{
        case 0:
            self.routeTableBackViewHeightConstrain.constant = 60
        case 1:
            self.routeTableBackViewHeightConstrain.constant = 180
        case 2:
            self.routeTableBackViewHeightConstrain.constant = 300
        case 3:
            self.routeTableBackViewHeightConstrain.constant = 400
        default:
            self.routeTableBackViewHeightConstrain.constant = 400
        }
    }
    
    func navigateToTryRouteVC(route: HomeAdminRouteResponseData){
        guard let tryRouteVC = R.storyboard.tryRouteSB.tryRouteVC() else {return}
        tryRouteVC.route = route
        self.push(controller: tryRouteVC, hideBar: true, animated: true)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
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
                self.mapZoom += 1.0
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
                self.mapZoom -= 1.0
                self.mapView.mapboxMap.onEvery(event: .cameraChanged) { [weak self] _ in
                    guard let self = self else {return}
                    self.mapZoom = Float(self.mapView.cameraState.zoom)
            }
                // Declare an animator that changes the map's zoom level.
                let zoomAnimator = self.mapView.camera.makeAnimator(duration: 0.5, curve: .easeOut) { [weak self] (transition) in
                    transition.zoom.toValue = CGFloat(self?.mapZoom ?? 4)
                }
                zoomAnimator.startAnimation()
            }
        }
    }
    
    
    @IBAction func didTapHistoricalSwitch(_ sender: UISwitch) {
        self.loadMap = true
    }
    
    
    @IBAction func didTapPreviousRoutesBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.didGetPreviousAdminRoutes()
        }
    }
    
    
    @IBAction func didTapNextRouteBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.didGetNewAdminRoutes()
        }
    }
    

}


//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension RunWildVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCurrentRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureRouteCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.currentSelectedRouteIndex == indexPath.row {return}
        self.currentSelectedRouteIndex = indexPath.row
        self.createMapRoutesAt(index: indexPath.row)
    }
    
}

//MARK: - EXTENSION FOR HomeRetrieveRouteViewModelDelegates -

extension RunWildVC: HomeRetrieveRouteViewModelDelegates{
    
    func didRetrieveRoutes(response: HomeRetrieveRouteResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        
        if let currentPage = response.currentPage,
           let totalPage = response.totalPage{
            self.routesCurrentPage = currentPage
            self.routesTotalPage = totalPage
        }
        
        if let routeList = response.data{
            if !routeList.isEmpty{
                if self.routesCurrentPage == 1{
                    self.currentRouteListLastIndex = 0
                    self.arrayOfCurrentRoutes.removeAll()
                    for route in routeList{
                        self.arrayOfRoutes.append(route)
                    }
                    self.loadMap = true
                    if self.arrayOfRoutes.count >= 3{
                        self.currentRouteCellCount = 3
                        self.currentRouteListLastIndex += 2
                        for index in (0...2){
                            self.arrayOfCurrentRoutes.append(self.arrayOfRoutes[index])
                        }
                    }else if self.arrayOfRoutes.count == 2{
                        self.currentRouteCellCount = 2
                        self.currentRouteListLastIndex += 1
                        for index in (0...1){
                            self.arrayOfCurrentRoutes.append(self.arrayOfRoutes[index])
                        }
                    }else if self.arrayOfRoutes.count == 1{
                        self.currentRouteCellCount = 1
                        self.currentRouteListLastIndex += 0
                        self.arrayOfCurrentRoutes.append(self.arrayOfRoutes[0])
                    }else{
                        self.currentRouteCellCount = self.arrayOfCurrentRoutes.count
                        self.currentRouteListLastIndex += self.arrayOfCurrentRoutes.count
                    }
                }else{
                    for route in routeList{
                        self.arrayOfRoutes.append(route)
                    }
                    self.loadMap = true
                    self.didGetNewAdminRoutes()
                }
            }
        }
        DispatchQueue.main.async { [weak self] in
            
            ///Self getting referenced.......
            guard let self = self else {return}
            if self.arrayOfRoutes.count > 0{
                self.backView.isHidden = false
                self.setTableBackViewHeight()
                self.createMapRoutesAt(index: self.currentSelectedRouteIndex)
            }
            /// end....
            self.routesTableView.reloadData()
        }
    }
    
    func didRetrieveRoutesResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        DispatchQueue.main.async { [weak self] in
            self?.routesTableView.reloadData()
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

//MARK: - EXTENSION FOR SaveRouteViewModel DELEGATES -

extension RunWildVC: SaveRouteViewModelDelegates{
    
    func didGetSaveUnSaveRoute(response: SaveRouteResponse, with routeID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        
        if let saved = response.data{
            if let index = self.arrayOfRoutes.firstIndex(where: {$0.id == routeID}){
                self.arrayOfRoutes[index].saved = saved
            }
            if let index = self.arrayOfCurrentRoutes.firstIndex(where: {$0.id == routeID}){
                self.arrayOfCurrentRoutes[index].saved = saved
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.routesTableView.reloadData()
        }
        AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? "")
    }
    
    func didGetSaveUnSaveRouteResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        DispatchQueue.main.async { [weak self] in
            self?.routesTableView.reloadData()
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}
