//
//  SupportTicketListResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SupportTicketListResponse: Codable{
    let data : [SupportTicketList]?
    let message : String?
    let errors : [[String: String]]?
}

struct SupportTicketList: Codable{
    let id : String?
    let createdDate : String?
    let updatedDate : String?
    let userID : String?
    let messageID : String?
    let subject : String?
    let status : String?
    let user : CurrentUserResponse?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, updatedDate, subject, status, user
        case userID = "user_id"
        case messageID = "message_id"
    }
    
}
