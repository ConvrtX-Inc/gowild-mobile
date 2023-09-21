//
//  FBLoginResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct FBLoginBaseResponse: Codable{
    let token : FBLoginResponseData?
    let errors : [[String: String]]?
    let message : String?
}

struct FBLoginResponseData: Codable{
    let accessToken : String?
    let refreshToken : String?
}
