//
//  GetRouteImageRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 31/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct GetRouteImageRequest: Codable{
    let points: String
    let sourceLat: Double
    let sourceLong: Double
    let destinationLat: Double
    let destinationLong: Double
}
