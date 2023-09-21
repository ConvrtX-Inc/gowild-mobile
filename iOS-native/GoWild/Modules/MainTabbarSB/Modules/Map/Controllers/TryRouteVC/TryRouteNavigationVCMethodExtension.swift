//
//  TryRouteNavigationVCMethodExtension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps

extension TryRouteNavigationVC{
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = .fitness
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func stopLocation(){
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }
    
    func setupNavigation(){
        if let route = self.route,
           let originLatitude = route.start?.latitude,
           let originLongitude = route.start?.longitude,
           let destinationLatitude = route.end?.latitude,
           let destinationLongitude = route.end?.longitude{
            
            let camera = GMSCameraPosition.camera(withTarget: self.currentCoordinates.coordinate, zoom: self.mapZoom, bearing: self.bearing, viewingAngle: self.viewAngle)
            self.mapView.camera = camera
            
            setupRoutePath()
            
            /// Draw Historical paths....
            if self.historicalEventsEnabled{
                
                // Creates a marker in the center of the map.
                let sourceMarker = GMSMarker()
                sourceMarker.title = GoWildStrings.startingPoint()
                sourceMarker.icon = R.image.ic_source_marker()
                sourceMarker.position = CLLocationCoordinate2D(latitude: originLatitude, longitude: originLongitude)
                sourceMarker.map = self.mapView
                
                let destinationMarker = GMSMarker()
                destinationMarker.title = GoWildStrings.endPoint()
                destinationMarker.icon = R.image.ic_destination_marker()
                destinationMarker.position = CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude)
                destinationMarker.map = self.mapView
                
                
                if let historicalPlaces = self.route?.historicalEvents,
                   !historicalPlaces.isEmpty{
                    for place in historicalPlaces {
                        if let lat = place.historicalEvent?.latitude,
                           let long = place.historicalEvent?.longitude,
                           let title = place.title,
                           let subtitle = place.subtitle{
                            let historicalMarker = GMSMarker()
                            historicalMarker.title = title
                            historicalMarker.snippet = subtitle
                            historicalMarker.icon = R.image.ic_historical_marker()
                            historicalMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                            historicalMarker.map = self.mapView
                        }
                    }
                }
            }
            
        }else{
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
        }
    }
    
}

//MARK: - EXTENSION FOR RouteCompleteViewModelDelegates -

extension TryRouteNavigationVC: RouteCompleteViewModelDelegates{
    
    func didGetRouteComplete(response: RouteCompleteResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.resultsBtn.isHidden = false
        self.isRouteCompleted = true
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


//MARK: - EXTENSION FOR GetRoutePathViewModel DELEGATES -

extension TryRouteNavigationVC: GetRoutePathViewModelDelegates{
    
    func didGetGoogleRoutePath(response: GoogleRoutePathResponse) {
        if let routes = response.routes,
           !routes.isEmpty{
            if let points = routes.last?.overviewPolyline?.points{
                self.currentPolyline = ""
                self.currentPolyline = points
            }
        }
    }
    
    func didGetGoogleRoutePathResponseWith(error: String) {
        Constants.printLogs(error)
    }
    
}

//MARK: - EXTENSION FOR MAPVIEW DELEGATES -

extension TryRouteNavigationVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.viewAngle = position.viewingAngle
        self.mapZoom = position.zoom
        self.bearing = position.bearing
    }
    
}


//MARK: - EXTENSION FOR RETRY ALERT -

extension TryRouteNavigationVC{
    
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
