//
//  EditProfileResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 12/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct EditProfileResponse: Codable{
    let user : CurrentUserResponse?
    let message : String?
    let errors : [[String: String]]?
}
