//
//  RetrieveOnePostResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 13/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RetrieveOnePostResponse: Codable{
    
    let data : RetrievePostResponseData?
    let errors : [[String: String]]?
    let message : String?
    
    enum CodingKeys: String, CodingKey{
        case data, errors, message
    }
    
}
