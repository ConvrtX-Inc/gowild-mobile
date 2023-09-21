//
//  MyAchievementResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct MyAchievementResponse: Codable{
    let data : [MyAchievementResponseData]?
    let message : String?
    let errors : [[String: String]]?
}

struct MyAchievementResponseData: Codable{
    let id : String?
    let createdDate : String?
    let startDate : String?
    let endDate : String?
    let updatedDate : String?
    let user_id : String?
    let route_id : String?
    let rank : Int?
    let completionTime : String?
    let route : MyAchievementRouteData?
    let startLocation : String?
    let endLocation : String?
}

struct MyAchievementRouteData: Codable{
    let title : String?
}
