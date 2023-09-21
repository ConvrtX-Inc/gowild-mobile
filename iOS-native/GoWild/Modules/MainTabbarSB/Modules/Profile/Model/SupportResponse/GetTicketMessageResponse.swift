//
//  GetTicketMessageResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct GetTicketMessageResponse: Codable{
    let data : [SupportTicketMessage]?
    let currentPage : Int?
    let totalPage: Int?
    let message : String?
    let errors : [[String: String]]?
}

struct SupportTicketMessage: Codable{
    
    let id : String?
    let createdDate: String?
    let ticketID : String?
    let role : String?
    let message : String?
    let updatedDate : String?
    let userID : String?
    let attachment : [String]?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, role, message, updatedDate, attachment
        case ticketID = "ticket_id"
        case userID = "user_id"
    }
    
}

struct SupportTicketMessageAttachment: Codable{
    
    let id : String?
    let ticketID : String?
    let messageID : String?
    let attachment : String?
    
    enum CodingKeys: String, CodingKey{
        case id, attachment
        case ticketID = "ticket_id"
        case messageID = "message_id"
    }
    
}
