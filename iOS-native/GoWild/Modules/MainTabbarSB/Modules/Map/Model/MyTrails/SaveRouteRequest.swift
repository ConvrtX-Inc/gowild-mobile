//
//  SaveRouteRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SaveRouteRequest: Codable{
    
    let routeID: String
    
    enum CodingKeys: String, CodingKey{
        case routeID = "route_id"
    }
    
}
