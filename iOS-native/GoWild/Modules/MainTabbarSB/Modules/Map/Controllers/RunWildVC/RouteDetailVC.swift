//
//  RouteDetailVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import MapboxMaps
import Polyline

enum RouteDetailVCType{
    case deepLink
    case _default
}

class RouteDetailVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mapBackView: UIView!
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var mapOverlayBtn: UIButton!
    @IBOutlet weak var mapZoomInBtn: UIButton!
    @IBOutlet weak var mapZoomOutBtn: UIButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var routeNameLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var distanceMilesLbl: UILabel!
    @IBOutlet weak var elevationLbl: UILabel!
    @IBOutlet weak var elevationMeterLbl: UILabel!
    @IBOutlet weak var movingTimeLbl: UILabel!
    @IBOutlet weak var movingTimeCountLbl: UILabel!
    @IBOutlet weak var maxElevationLbl: UILabel!
    @IBOutlet weak var maxElevationMeterLbl: UILabel!
    @IBOutlet weak var elapseTimeLbl: UILabel!
    @IBOutlet weak var elapseTimeCountLbl: UILabel!
    @IBOutlet weak var avgSpeedLbl: UILabel!
    @IBOutlet weak var avgSpeedCountLbl: UILabel!
    @IBOutlet weak var leaderboardBtn: LoadingButton!
    @IBOutlet weak var bottomSpacerView: UIView!
    
    
    //MARK: - PROPERTIES -
    
    private var routeDetailVM = RouteDetailViewModel()
    private var leaderboardVM = RouteLeaderboardViewModel()
    private var arrayOfLeaderboard: [RouteLeaderboardResponseData] = []
    var route : HomeAdminRouteResponseData?
    var mapZoom : Float = 16.0
    var viewAngle: Double = 30.0
    var loadMap : Bool = false{
        didSet{
            if let route = route{
                self.setMapBox(with: route)
            }
        }
    }
    
    ///For DeepLink
    var mode : RouteDetailVCType = {
        let mode : RouteDetailVCType = ._default
        return mode
    }()
    var routeID: String = ""
    var mapView: MapView!
    var pointAnnotationManager: PointAnnotationManager!
    var polylineAnnotationManager: PolylineAnnotationManager!
    private var totalPage: Int = 0
    private var currentPage: Int = 0
    var topLeaderboard : RouteLeaderboardResponseData?
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        getRouteDetails()
        getRouteLeaderboard()
        routeDetailVM.delegates = self
        leaderboardVM.delegates = self
        if let route = route{
//            setupGoogleMap(with: route)
            setMapBox(with: route)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        self.removeObservers()
        Constants.printLogs("*** RouteDetailVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = self.route?.title?.capitalized
        routeNameLbl.text = self.route?.title
        distanceLbl.text = GoWildStrings.distance()
        if mode == .deepLink{
            distanceMilesLbl.text = "-"
        }else{
            if let route = route,
               let distanceInMeters = route.meters {
                distanceMilesLbl.text = "\(distanceInMeters) \(GoWildStrings.meter())"
            }
        }
        elevationLbl.text = GoWildStrings.elevationGain()
//        elevationMeterLbl.text = "-"
        movingTimeLbl.text = GoWildStrings.movingTime()
        movingTimeCountLbl.text = topLeaderboard?.completionTime ?? "-"
        maxElevationLbl.text = GoWildStrings.maxElevation()
//        maxElevationMeterLbl.text = "-"
        elapseTimeLbl.text = GoWildStrings.elapsedTime()
        elapseTimeCountLbl.text = topLeaderboard?.completionTime ?? "-"
        avgSpeedLbl.text = GoWildStrings.avgSpeed()
        avgSpeedCountLbl.text = getRouteSpeed()
        leaderboardBtn.setTitle(GoWildStrings.leaderboard(), for: .normal)
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        mapBackView.clipsToBounds = true
        mapBackView.roundCorners([.topLeft, .topRight], radius: 20)
        routeNameLbl.font = Fonts.getSourceSansProBoldOf(size: 24)
        routeNameLbl.textColor = AppColor.bgBlackColor()
        distanceLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        distanceLbl.textColor = AppColor.textDarkGrayColor()
        distanceMilesLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 22)
        distanceMilesLbl.textColor = AppColor.bgBlackColor()
        elevationLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        elevationLbl.textColor = AppColor.textDarkGrayColor()
        elevationMeterLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 22)
        elevationMeterLbl.textColor = AppColor.bgBlackColor()
        movingTimeLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        movingTimeLbl.textColor = AppColor.textDarkGrayColor()
        movingTimeCountLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 22)
        movingTimeCountLbl.textColor = AppColor.bgBlackColor()
        maxElevationLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        maxElevationLbl.textColor = AppColor.textDarkGrayColor()
        maxElevationMeterLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 22)
        maxElevationMeterLbl.textColor = AppColor.bgBlackColor()
        elapseTimeLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        elapseTimeLbl.textColor = AppColor.textDarkGrayColor()
        elapseTimeCountLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 22)
        elapseTimeCountLbl.textColor = AppColor.bgBlackColor()
        avgSpeedLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        avgSpeedLbl.textColor = AppColor.textDarkGrayColor()
        avgSpeedCountLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 22)
        avgSpeedCountLbl.textColor = AppColor.bgBlackColor()
        mapOverlayBtn.isHidden = true
        leaderboardBtn.titleLabel?.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
        leaderboardBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        leaderboardBtn.backgroundColor = AppColor.textDarkOrangeColor()
        bottomSpacerView.roundCorners([.bottomLeft,.bottomRight], radius: 20)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
        addObservers()
    }
    
    
    private func getRouteSpeed() -> String {
        if let completionTime = self.topLeaderboard?.completionTime,
           let meter = self.route?.meters,
           !completionTime.isEmpty {
            
            let timeArr = completionTime.split(separator: ":")
            let totalSeconds = (Int(timeArr[0]) ?? 0) * 3600 + (Int(timeArr[1]) ?? 0) * 60 + (Int(timeArr[2]) ?? 0)
            let totalTimeInHours = Double(totalSeconds) / 3600
            
            let distanceInKm = Double(meter) / 1000
            let speed = distanceInKm / totalTimeInHours
            
            let formattedSpeed = String(format: "%.2f", speed)
            return "\(formattedSpeed) km/h"
            
        } else {
            return "-"
        }
    }
    
    private func getRouteDetails(){
        if self.mode == .deepLink,
           !self.routeID.isEmpty{
            LoaderView.shared.showSpiner(inVC: self)
            self.routeDetailVM.getRouteDetail(routeID: self.routeID)
        }
    }
    
    private func navigateToLeaderboardVC(){
        guard let leaderboardVC = R.storyboard.runWildSB.leaderboardVC() else {return}
        leaderboardVC.routeID = route?.id ?? ""
        self.push(controller: leaderboardVC, hideBar: true, animated: true)
    }
    
    private func getRouteLeaderboard(){
        if let route = route,
           let id = route.id{
            if self.currentPage == 0{
                LoaderView.shared.showSpiner(inVC: self)
            }
            self.leaderboardVM.getRouteLeaderboard(currentPage: self.currentPage, routeID: id)
            avgSpeedCountLbl.text = getRouteSpeed()
        }
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
                self.mapZoom += 1
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
                self.mapZoom -= 1
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
    
    
    @IBAction func didTapLeaderboardBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigateToLeaderboardVC()
        }
    }

}

//MARK: - EXTENSION FOR ROUTE DETAIL VIEWMODEL DELEGATES -

extension RouteDetailVC: RouteDetailViewModelDelegates{
    func didGettileQuery(response: TileQueryResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        setUpRouteDetails(response: response)
        
    }
    
    
    func didGetRouteDetail(response: RouteDetailResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let route = response.data{
            self.route = route
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.setText()
//                self.setupGoogleMap(with: route)
            }
        }
    }
    
    func didGetRouteDetailResponseWith(error: String) {
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
//MARK: - EXTENSION FOR Leader Board VIEWMODEL DELEGATES -
extension RouteDetailVC: RouteLeaderboardViewModelDelegates {
    func didGetRouteLeaderboard(response: RouteLeaderboardResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let totalPage = response.totalPage,
           let currentPage = response.currentPage{
            self.totalPage = totalPage
            self.currentPage = currentPage
        }
        if let leaderboardList = response.data,
           !leaderboardList.isEmpty{
            for list in leaderboardList {
                self.arrayOfLeaderboard.append(list)
            }
            self.topLeaderboard = arrayOfLeaderboard[0]
            setText()
        }
    }
    
    func didGetRouteLeaderboardResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR GOOGLE MAPS METHODS -

extension RouteDetailVC{
    
//    private func setupGoogleMap(with route: HomeAdminRouteResponseData){
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
//        if let historicalPlaces = self.route?.historicalEvents,
//           !historicalPlaces.isEmpty{
//            for place in historicalPlaces {
//                if let lat = place.historicalEvent?.latitude,
//                   let long = place.historicalEvent?.longitude,
//                   let title = place.title,
//                   let subtitle = place.subtitle{
//                    let historicalMarker = GMSMarker()
//                    historicalMarker.title = title
//                    historicalMarker.snippet = subtitle
//                    historicalMarker.icon = R.image.ic_historical_marker()
//                    historicalMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
//                    historicalMarker.map = self.mapView
//                }
//            }
//        }
//
//        self.mapView.bringSubviewToFront(self.mapOverlayBtn)
//        self.mapView.bringSubviewToFront(self.mapZoomInBtn)
//        self.mapView.bringSubviewToFront(self.mapZoomOutBtn)
//    }
    
//    func drawPolyline(path: String){
//        if let path = GMSPath(fromEncodedPath: path){
//            self.mapView.clear()
//            let polyline = GMSPolyline(path: path)
//            polyline.strokeWidth = 3
//            polyline.strokeColor = AppColor.routePolylineGreenColor()
//            let bounds = GMSCoordinateBounds(path: path)
//            self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
//            polyline.map = self.mapView
//        }
//    }
    
}
//MARK: - EXTENSION FOR MapBox MAPS METHODS -

extension RouteDetailVC {
    
    func setMapBox(with route: HomeAdminRouteResponseData) {
                guard let sourceLatitude = route.start?.latitude,
                      let sourceLongitude = route.start?.longitude else {return}
        let myResourceOptions = ResourceOptions(accessToken: ConfigurationManager.shared.getMapBoxAccessToken())
        let resourceCoordinates = CLLocationCoordinate2D(latitude: sourceLatitude, longitude: sourceLongitude)
        let horizontalPadding = (mapViewContainer.frame.width - (mapViewContainer.frame.height / 1.2)) / 2
        let cameraOptions = CameraOptions(center: resourceCoordinates,padding: UIEdgeInsets(top: 50, left: horizontalPadding, bottom: 50, right: horizontalPadding), zoom: CGFloat(self.mapZoom),pitch: 30)
        
        if mapView == nil {
            let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, cameraOptions: cameraOptions)
            mapView = MapView(frame: view.frame, mapInitOptions: myMapInitOptions)
            mapView.translatesAutoresizingMaskIntoConstraints = false
            //Handle Gesture
            mapView.gestures.options.pitchEnabled = false
            mapView.ornaments.options.scaleBar.visibility = .hidden
            mapView.ornaments.options.compass.visibility = .hidden
            mapView.ornaments.options.attributionButton.margins = .init(x: -10000, y: 0)
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
            self.mapViewContainer.bringSubviewToFront(self.mapZoomInBtn)
            self.mapViewContainer.bringSubviewToFront(self.mapZoomOutBtn)
        }
        MapOverLayViewModel.shared.setMapStyle(self.mapView)
            mapView.camera.fly(to: cameraOptions, duration: 1.5)
        mapView.mapboxMap.onNext(event: .mapLoaded) { [weak self] event in
            self?.drawCoordinates(self?.route?.polyline ?? "")
            self?.drawPolyline(self?.route?.polyline ?? "")
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
            sourceAnnotation.iconAnchor = .bottom
            
            //Destination Annotations
            let destinationCordinates = CLLocationCoordinate2D(latitude: destinationLatLng.latitude, longitude: destinationLatLng.longitude)
            var destinationAnnotation = PointAnnotation(coordinate: destinationCordinates)
            destinationAnnotation.image = .init(image: R.image.ic_destination_marker() ?? UIImage(), name: "ic_destination_marker")
            destinationAnnotation.iconAnchor = .bottom
            var annotations: [PointAnnotation] = [sourceAnnotation, destinationAnnotation]
            // Historical Annotations
            
            if let historicalPlaces = self.route?.historicalEvents,
               !historicalPlaces.isEmpty{
                for place in historicalPlaces {
                    if let lat = place.historicalEvent?.latitude,
                       let long = place.historicalEvent?.longitude{
                        
                        let historicalCordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        var historicalAnnotation = PointAnnotation(coordinate: historicalCordinates)
                        historicalAnnotation.image = .init(image: R.image.ic_historical_marker() ?? UIImage(), name: "ic_historical_marker")
                        historicalAnnotation.iconAnchor = .bottom
                        // Add the annotation to the manager in order to render it on the map.
                        annotations.append(historicalAnnotation)
                    }
                }
            }
            LoaderView.shared.showSpiner(inVC: self)
            self.routeDetailVM.getTileQueryResponse(coordinates: sourceCoordinates, radius: 10, limit: 2)
            pointAnnotationManager.annotations = annotations
        }
    }
    private func setUpRouteDetails(response: TileQueryResponse) {
        guard let feature = response.features else {
            self.elevationMeterLbl.text = "-"
            self.maxElevationMeterLbl.text = "-"
            return
        }
        if feature.count > 1 {
            if let firstEle = feature.first?.properties?.ele,
               let lastEle = feature.last?.properties?.ele {
                let gainElevation = lastEle - firstEle
                self.elevationMeterLbl.text = "\(gainElevation)"
                self.maxElevationMeterLbl.text = "\(lastEle)"
                
            }
        } else {
            self.elevationMeterLbl.text = "\(feature[0].properties?.ele ?? -1)"
            self.maxElevationMeterLbl.text = "\(feature[0].properties?.ele ?? -1)"
        }
        if let distanceMeters = self.route?.meters, let durationString = self.route?.duration, let duration = Double(durationString) {
            let averageSpeed = Double(distanceMeters) / duration
            print("Average speed in m/s: \(averageSpeed)")
//            self.avgSpeedCountLbl.text = String(averageSpeed)
        }
    }
    
}

extension RouteDetailVC{
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(didMapStyleUpdate), name: .mapStyleChanged, object: nil)
    }
    
    @objc
    func didMapStyleUpdate(){
        DispatchQueue.main.async { [weak self] in
            self?.loadMap = true
        }
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
}
