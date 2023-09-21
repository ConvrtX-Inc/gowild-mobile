//
//  TreasureHuntResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 20/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct TreasureHuntResponse: Codable{
    let data : [TreasureHuntResponseData]?
    let currentPage : Int?
    let totalPage: Int?
    let count : Int?
    let message : String?
    let errors : [[String: String]]?
}

struct TreasureHuntResponseData: Codable{
    let id : String?
    let createdDate : String?
    let title : String?
    let description : String?
    let picture : String?
    let location : TreasureHuntLocation?
    let eventDate : String?
    let eventTime : String?
    let status : String?
    let nmbOfParticipants : Int?
    let winnerId : String?
    var treasureHunts : [TreasureHunts]?
    let sponsors : [TreasureHuntSponsors]?
    var currentUserHunt : TreasureHunts?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, title, description, picture, location, eventDate, eventTime, status, winnerId, treasureHunts, sponsors
        case nmbOfParticipants = "no_of_participants"
        case currentUserHunt = "current_user_hunt"
    }
    
}

struct TreasureHuntLocation: Codable{
    let latitude : Double?
    let longitude : Double?
}

struct TreasureHunts: Codable{
    let id : String?
    let createdDate : String?
    let userId : String?
    let treasureChestId : String?
    let status : String?
    let winStatus : String?
    let pushSentAt : String?
    let emailSentAt : String?
    let smsSentAt : String?
    let users : CurrentUserResponse?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, status, winStatus
        case users = "user"
        case userId = "user_id"
        case treasureChestId = "treasure_chest_id"
        case pushSentAt = "push_sent_at"
        case emailSentAt = "email_sent_at"
        case smsSentAt = "sms_sent_at"
    }
    
}

struct TreasureHuntSponsors: Codable{
    let id : String?
    let createdDate : String?
    let treasureChest : String?
    let imgUrl : String?
    let img : String?
    let link : String?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, img, link
        case treasureChest = "treasure_chest"
        case imgUrl = "img_url"
    }
    
}
