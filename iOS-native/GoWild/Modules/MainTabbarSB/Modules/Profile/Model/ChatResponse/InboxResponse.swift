//
//  InboxResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct InboxResponse: Codable{
    let data : [InboxList]?
    let message : String?
    let errors : [[String: String]]?
}

struct InboxList: Codable{
    
    let firstName : String?
    let lastName : String?
    let picture : String?
    let userID : String?
    let roomID : String?
    
    enum CodingKeys: String, CodingKey{
        case firstName = "first_name"
        case lastName = "last_name"
        case picture = "picture"
        case roomID = "room_id"
        case userID = "user_id"
    }
    
}
