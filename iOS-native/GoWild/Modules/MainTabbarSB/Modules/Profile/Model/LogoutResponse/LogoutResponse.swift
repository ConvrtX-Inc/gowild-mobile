//
//  LogoutResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 29/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct LogoutResponse: Codable{
    
    let message : String?
    let errors : [[String: String]]?
    
    enum CodingKeys: String, CodingKey{
        case message, errors
    }
    
}
