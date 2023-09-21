//
//  MapBoxTryRouteNavigationVCMethodExtension.swift
//  GoWild
//
//  Created by SA - Muhammad Hamza on 01/08/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import CoreLocation
import MapboxMaps
import Polyline

extension MapBoxTryRouteNavigationVC{
    
    //MARK: - FIRST TIME SETUP MAPBOX -
    
    func setMapBox() {
        if let route = self.route,
           let originLatitude = route.start?.latitude,
           let originLongitude = route.start?.longitude{
            
            let myResourceOptions = ResourceOptions(accessToken: ConfigurationManager.shared.getMapBoxAccessToken())
            let resourceCoordinates = CLLocationCoordinate2D(latitude: originLatitude, longitude: originLongitude)
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
                mapView.location.options.puckType = .puck2D(Puck2DConfiguration(topImage: R.image.ic_current_location_image_green(),bearingImage: R.image.ic_current_location_image_green(),shadowImage: nil,scale: .constant(0.40),pulsing: .none))
                self.mapViewContainer.addSubview(mapView)
                NSLayoutConstraint.activate([
                    mapView.topAnchor.constraint(equalTo: mapViewContainer.topAnchor),
                    mapView.bottomAnchor.constraint(equalTo: mapViewContainer.bottomAnchor),
                    mapView.leadingAnchor.constraint(equalTo: mapViewContainer.leadingAnchor),
                    mapView.trailingAnchor.constraint(equalTo: mapViewContainer.trailingAnchor)
                ])
                polylineManager = mapView.annotations.makePolylineAnnotationManager()
                userPolylineManager = mapView.annotations.makePolylineAnnotationManager()
                pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
                //                self.bearing = CLLocationDirection(self.mapView.location.options.puckBearing.hashValue)
                
                //                self.cameraLocationConsumer = CameraLocationConsumer(mapView: self.mapView, mapZoom: self.mapZoom, bearing: self.bearing, delegates: self)
                
            }
            
            mapView.mapboxMap.onNext(event: .mapLoaded) { [weak self] _ in
                guard let self = self else {return}
                self.drawPolyline()
                self.drawStartEndPoints()
                //                self.mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
            }
            
            MapOverLayViewModel.shared.setMapStyle(self.mapView)
            self.mapView.location.delegate = self
            //            mapView.camera.fly(to: cameraOptions, duration: 1.5)
            
        }else{
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
        }
    }
    
    //MARK: - DRAW MAIN POLYLINE -
    
    private func drawPolyline(){
        if !self.currentPolyline.isEmpty{
            let polylineObj = Polyline(encodedPolyline: self.currentPolyline,precision: Constants.precision)
            if let coordinates = polylineObj.coordinates,
               !coordinates.isEmpty{
                var polyline = PolylineAnnotation(lineCoordinates: coordinates)
                polyline.isDraggable = false
                polyline.lineJoin = .round
                polyline.lineOpacity = 1.0
                polyline.lineWidth = 60
                polyline.lineColor = StyleColor(AppColor.routePolylineColor())
                polylineManager.annotations.append(polyline)
            }
        }
    }
    
    //MARK: - DRAW START AND END POINT -
    
    private func drawStartEndPoints(){
        let polylineObj = Polyline(encodedPolyline: self.currentPolyline,precision: Constants.precision)
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
            if historicalEventsEnabled{
                if let historicalEvents = self.route?.historicalEvents,
                   !historicalEvents.isEmpty{
                    for place in historicalEvents {
                        if let lat = place.historicalEvent?.latitude,
                           let long = place.historicalEvent?.longitude{
                            let historicalCordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
                            var historicalAnnotation = PointAnnotation(coordinate: historicalCordinates)
                            historicalAnnotation.iconAnchor = .center
                            historicalAnnotation.image = .init(image: R.image.ic_historical_marker() ?? UIImage(), name: "ic_historical_marker")
                            
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
    
    //MARK: - LOCATION METHODS -
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = .other
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func stopLocation(){
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }
    
    func showHistoricalInformation(for place: HomeAdminRouteHistoricalLocation) {
        if let historicalImage = place.image,
           let title = place.title,
           let desc = place.description{
            self.mapViewContainer.alpha = 0.5
            let imageUrl = URL(string: "\(UserManager.shared.getBaseURL())\(historicalImage)")
            self.historicalImg.kf.indicatorType = .activity
            self.historicalImg.kf.setImage(with: imageUrl, placeholder: UIImage())
            self.historicalLbl.text = title
            self.historicalDiscreptionLbl.text = desc
            self.historicalView.isHidden = false
        }
    }
    
    func setHistoricalInformation(isShowingTitle: Bool) {
        if !isShowingTitle{
            historicalImg.isHidden = true
            crossBtn.isHidden = true
            historicalLbl.isHidden = true
            infoLbl.isHidden = false
            historicalDiscreptionsStack.isHidden = false
        } else {
            historicalDiscreptionsStack.isHidden = true
            infoLbl.isHidden = true
            historicalImg.isHidden = false
            crossBtn.isHidden = false
            historicalLbl.isHidden = false
            historicalView.isHidden = true
            mapViewContainer.alpha = 1.0
            showHistoryPopUp = true
        }
        
    }
    //MARK: - SOME DECODER FUNCTION -
    
    private func decodePolyline(from string: String) -> LineString?{
        var lineString: LineString?
        do{
            guard let data = string.data(using: .utf8) else {return nil}
            lineString = try JSONDecoder().decode(LineString.self, from: data)
        }catch{
            Constants.printLogs(error.localizedDescription)
        }
        return lineString
    }
    
    private func decodeGeoJson(from string: String) -> FeatureCollection?{
        var featureCollection: FeatureCollection?
        do{
            guard let data = string.data(using: .utf8) else {return nil}
            featureCollection = try JSONDecoder().decode(FeatureCollection.self, from: data)
        }catch{
            Constants.printLogs(error.localizedDescription)
        }
        return featureCollection
    }
    
    private func decodeGeoJson(from string: String) -> GeoJSONSource?{
        var geoJSONSource: GeoJSONSource?
        do{
            guard let data = string.data(using: .utf8) else {return nil}
            geoJSONSource = try JSONDecoder().decode(GeoJSONSource.self, from: data)
        }catch{
            Constants.printLogs(error.localizedDescription)
        }
        return geoJSONSource
    }
    //    func didUpdateUserLocation(newLocation: Location) {
    ////        guard newLocation.horizontalAccuracy < 30 else { return }
    //        if let lastCoordinates = self.lastCoordinates{
    //            let distance = lastCoordinates.distance(to: newLocation.coordinate)
    //            Constants.printLogs("Travelled Distance: \(distance)")
    //            if distance > 1{
    //                self.lastCoordinates = newLocation.coordinate
    //                self.arrayOfCoordinates.append(newLocation.coordinate)
    //                if !self.arrayOfCoordinates.isEmpty{
    //                    var userPolyline = PolylineAnnotation(lineCoordinates: self.arrayOfCoordinates)
    //                    userPolyline.isDraggable = false
    //                    userPolyline.lineJoin = .round
    //                    userPolyline.lineOpacity = 1.0
    //                    userPolyline.lineWidth = 8
    //                    userPolyline.lineColor = StyleColor(AppColor.userPolylineColor())
    //                    self.userPolylineManager.annotations.append(userPolyline)
    //                }
    //            } else {
    //                self.lastCoordinates = newLocation.coordinate
    //            }
    //        }
    //    }
}

//MARK: EXTENSION FOR CameraLocationConsumerDelegates -
//
//extension MapBoxTryRouteNavigationVC: CameraLocationConsumerDelegates{
//
//    func didUpdateUserLocation(newLocation: Location) {
//        guard newLocation.horizontalAccuracy < 30 else { return }
//        if let lastCoordinates = self.lastCoordinates{
//            let distance = lastCoordinates.distance(to: newLocation.coordinate)
//            Constants.printLogs("Distance: \(distance)")
//            let distanceThreshold = max((self.locationManager.location?.horizontalAccuracy ?? 30) * 2, 50)
//            if distance > distanceThreshold{
//                self.lastCoordinates = newLocation.coordinate
//                self.arrayOfCoordinates.append(newLocation.coordinate)
//                if !self.arrayOfCoordinates.isEmpty{
//                    var userPolyline = PolylineAnnotation(lineCoordinates: self.arrayOfCoordinates)
//                    userPolyline.isDraggable = false
//                    userPolyline.lineJoin = .round
//                    userPolyline.lineOpacity = 1.0
//                    userPolyline.lineWidth = 8
//                    userPolyline.lineColor = StyleColor(AppColor.userPolylineColor())
//                    self.userPolylineManager.annotations.append(userPolyline)
//                }
//            } else {
//                self.lastCoordinates = newLocation.coordinate
//            }
//        }
//    }
//
//}
//
//MARK: - Create class which conforms to LocationConsumer, update the camera's centerCoordinate when a locationUpdate is received -

//class CameraLocationConsumer: LocationConsumer {
//
//    weak var mapView: MapView?
//    var mapZoom: CGFloat?
//    var bearing: CLLocationDirection?
//    weak var delegates: CameraLocationConsumerDelegates?
//
//    init(mapView: MapView, mapZoom: Float, bearing: CLLocationDirection,delegates: CameraLocationConsumerDelegates) {
//        self.mapView = mapView
//        self.mapZoom = CGFloat(mapZoom)
//        self.bearing = bearing
//        self.delegates = delegates
//    }
//
//    public func locationUpdate(newLocation: Location) {
//        if let newZoom = mapView?.cameraState.zoom{
//            self.mapZoom = newZoom
//        }
//        mapView?.camera.ease(
//            to: CameraOptions(center: newLocation.coordinate, zoom: self.mapZoom,bearing: self.bearing),
//            duration: 1.3)
//        if let newBearing = newLocation.headingDirection{
//            self.bearing = newBearing
//        }
//        self.delegates?.didUpdateUserLocation(newLocation: newLocation)
//    }
//
//}
//
//protocol CameraLocationConsumerDelegates: AnyObject{
//    func didUpdateUserLocation(newLocation: Location)
//}
