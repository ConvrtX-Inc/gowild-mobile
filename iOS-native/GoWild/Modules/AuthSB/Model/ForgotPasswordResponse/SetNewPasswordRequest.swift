//
//  SetNewPasswordRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SetNewPasswordRequest: Codable{
    
    let password: String
    let otpCode: String
    let phone: String
    let email: String
    
    enum CodingKeys : String, CodingKey{
        case password, phone, email
        case otpCode = "hash"
    }
    
}
