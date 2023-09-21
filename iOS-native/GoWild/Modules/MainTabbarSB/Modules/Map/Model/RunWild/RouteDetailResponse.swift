//
//  RouteDetailResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 20/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct RouteDetailResponse: Codable{
    let data : HomeAdminRouteResponseData?
    let errors : [[String: String]]?
    let message : String?
}
