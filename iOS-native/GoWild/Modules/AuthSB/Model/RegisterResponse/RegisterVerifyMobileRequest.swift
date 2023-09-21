//
//  RegisterVerifyMobileRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterVerifyMobileRequest: Codable{
    
    let email : String
    let phoneNumber : String
    let otpCode : String
    
    enum CodingKeys : String, CodingKey{
        case email
        case phoneNumber = "phoneNo"
        case otpCode = "otp"
    }
    
}
