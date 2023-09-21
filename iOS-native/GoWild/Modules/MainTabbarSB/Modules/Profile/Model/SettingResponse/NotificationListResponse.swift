//
//  NotificationListResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct NotificationListResponse: Codable{
    let data : [NotificationList]?
    let message : String?
    let errors : [[String: String]]?
}

struct NotificationList: Codable, Hashable{
    
    let id: String?
    let createdDate: String?
    let updatedDate: String?
    let userID: String?
    let isSeen: Bool?
    let notificationMsg: String?
    let title: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, updatedDate, type, title
        case userID = "user_id"
        case isSeen = "is_seen"
        case notificationMsg = "notification_msg"
    }
    
}
