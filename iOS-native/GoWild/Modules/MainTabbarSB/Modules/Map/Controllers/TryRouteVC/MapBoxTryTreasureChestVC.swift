//
//  MapBoxTryTreasureChestVC.swift
//  GoWild
//
//  Created by Hamid on 03/08/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit
import MapboxMaps
import CoreLocation
import NotificationView
import Polyline

class MapBoxTryTreasureChestVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mapContainerView: UIView!
    
    
    //MARK: - PROPERTIES -
    
    private var treasureChestWinnerVM = TreasureChestWinnerViewModel()
    
    let locationManager = CLLocationManager()
    var currentCoordinates: CLLocation = CLLocation()
    var chestLocation: TreasureHuntLocation?
    var chestID: String = ""
    var mapZoom: CGFloat = 18.0
    var viewAngle: Double = 65.0
    var bearing: CLLocationDirection = 0.0
    var isRouteCompleted: Bool = false
    var mapView: MapView!
    var pointAnnotationManager: PointAnnotationManager!
    var polylineAnnotationManager: PolylineAnnotationManager!
//    var cameraLocationConsumer: CameraLocationConsumer!
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        setupLocation()
        setMapBox()
        self.treasureChestWinnerVM.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        self.stopLocation()
        Constants.printLogs("*** MapBoxTryTreasureChestVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.treasureMapTitle().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = .fitness
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func stopLocation(){
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
    }
    
    private func showCustomNotification(){
        let notificationView = NotificationView.default
        notificationView.hideDuration = 2.0
        notificationView.title = GoWildStrings.treasureMapTitle()
        notificationView.subtitle = ""
        notificationView.body = GoWildStrings.congratulationsYouHaveFoundTreasureHunt()
        notificationView.show()
    }
    
    //MARK: - ACTIONS -

    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - EXTEIONS FOR TREASURE CHEST WINNER VIEWMODEL DELEGATES -

extension MapBoxTryTreasureChestVC: TreasureChestWinnerViewModelDelegates{
    
    func didGetChestComplete(response: TreasureChestWinnerResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        stopLocation()
        isRouteCompleted = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func didGetChestCompleteResponseWith(error: String) {
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

//MARK: - EXTENSION FOR CLLOCATION DELEGATES -

extension MapBoxTryTreasureChestVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        ///After Route Completion Return....
        if isRouteCompleted { return }
        
        guard let location = locations.last else {
            return
        }
        
        self.currentCoordinates = location

//        self.didUpdateUserLocation(newLocation: Location(coordinate: location.coordinate))
        if let chestLocation = self.chestLocation,
           let endLat = chestLocation.latitude,
           let endLong = chestLocation.longitude{
            let endPosition = CLLocation(latitude: endLat, longitude: endLong)
            let distance = endPosition.distance(from: location)
            if distance < 5{
                showCustomNotification()
                LoaderView.shared.showSpiner(inVC: self)
                self.treasureChestWinnerVM.didCompleteChestOf(chestID: self.chestID)
            }else{
                Constants.printLogs("Keep Searching...")
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
        let cameraOptions = CameraOptions(center: manager.location?.coordinate, bearing: newHeading.trueHeading)
        mapView?.camera.ease(to: cameraOptions, duration: 0.5)
    }
    
}
//MARK: - EXTENSION FOR MAPBOX
extension MapBoxTryTreasureChestVC {
    
    func setMapBox() {
        
        let myResourceOptions = ResourceOptions(accessToken: ConfigurationManager.shared.getMapBoxAccessToken())
        let resourceCoordinates = self.currentCoordinates.coordinate
        let horizontalPadding = (mapContainerView.frame.width - (mapContainerView.frame.height / 1.2)) / 2
        let cameraOptions = CameraOptions(center: resourceCoordinates,padding: UIEdgeInsets(top: 50, left: horizontalPadding, bottom: 50, right: horizontalPadding), zoom: CGFloat(self.mapZoom),pitch: self.viewAngle)
        
        if mapView == nil {
            let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, cameraOptions: cameraOptions)
            mapView = MapView(frame: view.frame, mapInitOptions: myMapInitOptions)
            mapView.translatesAutoresizingMaskIntoConstraints = false
            //Handle Gesture
            mapView.gestures.options.pitchEnabled = false
            mapView.ornaments.options.scaleBar.visibility = .hidden
            mapView.ornaments.options.compass.visibility = .hidden
            mapView.ornaments.options.attributionButton.margins = .init(x: -1000, y: 0)
            self.mapContainerView.addSubview(mapView)
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: mapContainerView.topAnchor),
                mapView.bottomAnchor.constraint(equalTo: mapContainerView.bottomAnchor),
                mapView.leadingAnchor.constraint(equalTo: mapContainerView.leadingAnchor),
                mapView.trailingAnchor.constraint(equalTo: mapContainerView.trailingAnchor)
            ])
            self.mapView.location.options.puckType = .puck2D(Puck2DConfiguration(topImage: R.image.ic_current_location_image_green(),bearingImage: R.image.ic_current_location_image_green(),shadowImage: nil,scale: .constant(0.40),pulsing: .none))
//            self.bearing = CLLocationDirection(self.mapView.location.options.puckBearing.hashValue)
//            self.cameraLocationConsumer = CameraLocationConsumer(mapView: self.mapView, mapZoom: self.mapZoom, bearing: self.bearing, delegates: self)
            
        }
        
        mapView.mapboxMap.onNext(event: .mapLoaded) { [weak self] event in
            guard let self = self else {return}
//            self.mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
            
        }
    }
    
        func didUpdateUserLocation(newLocation: Location) {
            if let chestLocation = self.chestLocation,
               let chestLat = chestLocation.latitude,
               let chestLng = chestLocation.longitude{
                let chestCoordinates: CLLocation = CLLocation(latitude: chestLat, longitude: chestLng)
                let distance = newLocation.location.distance(from: chestCoordinates)
                if distance < 5{
                    showCustomNotification()
                    LoaderView.shared.showSpiner(inVC: self)
                    self.treasureChestWinnerVM.didCompleteChestOf(chestID: self.chestID)
                }else{
                    Constants.printLogs("Keep Searching...")
                }
            }
        }
    private func updateCamera(for location: CLLocation) {
            if let newZoom = mapView?.cameraState.zoom {
                self.mapZoom = newZoom
            }
            
            mapView?.camera.ease(
                to: CameraOptions(center: location.coordinate, zoom: self.mapZoom, bearing: self.bearing),
                duration: 0.8
            )
        }
    
}

//extension MapBoxTryTreasureChestVC: CameraLocationConsumerDelegates {
//
//    func didUpdateUserLocation(newLocation: Location) {
//        if let chestLocation = self.chestLocation,
//           let chestLat = chestLocation.latitude,
//           let chestLng = chestLocation.longitude{
//            let chestCoordinates: CLLocation = CLLocation(latitude: chestLat, longitude: chestLng)
//            let distance = newLocation.location.distance(from: chestCoordinates)
//            if distance < 5{
//                showCustomNotification()
//                LoaderView.shared.showSpiner(inVC: self)
//                self.treasureChestWinnerVM.didCompleteChestOf(chestID: self.chestID)
//            }else{
//                Constants.printLogs("Keep Searching...")
//            }
//        }
//    }
//
//}

