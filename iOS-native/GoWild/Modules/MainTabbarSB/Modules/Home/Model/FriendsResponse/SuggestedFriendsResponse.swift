//
//  SuggestedFriendsResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SuggestedFriendsResponse: Codable{
    let data : [SuggestedFriendsResponseData]?
    let errors : [[String: String]]?
    let message : String?
}

struct SuggestedFriendsResponseData: Codable{
    let id: String?
    let firstName: String?
    let lastName: String?
    let fullName: String?
    let username: String?
    let email: String?
    let phoneNo: String?
    let picture: String?
    let connection: FriendsConnectionData?
}

struct FriendsConnectionData: Codable{
    let id: String?
}
