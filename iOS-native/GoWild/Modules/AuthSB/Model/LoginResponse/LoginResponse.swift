//
//  LoginResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct LoginBaseResponse: Codable{
    let accessToken : String?
    let refreshToken : String?
    let errors : [[String: String]]?
    let message : String?
}
