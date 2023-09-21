//
//  TryTreasureChestVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 10/03/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit
import GoogleMaps
import NotificationView

class TryTreasureChestVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    
    //MARK: - PROPERTIES -
    
    private var treasureChestWinnerVM = TreasureChestWinnerViewModel()
    
    let locationManager = CLLocationManager()
    var currentCoordinates: CLLocation = CLLocation()
    var chestLocation: TreasureHuntLocation?
    var chestID: String = ""
    var mapZoom: Float = 18.0
    var viewAngle: Double = 65.0
    var bearing: CLLocationDirection = 0.0
    var isRouteCompleted: Bool = false
    var userLocationMarker = GMSMarker()
    
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        setupLocation()
        setupNavigation()
        setupCustomUserLocationIcon()
        treasureChestWinnerVM.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** TryTreasureChestVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.treasureMapTitle().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        mapView.delegate = self
        mapView.isMyLocationEnabled = false
        mapView.settings.compassButton = false
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func setupCustomUserLocationIcon(){
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
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1
        locationManager.headingFilter = 1
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

extension TryTreasureChestVC: TreasureChestWinnerViewModelDelegates{
    
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

//MARK: - EXTENSION FOR MAPVIEW DELEGATES -

extension TryTreasureChestVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.viewAngle = position.viewingAngle
        self.mapZoom = position.zoom
        self.bearing = position.bearing
    }
    
}

//MARK: - EXTENSION FOR CLLOCATION DELEGATES -

extension TryTreasureChestVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        ///After Route Completion Return....
        if isRouteCompleted { return }
        
        guard let location = locations.last else {
            return
        }
        
        self.currentCoordinates = location
        
        let position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        userLocationMarker.position = position
        userLocationMarker.rotation = self.mapView.camera.bearing
        
        // Define the new camera position with the user's current location and heading
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: self.mapZoom, bearing: self.bearing, viewingAngle: self.viewAngle)
        
        // Animate the map to the new position with the updated heading
        self.mapView.animate(to: camera)
        
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
    }
    
}

//MARK: - EXTENSION FOR NAVIGATION VC -

extension TryTreasureChestVC{
    
    func setupNavigation(){
        let camera = GMSCameraPosition.camera(withTarget: self.currentCoordinates.coordinate, zoom: self.mapZoom, bearing: self.bearing, viewingAngle: self.viewAngle)
        self.mapView.animate(to: camera)
    }
    
}
