//
//  MessagesResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct MessagesResponse: Codable{
    let currentPage : Int?
    let totalPage : Int?
    let data : [MessagesList]?
    let message : String?
    let errors : [[String: String]]?
}

struct MessagesList: Codable{
    
    let id : String?
    let roomID : String?
    let userID : String?
    let message : String?
    let attachment : String?
    
    enum CodingKeys: String, CodingKey{
        case id, message, attachment
        case roomID = "room_id"
        case userID = "user_id"
    }
    
}
