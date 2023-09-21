//
//  GoogleLoginResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 28/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct GoogleLoginResponse: Codable{
    let token : GoogleLoginResponseData?
    let errors : [[String: String]]?
    let message : String?
}

struct GoogleLoginResponseData: Codable{
    let accessToken : String?
    let refreshToken : String?
}
