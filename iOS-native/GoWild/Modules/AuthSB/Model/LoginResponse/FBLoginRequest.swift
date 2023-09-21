//
//  FBLoginRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct FBLoginRequest: Codable{
    
    let accessToken : String
    let deviceType : String
    
    enum CodingKeys: String, CodingKey{
        case accessToken = "access_token"
        case deviceType = "device_type"
    }
    
}
