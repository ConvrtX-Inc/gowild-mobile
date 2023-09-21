//
//  EditProfileRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 12/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct EditProfileRequest: Codable{
    
    let firstName : String
    let lastName : String
    let aboutMe : String
    
    enum CodingKeys : String, CodingKey{
        case firstName, lastName
        case aboutMe = "about_me"
    }
    
}
