//
//  MyTrailsCreatedRouteResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 18/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct MyTrailsCreatedRouteResponse: Codable{
    let data : [MyTrailsCreatedRouteData]?
    let currentPage : Int?
    let totalPage: Int?
    let count : Int?
    let message : String?
    let errors : [[String: String]]?
}

struct MyTrailsCreatedRouteData: Codable{
    
    let createdDate: String?
    let description: String?
    let distanceMeters: Int?
    let distanceMiles: Double?
    let end: MyTrailsCreatedRouteLocation?
    let estimateTime: String?
    let id: String?
    let picture: String?
    let role: String?
    let start: MyTrailsCreatedRouteLocation?
    let status: String?
    let title: String?
    let updatedDate: String?
    let userID: String?
    let path: String?
    let startLocation: String?
    let endLocation: String?
    let historicalEvents: [HomeAdminRouteHistoricalLocation]?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, description, end, picture, role, start, status, title, updatedDate, startLocation, endLocation, historicalEvents
        case distanceMeters = "distance_meters"
        case distanceMiles = "distance_miles"
        case estimateTime = "estimate_time"
        case userID = "user_id"
        case path = "route_path"
    }
    
}

struct MyTrailsCreatedRouteLocation: Codable{
    let latitude: Double?
    let longitude: Double?
}


struct MyCreatedSavedRouteResponseData: Codable{
    
    let id : String?
    let createdDate : String?
    let leaderboard : [CreatedRoutesLeaderboardData]?
    let route : MyTrailsCreatedRouteData?
    let routeID :  String?
    let updatedDate : String?
    let userID : String?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, leaderboard, route, updatedDate
        case routeID = "route_id"
        case userID = "user_id"
    }
    
}

struct CreatedRoutesLeaderboardData: Codable{
    
    let id: String?
    let image: String?
    let name: String?
    let userID: String?
    
    enum CodingKeys: String, CodingKey{
        case id, image, name
        case userID = "user_id"
    }
    
}


enum MyTrailsCreatedRouteEnum: String{
    case approved
    case pending
    case reject
}
