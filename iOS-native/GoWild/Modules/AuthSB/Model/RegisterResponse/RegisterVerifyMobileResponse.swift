//
//  RegisterVerifyMobileResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterVerifyMobileResponse: Codable{
    
    let accessToken : String?
    let refreshToken : String?
    let responseMessage : String?
    let errors : [[String: String]]?
    
    enum CodingKeys: String, CodingKey{
        case accessToken, refreshToken, errors
        case responseMessage = "message"
    }
    
}
