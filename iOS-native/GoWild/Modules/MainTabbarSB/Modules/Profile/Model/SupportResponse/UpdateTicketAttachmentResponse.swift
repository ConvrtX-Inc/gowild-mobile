//
//  UpdateTicketAttachmentResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct UpdateTicketAttachmentResponse: Codable{
    let message : String?
    let errors : [[String: String]]?
}
