//
//  LoginRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct LoginRequest: Codable{
    let email : String
    let password : String
    let device_type : String
}
