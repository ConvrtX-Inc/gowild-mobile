//
//  HomeRetrieveRouteResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct HomeRetrieveRouteResponse: Codable{
    let data : [HomeAdminRouteResponseData]?
    let currentPage : Int?
    let totalPage : Int?
    let errors : [[String: String]]?
    let message : String?
}

struct HomeAdminRouteResponseData: Codable{
    
    let id: String?
    let createdDate: String?
    let updatedDate: String?
    let userID: String?
    let title: String?
    let start: HomeAdminRouteLocation?
    let end: HomeAdminRouteLocation?
    let description: String?
    let role: String?
    var saved: Bool?
    let picture: String?
    let miles: Double?
    let duration: String?
    let meters: Int?
    let leaderboard : [HomeAdminRouteLeaderboard]?
    let currentUserLeaderboard : HomeAdminRouteLeaderboard?
    let path: String?
    let polyline: String?
    let historicalEvents: [HomeAdminRouteHistoricalLocation]?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, updatedDate, title, start, end, description, role, saved, picture, leaderboard, historicalEvents
        case userID = "user_id"
        case miles = "distance_miles"
        case duration = "estimate_time"
        case meters = "distance_meters"
        case path = "route_path"
        case polyline = "polyline"
        case currentUserLeaderboard = "crr_user_leaderboard"
    }
    
}

struct HomeAdminRouteLocation: Codable{
    let latitude: Double?
    let longitude: Double?
}

struct HomeAdminRouteHistoricalLocation: Codable{
    
    let id: String?
    let title: String?
    let subtitle: String?
    let description: String?
    let image: String?
    let historicalEvent: HomeAdminRouteLocation?
    
    enum CodingKeys: String, CodingKey{
        case id, title, subtitle, description, image
        case historicalEvent = "historical_event"
    }
    
}

struct HomeAdminRouteLeaderboard: Codable{
    
    let id : String?
    let userID : String?
    let name : String?
    let image : String?
    let rank : Int?
    
    enum CodingKeys: String, CodingKey{
        case id, name, image, rank
        case userID = "user_id"
    }
    
}
