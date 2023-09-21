//
//  RouteLeaderboardResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct RouteLeaderboardResponse: Codable{
    let data : [RouteLeaderboardResponseData]?
    let totalPage: Int?
    let currentPage: Int?
    let count: Int?
    let message : String?
    let errors : [[String: String]]?
}

struct RouteLeaderboardResponseData: Codable{
    let id : String?
    let createdDate : String?
    let startDate : String?
    let endDate : String?
    let updatedDate : String?
    let user_id : String?
    let route_id : String?
    let rank : Int?
    let completionTime : String?
    let user : CurrentUserResponse?
    let route : RouteLeaderboardLocationData?
}

struct RouteLeaderboardLocationData: Codable{
    let startLocation : String?
    let endLocation : String?
}
