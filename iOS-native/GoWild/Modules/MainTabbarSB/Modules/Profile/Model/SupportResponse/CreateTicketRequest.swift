//
//  CreateTicketRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct CreateTicketRequest: Codable{
    let subject : String
    let message : String
}

struct UpdateTicketAttachmentRequest: Codable{
    let messageID : String
    enum CodingKeys : String, CodingKey{
        case messageID = "message_id"
    }
}
