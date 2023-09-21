//
//  MapOverlayViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import MapboxMaps

struct MapOverlayModel: Codable{
    let image : String
    let name : String
    var isSelected : Bool
}

final class MapOverLayViewModel{
    
    private init() {}
    static let shared = MapOverLayViewModel()
    
    private var arrayOfMapTypes : [MapOverlayModel] = [
        MapOverlayModel(image: .ic_street_map, name: GoWildStrings.streets(), isSelected: true),
        MapOverlayModel(image: .ic_satellite_map, name: GoWildStrings.satellite(), isSelected: false),
        MapOverlayModel(image: .ic_outdoors_map, name: GoWildStrings.outdoors(), isSelected: false)
    ]
    
    func setMapStyle(at index: Int) -> [MapOverlayModel]{
        var currentList = self.getCurrentMapStyles()
        if let currentIndex = currentList.firstIndex(where: {$0.isSelected}){
            currentList[currentIndex].isSelected = false
        }
        currentList[index].isSelected = true
        self.saveMapType(index)
        self.removeAllMapTypes()
        self.saveCurrentMap(mapList: currentList)
        return self.getCurrentMapStyles()
    }
    
    private func saveCurrentMap(mapList: [MapOverlayModel]){
        let userDefault = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(mapList){
            userDefault.setValue(encoded, forKey: .mapOverlayUpdate)
        }
    }
    
    func getCurrentMapStyles() -> [MapOverlayModel]{
        let userDefault = UserDefaults.standard
        if let data = userDefault.value(forKey: .mapOverlayUpdate) as? Data{
            if let mapStyles = try? JSONDecoder().decode([MapOverlayModel].self, from: data){
                return mapStyles.isEmpty ? self.arrayOfMapTypes : mapStyles
            }
        }
        return self.arrayOfMapTypes
    }
    
    func removeAllMapTypes(){
        let userDefaults = UserDefaults.standard
        var currentList = self.getCurrentMapStyles()
        currentList.removeAll()
        if let encoded = try? JSONEncoder().encode(currentList){
            userDefaults.setValue(encoded, forKey: .mapOverlayUpdate)
        }
    }
    
    //FOR Map Style...
    
    func setMapStyle(_ mapView: MapView){
        let selectMapType = MapOverLayViewModel.shared.getMapType()
        if selectMapType == 1{
            mapView.mapboxMap.loadStyleURI(.streets)
        }else if selectMapType == 2{
            mapView.mapboxMap.loadStyleURI(.satellite)
        }else{
            mapView.mapboxMap.loadStyleURI(.outdoors)
        }
    }
    
    private func saveMapType(_ index: Int){
        let userDefaults = UserDefaults.standard
        let mapTypeValue = (index + 1)
        userDefaults.set(mapTypeValue, forKey: .mapTypeUpdate)
    }
    
    private func getMapType() -> Int{
        let userDefaults = UserDefaults.standard
        if let mapTypeValue = userDefaults.value(forKey: .mapTypeUpdate) as? Int{
            return mapTypeValue
        }
        return 1
    }
    
    
}


extension String{
    static let mapTypeUpdate = "mapTypeUpdate"
    static let mapOverlayUpdate = "mapOverlayUpdate"
    static let ic_outdoors_map = "ic_outdoors_map"
    static let ic_street_map = "ic_street_map"
    static let ic_satellite_map = "ic_satellite_map"
}
