//
//  GoogleLoginRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 28/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct GoogleLoginRequest: Codable{
    
    let idToken : String
    let deviceType : String
    
    enum CodingKeys: String, CodingKey{
        case idToken = "id_token"
        case deviceType = "device_type"
    }
    
}
