//
//  ResetVerifyOTPRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct ResetVerifyOTPRequest: Codable{
    
    let otpCode : String
    let phoneNumber : String
    
    enum CodingKeys : String, CodingKey{
        case otpCode = "hash"
        case phoneNumber = "emailPhone"
    }
    
}
