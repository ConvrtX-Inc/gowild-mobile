//
//  RegisterRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterRequest: Codable{
    
    let firstName : String
    let lastName : String
    let email : String
    let phoneNumber : String
    let password : String
    let addressOne : String
    let addressTwo : String
    let device_type : String
    
    enum CodingKeys : String, CodingKey{
        case firstName, lastName, email, password, addressOne, addressTwo, device_type
        case phoneNumber = "phoneNo"
    }
    
}
