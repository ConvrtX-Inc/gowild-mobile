//
//  CreateNewRouteResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct CreateNewRouteResponse: Codable{
    let data : MyTrailsCreatedRouteData?
    let message : String?
    let errors : [[String: String]]?
}
