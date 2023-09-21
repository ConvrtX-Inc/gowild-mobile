//
//  ForgotPasswordRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct ForgotPasswordRequest: Codable{
    
    let email : String
    let phoneNumber : String
    
    enum CodingKeys : String, CodingKey{
        case email
        case phoneNumber = "phone"
    }
    
}
