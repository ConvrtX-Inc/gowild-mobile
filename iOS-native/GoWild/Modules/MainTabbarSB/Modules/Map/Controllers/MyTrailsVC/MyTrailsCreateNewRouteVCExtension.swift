//
//  MyTrailsCreateNewRouteVCExtension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 31/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import GoogleMaps


//MARK: - EXTENSION FOR API METHODS -

//MARK: - EXTENSION FOR ROUTE DELETE VIEW MODEL DELEGATES -

extension MyTrailsCreateNewRouteVC: DeleteCreatedRouteViewModelDelegates{
    
    func didDeleteCreatedRoute(response: DeleteCreatedRouteResponse, routeID: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.delegates?.didDeleteRouteOf(routeID: self.routeID)
        self.navigationController?.popViewController(animated: true)
    }
    
    func didGetDeleteCreatedRouteResponseWith(error: String) {
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

//MARK: - EXTENSION FOR UPDATE ROUTE VIEWMODEL DELEGATES -

extension MyTrailsCreateNewRouteVC: UpdateRouteViewModelDelegates{
    
    func didGetUpdateRoute(response: CreateNewRouteResponse) {
        if let imageData = routeImageData{
            self.newRouteUpdatePictureVM.updateNewRoutePicture(routeID: self.routeID, imageData: imageData)
        }else{
            LoaderView.shared.hideLoader(fromVC: self)
            if let route = response.data{
                self.delegates?.didUpdateRouteOf(route: route)
            }
            AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? ""){
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func didGetUpdateRouteResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR CREATE NEW ROUTE VIEWMODEL DELEGATES -

extension MyTrailsCreateNewRouteVC: CreateNewRouteViewModelDelegates{
    
    func didGetCreateNewRoute(response: CreateNewRouteResponse) {
        if let imageData = routeImageData,
           let newRouteID = response.data?.id{
            self.newRouteUpdatePictureVM.updateNewRoutePicture(routeID: newRouteID, imageData: imageData)
        }else{
            LoaderView.shared.hideLoader(fromVC: self)
            AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? ""){
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func didGetCreateNewRouteResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR NEW ROUTE UPDATE IMAGE VIEWMODEL DELEGATES -

extension MyTrailsCreateNewRouteVC: NewRouteUpdatePictureViewModelDelegates{
    
    func didUpdateNewRoutePicture(response: NewRouteUpdatePictureResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if self.mode == .newRoute{
            AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? ""){
                self.navigationController?.popToRootViewController(animated: true)
            }
        }else{
            if let route = response.data{
                self.delegates?.didUpdateRouteOf(route: route)
            }
            AlertControllers.showAlert(inVC: self,title: GoWildStrings.success(), message: response.message ?? ""){
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func didUpdateNewRoutePictureResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
}

//MARK: - EXTENSION FOR MAP METHODS -

extension MyTrailsCreateNewRouteVC{
    
    func setupGoogleMap(){
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        if ((self.sourceLatitude != 0.0) && (self.destinationLatitude != 0.0)){
            let camera = GMSCameraPosition.camera(withLatitude: self.sourceLatitude, longitude: self.sourceLongitude, zoom: self.mapZoom)
            self.mapView.camera = camera
        }
//        MapOverLayViewModel.shared.setMapStyle(self.mapView)
        
        //Draw Route...
        self.drawPolyline(path: self.routePath)
        
        // Creates a marker in the center of the map.
        if ((self.sourceLatitude != 0.0) && (self.sourceLongitude != 0.0)){
            let sourceMarker = GMSMarker()
            sourceMarker.title = GoWildStrings.startingPoint()
            sourceMarker.icon = R.image.ic_source_marker()
            sourceMarker.position = CLLocationCoordinate2D(latitude: self.sourceLatitude, longitude: self.sourceLongitude)
            sourceMarker.map = self.mapView
        }
        
        if ((self.destinationLatitude != 0.0) && (self.destinationLongitude != 0.0)){
            let destinationMarker = GMSMarker()
            destinationMarker.title = GoWildStrings.endPoint()
            destinationMarker.icon = R.image.ic_destination_marker()
            destinationMarker.position = CLLocationCoordinate2D(latitude: self.destinationLatitude, longitude: self.destinationLongitude)
            destinationMarker.map = self.mapView
        }
    }
    
    func drawPolyline(path: String){
        if let path = GMSPath(fromEncodedPath: path){
            self.mapView.clear()
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 3
            polyline.strokeColor = AppColor.routePolylineOrangeColor()
            let bounds = GMSCoordinateBounds(path: path)
            self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
            polyline.map = self.mapView
        }
    }
    
}

//MARK: - EXTENSION FOR MAPVIEW DELEGATES -

extension MyTrailsCreateNewRouteVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.mapZoom = mapView.camera.zoom
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        ///Map Coordinates Changes...
        if (self.sourceLatitude == 0.0){
            self.sourceLatitude = coordinate.latitude
            self.sourceLongitude = coordinate.longitude
            self.startingLatTextField.text = String(self.sourceLatitude)
            self.startingLongTextField.text = String(self.sourceLongitude)
        }else{
            self.destinationLatitude = coordinate.latitude
            self.destinationLongitude = coordinate.longitude
            self.endingLatTextField.text = String(self.destinationLatitude)
            self.endingLongTextField.text = String(self.destinationLongitude)
        }
        self.routePath = ""
        self.setupGoogleMap()
        self.getNewRoutePath()
    }
    
}


//MARK: - EXTENSION FOR GOOGLE ROUTE PATH VIEWMODEL DELEGATES -

extension MyTrailsCreateNewRouteVC: GetRoutePathViewModelDelegates{
    
    func didGetGoogleRoutePath(response: GoogleRoutePathResponse) {
        if let routes = response.routes,
           !routes.isEmpty{
            if let polyline = routes.last?.overviewPolyline,
               let points = polyline.points,
               let legs = routes.last?.legs?.first,
               let startAddress = legs.startAddress,
               let endAddress = legs.endAddress,
               let distanceInMeter = legs.distance?.value,
               let duration = legs.duration?.text{
                
                self.routePath = points
                self.distanceMeters = distanceInMeter
                self.estimateTime = duration
                self.distanceMiles = (Double(distanceInMeter) * 0.000621371)
                self.startAddress = startAddress
                self.endAddress = endAddress
                
                self.googleRouteImageVM.getRouteImage(request: GetRouteImageRequest(points: self.routePath, sourceLat: self.sourceLatitude, sourceLong: self.sourceLongitude, destinationLat: self.destinationLatitude, destinationLong: self.destinationLongitude))
                self.setupGoogleMap()
            }
        }
    }
    
    func didGetGoogleRoutePathResponseWith(error: String) {
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}

//MARK: - EXTENSION FOR GOOGLE ROUTE Image VIEWMODEL DELEGATES -

extension MyTrailsCreateNewRouteVC: GetRouteImageViewModelDelegates{
    
    func didGetGoogleRouteImage(response: Data) {
        self.routeImageData = response
    }
    
    func didGetGoogleRouteImageResponseWith(error: String) {
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}
