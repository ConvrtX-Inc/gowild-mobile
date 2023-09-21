//
//  TryRouteVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import Polyline
import MapboxMaps

class TryRouteVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var historicalSwitch: UISwitch!
    @IBOutlet weak var directionLbl: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var startBtn: LoadingButton!
    @IBOutlet weak var mapOverlayBtn: UIButton!
    @IBOutlet weak var zoomInBtn: UIButton!
    @IBOutlet weak var zoomOutBtn: UIButton!
    
    //MARK: - PROPERTIES -
    
    private var routeDirectionVM = GetRoutePathViewModel()
    var route : HomeAdminRouteResponseData?
    var viewAngle: Double = 30.0
    var mapZoom : Float = 16.0
    private var locationManager = CLLocationManager()
    private var canStartNavigation: Bool = false
    var mapView: MapView!
    var pointAnnotationManager: PointAnnotationManager!
    var polylineAnnotationManager: PolylineAnnotationManager!
    //MARK: - LIFE CYCLE -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        routeDirectionVM.delegates = self
        if let route = self.route{
//            setupGoogleMap(with: route)
            setMapBox(with: route)
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.activityType = .fitness
            locationManager.distanceFilter = 1
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        locationManager.stopUpdatingHeading()
        locationManager.stopUpdatingHeading()
        locationManager.stopMonitoringSignificantLocationChanges()
        removeObservers()
        Constants.printLogs("*** TryRouteVC Deinit ***")
    }
    

    //MARK: - METHODS -
    
    @objc func setText(){
        if let routeInfo = route,
           let routeTitle = routeInfo.title {
            titleLbl.text = routeTitle
        }else {
            titleLbl.text = GoWildStrings.tryRoute().capitalized
        }
        directionLbl.text = self.route?.title ?? ""
        detailBtn.setTitle(GoWildStrings.details(), for: .normal)
        startBtn.setTitle(GoWildStrings.startRoute(), for: .normal)
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        historicalSwitch.isOn = true
        mapOverlayBtn.isHidden = true
//        mapView.delegate = self
//        mapView.isMyLocationEnabled = true
//        mapView.bringSubviewToFront(self.mapOverlayBtn)
//        mapView.bringSubviewToFront(self.zoomInBtn)
//        mapView.bringSubviewToFront(self.zoomOutBtn)
        startBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        startBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
        addObservers()
    }
    
    private func navigateToTryRouteNavVC(route: HomeAdminRouteResponseData){
        guard let tryRouteNavVC = R.storyboard.tryRouteSB.mapBoxTryRouteNavigationVC() else {return}
        tryRouteNavVC.route = route
        tryRouteNavVC.currentPolyline = route.polyline ?? ""
        tryRouteNavVC.startTime = Constants.getCurrentDateString()
        tryRouteNavVC.historicalEventsEnabled = self.historicalSwitch.isOn ? true : false
        self.push(controller: tryRouteNavVC, hideBar: true, animated: true)
//        guard let tryRouteNavVC = R.storyboard.tryRouteSB.tryRouteNavigationVC() else {return}
//        tryRouteNavVC.route = route
//        tryRouteNavVC.steps = steps
//        tryRouteNavVC.currentPolyline = route.path ?? ""
//        tryRouteNavVC.startTime = Constants.getCurrentDateString()
//        tryRouteNavVC.historicalEventsEnabled = self.historicalSwitch.isOn ? true : false
//        self.push(controller: tryRouteNavVC, hideBar: true, animated: true)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didTapHistoricalSwitchBtn(_ sender: UISwitch) {
        if let route = self.route{
//            self.setupGoogleMap(with: route)
            self.setMapBox(with: route)
        }
    }
    
    @IBAction func didTapDetailBtn(_ sender: UIButton) {
        sender.showAnimation {
            if let route = self.route{
                self.navigateToRouteDetailVC(route: route)
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
                self.mapZoom += 1.0
                self.mapView.mapboxMap.onEvery(event: .cameraChanged) { [weak self] _ in
                    guard let self = self else {return}
                    self.mapZoom = Float(self.mapView.cameraState.zoom)
            }
                let zoomAnimator = self.mapView.camera.makeAnimator(duration: 0.5, curve: .easeIn) { [weak self] (transition) in
                    transition.zoom.toValue = CGFloat(self?.mapZoom ?? 12)
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
                
//                self.mapView.animate(toZoom: self.mapZoom)
            }
        }
    }
    
    @IBAction func didTapStartBtn(_ sender: UIButton){
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            self.locationManager.startUpdatingLocation()
            if !LocationManager.shared.userDeniedLocation{
                if let polyline = self.route?.path,
                   !polyline.isEmpty{
                    if let route = self.route, self.canStartNavigation == true{
                        self.navigateToTryRouteNavVC(route: route)
                    } else {
                        AlertControllers.showAlert(inVC: self, message: GoWildStrings.cannotStartNavigationError())
                        self.locationManager.stopUpdatingLocation()
                    }
                }else{
                    AlertControllers.showAlert(inVC: self, message: GoWildStrings.routePathIsInvalid())
                }
            }else{
                AlertControllers.showAlertMessage(inVC: self, title: GoWildStrings.alert(), message: GoWildStrings.locationEnabledError()) {
                    self.openAppSettings()
                } cancel: {
                    self.dismiss(animated: true)
                }
            }
        }
    }

}

//MARK: - EXTENSION FOR GOOGLE MAPS METHODS -

extension TryRouteVC{
    
//    func setupGoogleMap(with route: HomeAdminRouteResponseData){
//        
//        guard let sourceLatitude = route.start?.latitude,
//              let sourceLongitude = route.start?.longitude,
//              let destinationLatitude = route.end?.latitude,
//              let destinationLongitude = route.end?.longitude else {return}
//        
//        //Draw Route...
//        self.drawPolyline(path: self.route?.path ?? "")
//        
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: sourceLatitude, longitude: sourceLongitude, zoom: self.mapZoom)
//        self.mapView.camera = camera
////        MapOverLayViewModel.shared.setMapStyle(self.mapView)
//        
//        // Creates a marker in the center of the map.
//        let sourceMarker = GMSMarker()
//        sourceMarker.title = GoWildStrings.startingPoint()
//        sourceMarker.icon = R.image.ic_source_marker()
//        sourceMarker.position = CLLocationCoordinate2D(latitude: sourceLatitude, longitude: sourceLongitude)
//        sourceMarker.map = self.mapView
//        
//        let destinationMarker = GMSMarker()
//        destinationMarker.title = GoWildStrings.endPoint()
//        destinationMarker.icon = R.image.ic_destination_marker()
//        destinationMarker.position = CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude)
//        destinationMarker.map = self.mapView
//        
//        if self.historicalSwitch.isOn{
//            if let historicalPlaces = self.route?.historicalEvents,
//               !historicalPlaces.isEmpty{
//                for place in historicalPlaces {
//                    if let lat = place.historicalEvent?.latitude,
//                       let long = place.historicalEvent?.longitude,
//                       let title = place.title,
//                       let subtitle = place.subtitle{
//                        let historicalMarker = GMSMarker()
//                        historicalMarker.title = title
//                        historicalMarker.snippet = subtitle
//                        historicalMarker.icon = R.image.ic_historical_marker()
//                        historicalMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
//                        historicalMarker.map = self.mapView
//                    }
//                }
//            }
//        }
//        
//        
//    }
    
    func drawPolyline(path: String){
//        if let path = GMSPath(fromEncodedPath: path){
//            self.mapView.clear()
//            let polyline = GMSPolyline(path: path)
//            polyline.strokeWidth = 3
//            polyline.strokeColor = AppColor.routePolylineGreenColor()
//            let bounds = GMSCoordinateBounds(path: path)
//            self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
//            polyline.map = self.mapView
//        }
    }
    
    func setMapBox(with route: HomeAdminRouteResponseData) {
        guard let sourceLatitude = route.start?.latitude,
              let sourceLongitude = route.start?.longitude else {return}
        let myResourceOptions = ResourceOptions(accessToken: ConfigurationManager.shared.getMapBoxAccessToken())
        let resourceCoordinates = CLLocationCoordinate2D(latitude: sourceLatitude, longitude: sourceLongitude)
        let horizontalPadding = (mapViewContainer.frame.width - (mapViewContainer.frame.height / 1.2)) / 2
        let cameraOptions = CameraOptions(center: resourceCoordinates,padding: UIEdgeInsets(top: 50, left: horizontalPadding, bottom: 50, right: horizontalPadding), zoom: CGFloat(self.mapZoom),pitch: self.viewAngle)
        
        if mapView == nil {
            let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, cameraOptions: cameraOptions)
            mapView = MapView(frame: view.frame, mapInitOptions: myMapInitOptions)
            mapView.translatesAutoresizingMaskIntoConstraints = false
            //Handle Gesture
            mapView.location.options.puckType = .puck2D(Puck2DConfiguration(topImage: R.image.ic_current_location_image_green(),bearingImage: R.image.ic_current_location_image_green(),shadowImage: nil,scale: .constant(0.40),pulsing: .none))
            mapView.gestures.options.pitchEnabled = false
            mapView.ornaments.options.scaleBar.visibility = .hidden
            mapView.ornaments.options.compass.visibility = .hidden
            mapView.ornaments.options.attributionButton.margins = .init(x: -1000, y: 0)
            self.mapViewContainer.addSubview(mapView)
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: mapViewContainer.topAnchor),
                mapView.bottomAnchor.constraint(equalTo: mapViewContainer.bottomAnchor),
                mapView.leadingAnchor.constraint(equalTo: mapViewContainer.leadingAnchor),
                mapView.trailingAnchor.constraint(equalTo: mapViewContainer.trailingAnchor)
            ])
            polylineAnnotationManager = mapView.annotations.makePolylineAnnotationManager()
            pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
            self.mapViewContainer.bringSubviewToFront(self.mapOverlayBtn)
            self.mapViewContainer.bringSubviewToFront(self.zoomInBtn)
            self.mapViewContainer.bringSubviewToFront(self.zoomOutBtn)
        }
        
        MapOverLayViewModel.shared.setMapStyle(self.mapView)
        mapView.camera.fly(to: cameraOptions, duration: 1)
        
        mapView.mapboxMap.onNext(event: .mapLoaded) { [weak self] event in
            self?.drawPolyline(self?.route?.polyline ?? "")
            self?.drawCoordinates(self?.route?.polyline ?? "")
        }
        
        
    }
    
    private func drawPolyline(_ polyline: String){
            if !polyline.isEmpty{
                let polylineObj = Polyline(encodedPolyline: polyline,precision: Constants.precision)
                if let coordinates = polylineObj.coordinates,
                   !coordinates.isEmpty{
                    var polyline = PolylineAnnotation(lineCoordinates: coordinates)
                    polyline.isDraggable = false
                    polyline.lineJoin = .round
                    polyline.lineOpacity = 1.0
                    polyline.lineWidth = 8
                    polyline.lineColor = StyleColor(AppColor.routePolylineColor())
                    polylineAnnotationManager.annotations = [polyline]
                }
                
            }
        }
    private func drawCoordinates(_ currentPolyline: String) {
        let polylineObj = Polyline(encodedPolyline: currentPolyline,precision: Constants.precision)
        if let coordinates = polylineObj.coordinates,
           !coordinates.isEmpty,
           let sourceLatLng = coordinates.first,
           let destinationLatLng = coordinates.last{
            let sourceCoordinates  = CLLocationCoordinate2D(latitude: sourceLatLng.latitude, longitude: sourceLatLng.longitude)
            
            var sourceAnnotation = PointAnnotation(coordinate: sourceCoordinates)
            sourceAnnotation.image = .init(image: R.image.ic_source_marker() ?? UIImage(), name: "ic_source_marker")
            sourceAnnotation.iconAnchor = .center
            
            //Destination Annotations
            let destinationCordinates = CLLocationCoordinate2D(latitude: destinationLatLng.latitude, longitude: destinationLatLng.longitude)
            var destinationAnnotation = PointAnnotation(coordinate: destinationCordinates)
            destinationAnnotation.image = .init(image: R.image.ic_destination_marker() ?? UIImage(), name: "ic_destination_marker")
            destinationAnnotation.iconAnchor = .center
            var annotations: [PointAnnotation] = [sourceAnnotation, destinationAnnotation]
            ///Historical Places....
            if self.historicalSwitch.isOn{
                if let historicalPlaces = self.route?.historicalEvents,
                   !historicalPlaces.isEmpty{
                    for place in historicalPlaces {
                        if let lat = place.historicalEvent?.latitude,
                           let long = place.historicalEvent?.longitude{
                            let historicalCordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
                            var historicalAnnotation = PointAnnotation(coordinate: historicalCordinates)
                            historicalAnnotation.image = .init(image: R.image.ic_historical_marker() ?? UIImage(), name: "ic_historical_marker")
                            historicalAnnotation.iconAnchor = .center
                            
                            // Add the annotation to the manager in order to render it on the map.
                            annotations.append(historicalAnnotation)
                        }
                    }
                }
                
            }
            
            // Add the annotation to the manager in order to render it on the map.
            pointAnnotationManager.annotations = annotations
        }
    }
    
    
    func navigateToRouteDetailVC(route: HomeAdminRouteResponseData){
        guard let routeDetailVC = R.storyboard.runWildSB.routeDetailVC() else {return}
        routeDetailVC.route = route
        self.push(controller: routeDetailVC, hideBar: true, animated: true)
    }
    
}

//MARK: - EXTENSION FOR MAPVIEW DELEGATES -

extension TryRouteVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.mapZoom = mapView.camera.zoom
    }
    
}

//MARK: - EXTENSION FOR CLLocationManagerDelegate -

extension TryRouteVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {return}
        if let route = route,
           let lat = route.start?.latitude,
           let long = route.start?.longitude{
            let startingPosition = CLLocation(latitude: lat, longitude: long)
            let distance = startingPosition.distance(from: currentLocation)
            Constants.printLogs("Distance from start point: \(distance)")
            if distance < 3 {
                self.canStartNavigation = true
            } else {
                self.canStartNavigation = false
            }
        }
    }
    
}

//MARK: - EXTENSION FOR GetRoutePathViewModel DELEGATES -

extension TryRouteVC: GetRoutePathViewModelDelegates{
    
    func didGetGoogleRoutePath(response: GoogleRoutePathResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let route = self.route{
//            self.navigateToTryRouteNavVC(route: route)
            print("Routee", route)
        }else{
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
        }
    }
    
    func didGetGoogleRoutePathResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

extension TryRouteVC{
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(didMapStyleUpdate), name: .mapStyleChanged, object: nil)
    }
    
    @objc
    func didMapStyleUpdate(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            if let route = self.route{
//                self.setupGoogleMap(with: route)
                self.setMapBox(with: route)
            }
        }
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
}
