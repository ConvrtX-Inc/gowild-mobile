//
//  LocationManager.swift
//  GoWild
//
//  Created by SA - Haider Ali on 11/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager:NSObject, CLLocationManagerDelegate{

    var timer: Timer?
    
    var location:CLLocation!
    var lat:String = ""
    var long:String = ""
    var locationManager :CLLocationManager!
    var locationUpdated:Bool = false
    var userDeniedLocation = false
    var userEnabledLocation = true

    var shouldSendLocation: Bool = true
    
    static let shared: LocationManager = {
        let instance = LocationManager()
        
        return instance
    }()
        
    
    // MARK: - Initialization Method -
    
    override init() {
        super.init()
        location = CLLocation()
        locationManager = CLLocationManager()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {return}
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus){
        if status == .denied || status == .notDetermined || status == .restricted{
            userDeniedLocation = true
        }else{
            userDeniedLocation = false
        }
        
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first{
            locationUpdated = true
            location = loc
            lat = "\(loc.coordinate.latitude)"
            long = "\(loc.coordinate.longitude)"
            
        }
    }
    
}
