//
//  RouteCompleteResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct RouteCompleteResponse: Codable{
    let message : String?
    let errors : [[String: String]]?
}
