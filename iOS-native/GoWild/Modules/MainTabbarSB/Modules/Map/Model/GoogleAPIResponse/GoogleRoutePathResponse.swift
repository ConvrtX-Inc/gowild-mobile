//
//  GoogleRoutePathResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 31/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct GoogleRoutePathResponse: Codable{
    let routes: [GoogleRoutePathResponseData]?
}

struct GoogleRoutePathResponseData: Codable{
    
    let overviewPolyline : GoogleRoutePathPolylineData?
    let legs: [GoogleRoutePathLegsData]?
    
    enum CodingKeys: String, CodingKey{
        case overviewPolyline = "overview_polyline"
        case legs
    }
    
}

struct GoogleRoutePathPolylineData: Codable{
    let points: String?
}

struct GoogleRoutePathLegsData: Codable{
    
    let startAddress: String?
    let endAddress: String?
    let distance: GoogleRoutePathDistanceData?
    let duration: GoogleRoutePathDurationData?
    let steps: [GoogleRoutePathSteps]?
    
    enum CodingKeys: String, CodingKey{
        case distance, duration, steps
        case startAddress = "start_address"
        case endAddress = "end_address"
    }
    
}

struct GoogleRoutePathSteps: Codable{
    
    let distance: GoogleRoutePathDistanceData?
    let turnDirection: String?
    let endLocation: GoogleRoutePathCoordinates?
    
    enum CodingKeys: String, CodingKey{
        case distance
        case turnDirection = "maneuver"
        case endLocation = "end_location"
    }
    
}

struct GoogleRoutePathCoordinates: Codable{
    let lat: Double?
    let lng: Double?
}

struct GoogleRoutePathDistanceData: Codable{
    let text: String?
    let value : Int?
}

struct GoogleRoutePathDurationData: Codable{
    let text : String?
    let value : Int?
}
