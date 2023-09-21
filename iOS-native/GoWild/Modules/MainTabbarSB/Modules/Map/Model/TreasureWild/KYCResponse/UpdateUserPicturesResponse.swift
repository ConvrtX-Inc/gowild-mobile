//
//  UpdateUserPicturesResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct UpdateUserPicturesResponse: Codable{
    let user : CurrentUserResponse?
    let message : String?
    let errors : [[String: String]]?
}
