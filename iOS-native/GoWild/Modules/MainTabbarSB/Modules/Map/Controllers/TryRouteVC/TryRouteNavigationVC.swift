//
//  TryRouteNavigationVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class TryRouteNavigationVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var directionView: UIView!
    @IBOutlet weak var directionLbl: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var resultsBtn: LoadingButton!
    
    
    //MARK: - PROPERTIES -
    
    var routeCompleteVM = RouteCompleteViewModel()
    var googleRoutePathVM = GetRoutePathViewModel()
    
    var route : HomeAdminRouteResponseData?
    var steps : [GoogleRoutePathSteps] = []
    var currentPolyline: String = ""
    var currentStepIndex : Int = 1
    var totalStepsIndex : Int = 1
    var startTime: String = ""
    var endTime: String = ""
    let locationManager = CLLocationManager()
    var currentCoordinates: CLLocation = CLLocation()
    var historicalEventsEnabled: Bool = true
    var mapZoom: Float = 18.0
    var viewAngle: Double = 65.0
    var bearing: CLLocationDirection = 0.0
    var isRouteCompleted: Bool = false
    var totalDistance: Double = 0.0
    var userLocationMarker = GMSMarker()
    var polyline: GMSPolyline? = nil
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        setupLocation()
        setupNavigation()
        setupCustomUserLocationIcon()
        getTotalDistanceInMeter()
        routeCompleteVM.delegates = self
        googleRoutePathVM.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** TryRouteNavigationVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.tryRoute().capitalized
        resultsBtn.setTitle(GoWildStrings.showMyResults(), for: .normal)
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        directionView.isHidden = true
        self.totalStepsIndex = self.steps.isEmpty ? 0 : (self.steps.count - 1)
        self.setDirectionText()
        mapView.delegate = self
        mapView.isMyLocationEnabled = false
        mapView.settings.compassButton = false
        resultsBtn.isHidden = true
        resultsBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        resultsBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    func setupCustomUserLocationIcon(){
        userLocationMarker.icon = R.image.ic_current_location_image_green()
        userLocationMarker.isTappable = false
        userLocationMarker.isDraggable = false
        userLocationMarker.isFlat = true
        let position = CLLocationCoordinate2D(latitude: self.currentCoordinates.coordinate.latitude, longitude: self.currentCoordinates.coordinate.longitude)
        userLocationMarker.position = position
        userLocationMarker.rotation = self.mapView.camera.bearing
        let camera = GMSCameraPosition.camera(withLatitude: self.currentCoordinates.coordinate.latitude, longitude: self.currentCoordinates.coordinate.longitude, zoom: self.mapZoom, bearing: self.bearing, viewingAngle: self.viewAngle)
        mapView.animate(to: camera)
        userLocationMarker.map = self.mapView
    }
    
    func setupRoutePath(){
        polyline?.map = nil
        let encodedPath = GMSPath(fromEncodedPath: self.currentPolyline)
        let newPolyline = GMSPolyline(path: encodedPath)
        newPolyline.strokeWidth = 4.0
        newPolyline.strokeColor = R.color.routePolylineGreenColor() ?? .systemGreen
        newPolyline.map = self.mapView
        polyline = newPolyline
    }
    
    func notifyServerForRouteCompletion(){
        if let routeID = self.route?.id,
           !startTime.isEmpty,
           !endTime.isEmpty{
            LoaderView.shared.showSpiner(inVC: self)
            let request = RouteCompleteRequest(routeID: routeID, startDate: self.startTime, endDate: self.endTime)
            self.routeCompleteVM.didCompleteRoute(request: request)
        }
    }
    
    private func getTotalDistanceInMeter(){
        if let startingLat = self.route?.start?.latitude,
           let startingLong = self.route?.start?.longitude,
           let endingLat = self.route?.end?.latitude,
           let endingLong = self.route?.end?.longitude{
            let startPosition = CLLocation(latitude: startingLat, longitude: startingLong)
            let endPosition = CLLocation(latitude: endingLat, longitude: endingLong)
            let distance = endPosition.distance(from: startPosition)
            self.totalDistance = distance
        }
    }
    
    private func navigateToLeaderboardVC(){
        if let routeID = route?.id{
            guard let leaderboardVC = R.storyboard.runWildSB.leaderboardVC() else {return}
            leaderboardVC.routeID = routeID
            self.push(controller: leaderboardVC, hideBar: true, animated: true)
        }
    }
    
    private func setDirectionText(){
        if currentStepIndex <= totalStepsIndex{
            if let lat = self.steps[currentStepIndex].endLocation?.lat,
               let lng = self.steps[currentStepIndex].endLocation?.lng,
               let direction = self.steps[currentStepIndex].turnDirection{
                let currentLatLng = CLLocation(latitude: self.currentCoordinates.coordinate.latitude, longitude: self.currentCoordinates.coordinate.longitude)
                let nextTurnLatLng = CLLocation(latitude: lat, longitude: lng)
                let distance = nextTurnLatLng.distance(from: currentLatLng)
                self.directionLbl.text = "\(Int(distance)) \(GoWildStrings.meter()) \(direction)"
                if currentStepIndex < totalStepsIndex{
                    if distance <= 10{
                        currentStepIndex += 1
                    }
                }else if currentStepIndex == totalStepsIndex{
                    if distance == 40{
                        self.directionLbl.text = GoWildStrings.youAreAlmostThere()
                    }
                }
            }else{
                self.directionLbl.text = ""
            }
        }else{
            self.directionLbl.text = ""
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

}

//MARK: - EXTENSION FOR CLLOCATION DELEGATES -

extension TryRouteNavigationVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        ///After Route Completion Return....
        if isRouteCompleted { return }
        
        guard let location = locations.last else {
            return
        }
        
        ///UPDATE POLYLINE
        let request = GetRoutePathRequest(sourceLat: location.coordinate.latitude, sourceLong: location.coordinate.longitude, destinationLat: self.route?.end?.latitude ?? 0.0, destinationLong: self.route?.end?.longitude ?? 0.0)
        self.googleRoutePathVM.getRoutePath(request: request)
        
        ///Set Turn-By-Turn Directions....
        self.currentCoordinates = location
        
        let position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        userLocationMarker.position = position
        userLocationMarker.rotation = self.mapView.camera.bearing
        
        setupRoutePath()
        
        // Define the new camera position with the user's current location and heading
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0, zoom: self.mapZoom, bearing: self.bearing, viewingAngle: self.viewAngle)
        
        // Animate the map to the new position with the updated heading
        mapView.animate(to: camera)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else {return}
        
            ///To check either route is finished or not...
            if let route = self.route,
               let endLat = route.end?.latitude,
               let endLong = route.end?.longitude{
                let endPosition = CLLocation(latitude: endLat, longitude: endLong)
                let distance = endPosition.distance(from: location)
                
                if self.totalDistance > 200{
                    if distance < 20 {
                        self.mapView.isMyLocationEnabled = false
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
                        self.mapView.isMyLocationEnabled = false
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
    }
    
}
