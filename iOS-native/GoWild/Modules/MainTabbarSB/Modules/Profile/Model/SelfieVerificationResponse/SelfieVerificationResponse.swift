//
//  SelfieVerificationResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SelfieVerificationResponse: Codable{
    
    let selfieVerified : Bool?
    let message : String?
    let errors : [[String: String]]?
    
    enum CodingKeys: String, CodingKey{
        case selfieVerified = "selfie_verified"
        case message, errors
    }
    
}
