//
//  HomeVCRouteExtension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 03/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import MapboxMaps
import Polyline
//MARK: - EXTENSION FOR ROUTE METHODS -

extension HomeVC{
    
    func setupGoogleMap(){
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: self.sourceLatitude, longitude: self.sourceLongitude, zoom: self.mapZoom)
//        self.mapView.camera = camera
//        MapOverLayViewModel.shared.setMapStyle(self.mapView)
        
        //Draw Route...
        self.drawPolyline(path: self.routePath)
        
        // Creates a marker in the center of the map.
        let sourceMarker = GMSMarker()
        sourceMarker.title = GoWildStrings.startingPoint()
        sourceMarker.icon = R.image.ic_source_marker()
        sourceMarker.position = CLLocationCoordinate2D(latitude: self.sourceLatitude, longitude: self.sourceLongitude)
//        sourceMarker.map = self.mapView
        
        let destinationMarker = GMSMarker()
        destinationMarker.title = GoWildStrings.endPoint()
        destinationMarker.icon = R.image.ic_destination_marker()
        destinationMarker.position = CLLocationCoordinate2D(latitude: self.destinationLatitude, longitude: self.destinationLongitude)
//        destinationMarker.map = self.mapView
        
        self.mapViewContainer.bringSubviewToFront(self.mapOverlayBtn)
        self.mapViewContainer.bringSubviewToFront(self.mapZoomInBtn)
        self.mapViewContainer.bringSubviewToFront(self.mapZoomOutBtn)
        
        ///Historical Places....
        if self.historicalSwitch.isOn{
            if !self.historicalEvents.isEmpty{
                for place in self.historicalEvents {
                    if let lat = place.historicalEvent?.latitude,
                       let long = place.historicalEvent?.longitude,
                       let title = place.title,
                       let subtitle = place.subtitle{
                        let historicalMarker = GMSMarker()
                        historicalMarker.title = title
                        historicalMarker.snippet = subtitle
                        historicalMarker.icon = R.image.ic_historical_marker()
                        historicalMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
//                        historicalMarker.map = self.mapView
                    }
                }
            }
        }
        
    }
    
    func setMapBox(container: UIView) {
        
        let myResourceOptions = ResourceOptions(accessToken: ConfigurationManager.shared.getMapBoxAccessToken())
        let resourceCoordinates = CLLocationCoordinate2D(latitude: self.sourceLatitude, longitude: self.sourceLongitude)
        let horizontalPadding = (mapViewContainer.frame.width - (mapViewContainer.frame.height / 1.2)) / 2
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
            container.addSubview(mapView)
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: container.topAnchor),
                mapView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                mapView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                mapView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ])
            didTapMap()
            polylineAnnotationManager = mapView.annotations.makePolylineAnnotationManager()
            pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
            container.bringSubviewToFront(self.mapOverlayBtn)
            container.bringSubviewToFront(self.mapZoomInBtn)
            container.bringSubviewToFront(self.mapZoomOutBtn)
        }
        
        MapOverLayViewModel.shared.setMapStyle(self.mapView)
        mapView.camera.fly(to: cameraOptions, duration: 1.5)
        
        mapView.mapboxMap.onNext(event: .mapLoaded) { [weak self] event in
            self?.drawPolyline(self?.routePath ?? "")
            self?.drawCoordinates(self?.routePath ?? "")
        }
           

    }
    
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
            sourceAnnotation.iconAnchor = .top
            
            //Destination Annotations
            let destinationCordinates = CLLocationCoordinate2D(latitude: destinationLatLng.latitude, longitude: destinationLatLng.longitude)
            var destinationAnnotation = PointAnnotation(coordinate: destinationCordinates)
            destinationAnnotation.image = .init(image: R.image.ic_destination_marker() ?? UIImage(), name: "ic_destination_marker")
            destinationAnnotation.iconAnchor = .top
            var annotations: [PointAnnotation] = [sourceAnnotation, destinationAnnotation]
            ///Historical Places....
            self.historicalSwitch.isOn = true
            if self.historicalSwitch.isOn{
                if !self.historicalEvents.isEmpty{
                    for place in self.historicalEvents {
                        if let lat = place.historicalEvent?.latitude,
                           let long = place.historicalEvent?.longitude{
                            let historicalCordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
                            var historicalAnnotation = PointAnnotation(coordinate: historicalCordinates)
                            historicalAnnotation.image = .init(image: R.image.ic_historical_marker() ?? UIImage(), name: "ic_historical_marker")
                            historicalAnnotation.iconAnchor = .top
                            
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
    
    func createMapRoutesAt(index: Int){
        if let sourceLat = self.arrayOfCurrentRoutes[index].start?.latitude,
           let sourceLng = self.arrayOfCurrentRoutes[index].start?.longitude,
           let destinationLat = self.arrayOfCurrentRoutes[index].end?.latitude,
           let destinationLng = self.arrayOfCurrentRoutes[index].end?.longitude,
           let historicalEvents = self.arrayOfCurrentRoutes[index].historicalEvents{
//            self.mapView.clear()
            self.sourceLatitude = sourceLat
            self.sourceLongitude = sourceLng
            self.destinationLatitude = destinationLat
            self.destinationLongitude = destinationLng
            self.historicalEvents.removeAll()
            self.historicalEvents = historicalEvents
            self.mapZoom = 16.0
            self.routePath = self.arrayOfCurrentRoutes[index].polyline ?? ""
            self.loadMap = true
        }
    }
    
}

//MARK: - EXTENSION FOR MAPVIEW DELEGATES -

extension HomeVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.mapZoom = mapView.camera.zoom
    }
    
}

//MARK: - HOME ROUTE CELL METHODS -

extension HomeVC{
    
    func configureHomeRouteCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.routeTableView.dequeueReusableCell(withIdentifier: .homeRouteSubCell, for: indexPath) as! HomeRouteSubCell
        
        let route = self.arrayOfCurrentRoutes[indexPath.row]
        cell.titleLbl.text = route.title
        cell.milesLbl.text = "\(Constants.getDistannceInMiles(distanceMiles: route.miles)) \(GoWildStrings.miles())"
        cell.durationLbl.text = route.duration
        cell.meterLbl.text = "\(route.meters ?? 0)\(GoWildStrings.meter())"
        
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(route.picture ?? "")"){
            cell.mapView.kf.indicatorType = .activity
            cell.mapView.kf.setImage(with: imageURL)
        }
        
        if currentSelectedRouteIndex == indexPath.row{
            cell.backView.borderColor = AppColor.textLightOrangeColor()
            cell.backView.backgroundColor = AppColor.appOrangeBgColor()
            cell.btnStackView.isHidden = false
            cell.spacerView.isHidden = true
        }else{
            cell.backView.borderColor = AppColor.cardBorderColor()
            cell.backView.backgroundColor = AppColor.appWhiteColor()
            cell.btnStackView.isHidden = true
            cell.spacerView.isHidden = false
        }
        
        if (self.currentSelectedRouteIndex == indexPath.row){
            cell.leaderboardTableView.isHidden = false
            cell.meterLbl.isHidden = true
        }else{
            cell.leaderboardTableView.isHidden = true
            cell.meterLbl.isHidden = false
        }
        
        if (self.currentSelectedRouteIndex == indexPath.row){
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
                        cell.arrayOfLeaderboard = leaderboardList
                    }else{
                        cell.arrayOfLeaderboard = leaderboardList
                    }
                    
                }else{
                    let currentUserLeaderboard = HomeAdminRouteLeaderboard(id: UUID().uuidString, userID: UserManager.shared.id, name: UserManager.shared.firstName, image: UserManager.shared.picture, rank: 0)
                    leaderboardList.append(currentUserLeaderboard)
                    cell.arrayOfLeaderboard = leaderboardList
                }
                cell.leaderboardTableView.isHidden = false
                
                cell.meterLbl.isHidden = true
            }else{
                cell.leaderboardTableView.isHidden = true
                cell.meterLbl.isHidden = false
            }
        }else{
            cell.leaderboardTableView.isHidden = true
            cell.meterLbl.isHidden = false
        }
        
        if let isSaved = route.saved{
            if isSaved{
                cell.saveBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
                cell.saveBtn.backgroundColor = AppColor.textLightOrangeColor()
                cell.saveBtn.setTitle(GoWildStrings.unSave(), for: .normal)
            }else{
                cell.saveBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
                cell.saveBtn.backgroundColor = AppColor.appWhiteColor()
                cell.saveBtn.setTitle(GoWildStrings.save(), for: .normal)
            }
        }else{
            cell.saveBtn.setTitleColor(AppColor.textLightOrangeColor(), for: .normal)
            cell.saveBtn.backgroundColor = AppColor.appWhiteColor()
            cell.saveBtn.setTitle(GoWildStrings.save(), for: .normal)
        }
        
        cell.tryRouteBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
//            if route.currentUserLeaderboard == nil{
                if !LocationManager.shared.userDeniedLocation{
                    self.navigateToTryRouteVC(route: route)
                }else{
                    AlertControllers.showAlertMessage(inVC: self, title: GoWildStrings.alert(), message: GoWildStrings.locationEnabledError()) {
                        self.openAppSettings()
                    } cancel: {
                        self.dismiss(animated: true)
                    }
                }
//            }else{
//                AlertControllers.showAlert(inVC: self, message: GoWildStrings.alreadyTryThisRouteError())
//            }
        }
        
        cell.saveBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            guard let routeID = route.id else {return}
            LoaderView.shared.showSpiner(inVC: self)
            let request = SaveRouteRequest(routeID: routeID)
            self.saveRouteViewModel.getMyTrailsCreatedRoutes(request: request)
        }
        
        cell.detailBtn.addTapGestureRecognizer { [weak self] in
            self?.navigateToRouteDetailVC(route: route)
        }
        
        return cell
    }
    
    private func navigateToTryRouteVC(route: HomeAdminRouteResponseData){
        guard let tryRouteVC = R.storyboard.tryRouteSB.tryRouteVC() else {return}
        tryRouteVC.route = route
        self.push(controller: tryRouteVC, hideBar: true, animated: true)
    }
    
}

//MARK: - EXTENSION FOR ROUTE CELL DELEGATES -

extension HomeVC{
    
    func setRouteSection(){
        if !self.routeSectionBtn.isSelected {
            LoaderView.shared.showSpiner(inVC: self)
            self.retrieveRoutesViewModel.retrieveAdminRoutes(currentPage: self.routesCurrentPage)
        }else{
            self.routesCurrentPage = 0
            self.arrayOfAdminRoutes.removeAll()
            self.arrayOfCurrentRoutes.removeAll()
            DispatchQueue.main.async {
                self.routeTableView.reloadData()
            }
        }
        self.routeSectionBtn.isSelected = !self.routeSectionBtn.isSelected
        UIView.animate(withDuration: 0.3) {
            self.routeSubSectionView.isHidden = true
        }
    }
    
    func didGetPreviousAdminRoutes(){
        let currentCount = (self.currentRouteListLastIndex - 2)
        if (currentCount > 0){
            self.currentRouteCellCount = 3
            self.currentRouteListLastIndex -= 1
            self.arrayOfCurrentRoutes.removeAll()
            let startIndex = (currentCount - 1)
            let endIndex = (currentCount + 1)
            for index in (startIndex...endIndex){
                self.arrayOfCurrentRoutes.append(self.arrayOfAdminRoutes[index])
            }
            if self.currentSelectedRouteIndex != 2{
                self.currentSelectedRouteIndex += 1
            }
            self.createMapRoutesAt(index: self.currentSelectedRouteIndex)
            DispatchQueue.main.async {
                self.routeTableView.reloadData()
            }
        }
    }
    
    func didGetNewAdminRoutes(){
        let arrayCount = self.arrayOfAdminRoutes.count
        let currentCount = self.currentRouteListLastIndex
        if currentCount < arrayCount{
            if (currentCount + 1) < arrayCount{
                self.currentRouteCellCount = 3
                self.currentRouteListLastIndex += 1
                self.arrayOfCurrentRoutes.removeAll()
                let startIndex = (currentCount - 1)
                let endIndex = (currentCount + 1)
                for index in (startIndex...endIndex){
                    self.arrayOfCurrentRoutes.append(self.arrayOfAdminRoutes[index])
                }
                if self.currentSelectedRouteIndex != 0{
                    self.currentSelectedRouteIndex -= 1
                }
                self.createMapRoutesAt(index: self.currentSelectedRouteIndex)
                DispatchQueue.main.async {
                    self.routeTableView.reloadData()
                }
            }else{
                if (self.routesCurrentPage < self.routesTotalPage){
                    LoaderView.shared.showSpiner(inVC: self)
                    self.retrieveRoutesViewModel.retrieveAdminRoutes(currentPage: self.routesCurrentPage)
                }
            }
        }
    }
    
    private func navigateToRouteDetailVC(route: HomeAdminRouteResponseData){
        guard let routeDetailVC = R.storyboard.runWildSB.routeDetailVC() else {return}
        routeDetailVC.route = route
        self.push(controller: routeDetailVC, hideBar: true, animated: true)
    }
    
}


//MARK: - EXTENSION FOR HomeRetrieveRouteViewModelDelegates -

extension HomeVC: HomeRetrieveRouteViewModelDelegates{
    
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
                        self.arrayOfAdminRoutes.append(route)
                    }
                    self.loadMap = true
                    if self.arrayOfAdminRoutes.count >= 3{
                        self.currentRouteCellCount = 3
                        self.currentRouteListLastIndex += 2
                        for index in (0...2){
                            self.arrayOfCurrentRoutes.append(self.arrayOfAdminRoutes[index])
                        }
                    }else if self.arrayOfAdminRoutes.count == 2{
                        self.currentRouteCellCount = 2
                        self.currentRouteListLastIndex += 1
                        for index in (0...1){
                            self.arrayOfCurrentRoutes.append(self.arrayOfAdminRoutes[index])
                        }
                    }else if self.arrayOfAdminRoutes.count == 1{
                        self.currentRouteCellCount = 1
                        self.currentRouteListLastIndex += 0
                        self.arrayOfCurrentRoutes.append(self.arrayOfAdminRoutes[0])
                    }else{
                        self.currentRouteCellCount = self.arrayOfCurrentRoutes.count
                        self.currentRouteListLastIndex += self.arrayOfCurrentRoutes.count
                    }
                }else{
                    for route in routeList{
                        self.arrayOfAdminRoutes.append(route)
                    }
                    self.loadMap = true
                    self.didGetNewAdminRoutes()
                }
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            if self.arrayOfAdminRoutes.count > 0{
                UIView.animate(withDuration: 0.3) {
                    self.routeSubSectionView.isHidden = false
                    self.createMapRoutesAt(index: self.currentSelectedRouteIndex)
                }
            }else{
                UIView.animate(withDuration: 0.3) {
                    self.routeSubSectionView.isHidden = true
                }
            }
            self.routeTableView.reloadData()
        }
    }
    
    func didRetrieveRoutesResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        DispatchQueue.main.async { [weak self] in
            self?.routeTableView.reloadData()
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.isPageRefreshing = false
        if self.createPostBtn.isAnimating {self.createPostBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.isPageRefreshing = false
        if self.createPostBtn.isAnimating {self.createPostBtn.hideLoading()}
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}

//MARK: - EXTENSION FOR SaveRouteViewModel DELEGATES -

extension HomeVC: SaveRouteViewModelDelegates{
    
    func didGetSaveUnSaveRoute(response: SaveRouteResponse, with routeID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        
        if let saved = response.data{
            if let index = self.arrayOfAdminRoutes.firstIndex(where: {$0.id == routeID}){
                self.arrayOfAdminRoutes[index].saved = saved
            }
            if let index = self.arrayOfCurrentRoutes.firstIndex(where: {$0.id == routeID}){
                self.arrayOfCurrentRoutes[index].saved = saved
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.routeTableView.reloadData()
        }
        AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? "")
    }
    
    func didGetSaveUnSaveRouteResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        DispatchQueue.main.async { [weak self] in
            self?.routeTableView.reloadData()
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}
