//
//  MyTrailsSavedRouteResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 18/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct MyTrailsSavedRouteResponse: Codable{
    let data : [MyTrailsSavedRouteListData]?
    let currentPage : Int?
    let totalPage: Int?
    let count : Int?
    let message : String?
    let errors : [[String: String]]?
}

struct MyTrailsSavedRouteListData: Codable{
    
    let createdDate: String?
    let id: String?
    let userID: String?
    let routeID: String?
    let currentUserLeaderboard: SaveRoutesLeaderboardData?
    let route : MyTrailsSavedRouteData?
    var leaderboard: [SaveRoutesLeaderboardData]?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, route, leaderboard
        case userID = "user_id"
        case routeID = "route_id"
        case currentUserLeaderboard = "currentUser"
    }
    
}

struct MyTrailsSavedRouteData: Codable{
    
    let id: String?
    let start: MyTrailsSavedRouteLocation?
    let description: String?
    let distanceMeters: Int?
    let distanceMiles: Double?
    let createdDate: String?
    let picture: String?
    let userID: String?
    let title: String?
    let estimateTime: String?
    let path: String?
    let polyline: String?
    let role: String?
    let end: MyTrailsSavedRouteLocation?
    let status: String?
    let historicalEvents: [HomeAdminRouteHistoricalLocation]?
    
    enum CodingKeys: String, CodingKey{
        case id, start, description, createdDate, picture, title, role, end, status, historicalEvents, polyline
        case distanceMeters = "distance_meters"
        case distanceMiles = "distance_miles"
        case estimateTime = "estimate_time"
        case userID = "user_id"
        case path = "route_path"
    }
    
}

struct MyTrailsSavedRouteLocation: Codable{
    let latitude: Double?
    let longitude: Double?
}

struct SaveRoutesLeaderboardData: Codable{
    
    let id: String?
    let image: String?
    let name: String?
    let userID: String?
    let rank: Int?
    
    enum CodingKeys: String, CodingKey{
        case id, image, name, rank
        case userID = "user_id"
    }
    
}
