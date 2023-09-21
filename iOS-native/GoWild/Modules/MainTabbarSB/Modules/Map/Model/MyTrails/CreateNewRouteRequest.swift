//
//  CreateNewRouteRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct CreateNewRouteRequest: Codable{
    
    let title : String
    let description : String
    let start : CreateNewRouteCoordinatesRequest
    let end : CreateNewRouteCoordinatesRequest
    let distanceMiles : Double
    let distanceMeters : Int
    let estimateTime : String
    let routePath : String
    let startLocation : String
    let endLocation : String
    
    enum CodingKeys: String, CodingKey{
        case title, description, start, end, startLocation, endLocation
        case distanceMiles = "distance_miles"
        case distanceMeters = "distance_meters"
        case estimateTime = "estimate_time"
        case routePath = "route_path"
    }
    
}

struct CreateNewRouteCoordinatesRequest: Codable{
    let latitude : Double
    let longitude : Double
}
