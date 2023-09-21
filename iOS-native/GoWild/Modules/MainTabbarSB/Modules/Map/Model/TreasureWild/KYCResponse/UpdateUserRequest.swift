//
//  UpdateUserRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct UpdateUserRequest: Codable{
    
    let firstName : String
    let lastName : String
    let gender : String?
    let birthDate : String?
    
    enum CodingKeys : String, CodingKey{
        case firstName, lastName, gender, birthDate
    }
    
}
