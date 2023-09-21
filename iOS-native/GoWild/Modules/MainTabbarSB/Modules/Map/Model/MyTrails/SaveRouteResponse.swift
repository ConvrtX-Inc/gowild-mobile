//
//  SaveRouteResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SaveRouteResponse: Codable{
    let message : String?
    let data : Bool?
    let errors : [[String: String]]?
}
