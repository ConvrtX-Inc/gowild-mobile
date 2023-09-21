//
//  SendSupportMessageResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SendSupportMessageResponse: Codable{
    let data : SupportTicketMessage?
    let message : String?
    let errors : [[String: String]]?
}
