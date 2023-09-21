//
//  RegisterSendMobileOTPRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterSendMobileOTPRequest: Codable{
    
    let email : String
    
    enum CodingKeys : String, CodingKey{
        case email = "emailPhone"
    }
    
}
