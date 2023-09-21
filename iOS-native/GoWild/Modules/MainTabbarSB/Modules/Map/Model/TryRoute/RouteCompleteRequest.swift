//
//  RouteCompleteRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct RouteCompleteRequest: Codable{
    
    let routeID: String
    let startDate: String
    let endDate: String
    
    enum CodingKeys: String, CodingKey{
        case routeID = "route_id"
        case startDate, endDate
    }
    
}
