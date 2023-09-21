//
//  SetNewPasswordResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SetNewPasswordResponse: Codable{
    
    let responseMessage : String?
    let errors : [[String: String]]?
    
    enum CodingKeys: String, CodingKey{
        case responseMessage = "message"
        case errors
    }
    
}
