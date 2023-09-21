//
//  MapBoxTryRouteNavigationVC.swift
//  GoWild
//
//  Created by SA - Muhammad Hamza on 31/07/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit
import CoreLocation
import MapboxMaps
import Polyline

class MapBoxTryRouteNavigationVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var directionView: UIView!
    @IBOutlet weak var directionLbl: UILabel!
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var resultsBtn: LoadingButton!
    @IBOutlet weak var mapMainView: UIView!
    @IBOutlet weak var historicalView: UIView!
    @IBOutlet weak var oldPaperImg: UIImageView!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var gotItBtn: UIButton!
    @IBOutlet weak var historicalImg: UIImageView!
    @IBOutlet weak var historicalLbl: UILabel!
    @IBOutlet weak var historicalDiscreptionLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var historicalDiscreptionsStack: UIStackView!
    
    
    //MARK: - PROPERTIES -
    
    var routeCompleteVM = RouteCompleteViewModel()
    var mapView: MapView!
    var pointAnnotationManager: PointAnnotationManager!
//    var cameraLocationConsumer: CameraLocationConsumer!
    var route : HomeAdminRouteResponseData?
    var arrayOfCoordinates: [CLLocationCoordinate2D] = []
    var lastCoordinates: CLLocationCoordinate2D?
    var currentPolyline: String = ""
    var startTime: String = ""
    var endTime: String = ""
    let locationManager = CLLocationManager()
    var currentCoordinates: CLLocation = CLLocation()
    var historicalEventsEnabled: Bool = true
    var mapZoom: CGFloat = 20.0
    var viewAngle: Double = 45.0
    var bearing: CLLocationDirection = 0.0
    var isRouteCompleted: Bool = false
    var totalDistance: Double = 0.0
    var polyline: String? = ""
    var polylineManager: PolylineAnnotationManager!
    var userPolylineManager: PolylineAnnotationManager!
    var historicalPlaceData: HomeAdminRouteHistoricalLocation?
    var showHistoryPopUp: Bool?
    var historicalPlaces = [CLLocationCoordinate2D]()

    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        setupLocation()
        setMapBox()
        routeCompleteVM.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        self.stopLocation()
        Constants.printLogs("*** MapBoxTryRouteNavigationVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        if let routeInfo = route,
           let routeTitle = routeInfo.title {
            titleLbl.text = routeTitle
        }else {
            titleLbl.text = GoWildStrings.tryRoute().capitalized
        }
        resultsBtn.setTitle(GoWildStrings.showMyResults(), for: .normal)
        historicalLbl.text = GoWildStrings.historicalPointTitle()
        infoLbl.text = GoWildStrings.infoLblText()
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        directionView.isHidden = true
        resultsBtn.isHidden = true
        resultsBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        resultsBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        gotItBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        gotItBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        historicalLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        historicalLbl.textColor = AppColor.textFieldBgColor()
        infoLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        infoLbl.textColor = AppColor.textFieldBgColor()
        historicalDiscreptionLbl.font = Fonts.getForegenRoughOneFontOf(size: 16)
        historicalDiscreptionLbl.textColor = AppColor.textFieldBgColor()

        
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func navigateToLeaderboardVC(){
        if let routeID = route?.id{
            guard let leaderboardVC = R.storyboard.runWildSB.leaderboardVC() else {return}
            leaderboardVC.routeID = routeID
            self.push(controller: leaderboardVC, hideBar: true, animated: true)
        }
    }
    
    private func notifyServerForRouteCompletion(){
        if let routeID = self.route?.id,
           !startTime.isEmpty,
           !endTime.isEmpty{
            LoaderView.shared.showSpiner(inVC: self)
            let request = RouteCompleteRequest(routeID: routeID, startDate: self.startTime, endDate: self.endTime)
            self.routeCompleteVM.didCompleteRoute(request: request)
        }
    }
    
    //MARK: - ACTIONS -

    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            if self.isRouteCompleted{
                self.navigationController?.popViewController(animated: true)
            }else{
                AlertControllers.showAlertMessage(inVC: self, title: GoWildStrings.alert(), message: GoWildStrings.areYouSureYouWantToGoBackAlert()) {
                    self.navigationController?.popViewController(animated: true)
                } cancel: {
                    self.dismiss(animated: true)
                }

            }
        }
    }
    
    @IBAction func didTapResultsBtn(_ sender: UIButton){
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            self.navigateToLeaderboardVC()
        }
    }
    
    @IBAction func didTapCrossBtn(_ sender: UIButton){
        setHistoricalInformation(isShowingTitle: false)
    }
    
    @IBAction func didTapGotItBtn(_ sender: UIButton){
        setHistoricalInformation(isShowingTitle: true)
    }
    

}


//MARK: - EXTENSION FOR RouteCompleteViewModelDelegates -

extension MapBoxTryRouteNavigationVC: RouteCompleteViewModelDelegates{
    
    func didGetRouteComplete(response: RouteCompleteResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.resultsBtn.isHidden = false
        self.isRouteCompleted = true
        self.stopLocation()
    }
    
    func didGetRouteCompleteResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.showRetryAlert(title: GoWildStrings.alert(), message: error) { [weak self] in
            guard let self = self else {return}
            self.notifyServerForRouteCompletion()
        } cancel: {
            self.dismiss(animated: true)
        }

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

//MARK: - EXTENSION FOR RETRY ALERT -

extension MapBoxTryRouteNavigationVC{
    
    func showRetryAlert(title: String, message: String,ok: @escaping () -> Void,cancel: @escaping () -> Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let done = UIAlertAction(title: GoWildStrings.retry(), style: .default) { _ in
            ok()
        }
        let cancel = UIAlertAction(title: GoWildStrings.cancel(), style: .cancel) { _ in
            cancel()
        }
        alertController.addAction(done)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
    
}

//MARK: - EXTENSION FOR CLLOCATION DELEGATES -

extension MapBoxTryRouteNavigationVC: CLLocationManagerDelegate, LocationPermissionsDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        ///After Route Completion Return....
        if isRouteCompleted { return }
        
        guard let location = locations.last else {
            return
        }
        
        if self.lastCoordinates == nil{
            self.lastCoordinates = location.coordinate
        }
        
        self.currentCoordinates = location
        
            let distance = lastCoordinates!.distance(to: location.coordinate)
        Constants.printLogs("Travelled Distance: \(distance)")
        if distance > 0.3{
            self.lastCoordinates = location.coordinate
            self.arrayOfCoordinates.append(location.coordinate)
//            if !self.arrayOfCoordinates.isEmpty{
//                var userPolyline = PolylineAnnotation(lineCoordinates: self.arrayOfCoordinates)
//                userPolyline.isDraggable = false
//                userPolyline.lineJoin = .round
//
//                userPolyline.lineOpacity = 1.0
//                userPolyline.lineWidth = 8
//                userPolyline.lineColor = StyleColor(AppColor.userPolylineColor())
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
//                    guard let self = self else {return}
//                    self.userPolylineManager.annotations.append(userPolyline)
//                })
//            }
            if let historicalEvents = self.route?.historicalEvents, !historicalEvents.isEmpty {
                guard showHistoryPopUp == true || showHistoryPopUp == nil else { return }
                
                for place in historicalEvents {
                    if let event = place.historicalEvent,
                       let eventLat = event.latitude,
                       let eventLong = event.longitude {
                        let historyPlaceCoord = CLLocationCoordinate2D(latitude: eventLat, longitude: eventLong)
                        let distance = historyPlaceCoord.distance(to: currentCoordinates.coordinate)
                        if distance < 2 && !historicalPlaces.contains(historyPlaceCoord) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.showHistoricalInformation(for: place)
                                self.historicalPlaces.append(historyPlaceCoord)
                            }
                            Constants.printLogs("Coords Appended: \(historicalPlaces)")
                        } else {
                            Constants.printLogs("Move closer to historical place")
                            
                        }
                    }
                }
            }else {
                self.lastCoordinates = location.coordinate
            }
        }
            
//        }
        // Define the new camera position with the user's current location and heading
        let cameraOptions = CameraOptions(center: manager.location?.coordinate)
        mapView?.camera.ease(to: cameraOptions, duration: 0.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else {return}
        
            ///To check either route is finished or not...
            if let route = self.route,
               let endLat = route.end?.latitude,
               let endLong = route.end?.longitude{
                let endPosition = CLLocation(latitude: endLat, longitude: endLong)
                let distance = endPosition.distance(from: location)
                
                if self.totalDistance > 200{
                    if distance < 5 {
                        self.mapView.location.options.puckType = .none
                        self.directionView.isHidden = false
                        self.directionLbl.text = GoWildStrings.completeRouteMessage()
                        self.endTime = Constants.getCurrentDateString()
                        if !self.isRouteCompleted{
                            self.isRouteCompleted = true
                            self.notifyServerForRouteCompletion()
                        }
                    } else {
                        Constants.printLogs("Keep going.")
                    }
                }else{
                    if distance < 5 {
                        self.mapView.location.options.puckType = .none
                        self.directionView.isHidden = false
                        self.directionLbl.text = GoWildStrings.completeRouteMessage()
                        self.endTime = Constants.getCurrentDateString()
                        if !self.isRouteCompleted{
                            self.isRouteCompleted = true
                            self.notifyServerForRouteCompletion()
                        }
                    } else {
                        Constants.printLogs("Keep going.")
                    }
                }
            }
            
        }
    }
    
    ///For Heading Changed...
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if isRouteCompleted {return}
        // Check if the user's heading has changed by at least 10 degrees
        guard abs(newHeading.trueHeading - self.bearing) >= 1 else {
            self.bearing = newHeading.trueHeading
            return }
        
        // Store the current heading value for comparison in the next update
        self.bearing = newHeading.trueHeading
        // Define the new camera position with the user's current heading
        let cameraOptions = CameraOptions(bearing: bearing)
        mapView?.camera.ease(to: cameraOptions, duration: 0.5)
    }
        
}
