//
//  MyFriendsResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct MyFriendsResponse: Codable{
    let data : [MyFriendsResponseData]?
    let errors : [[String: String]]?
    let message : String?
}


struct MyFriendsResponseData: Codable{
    let id: String?
    let parentID: String?
    let user : MyFriendsData?
    let fromUserID : String?
    let toUserID : String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case parentID = "parent_id"
        case user = "to_user"
        case fromUserID = "from_user_id"
        case toUserID = "to_user_id"
    }
}

struct MyFriendsData: Codable{
    let id: String?
    let firstName: String?
    let lastName: String?
    let username: String?
    let email: String?
    let phoneNo: String?
    let picture: String?
    let roomID: String?
    let connection: FriendsConnectionData?
}
