//
//  RegisterResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterBaseResponse: Codable{
    
    let responseData : Int?
    let responseMessage : String?
    let data : String?
    let errors : [[String: String]]?
    
    enum CodingKeys: String, CodingKey{
        case responseData = "response_data"
        case responseMessage = "message"
        case data, errors
    }
    
}
