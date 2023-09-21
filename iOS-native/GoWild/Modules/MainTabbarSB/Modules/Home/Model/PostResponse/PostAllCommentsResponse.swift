//
//  PostAllCommentsResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct PostAllCommentsResponse: Codable{
    let data: [PostComment]?
    let errors : [[String: String]]?
    let message : String?
}

struct PostComment: Codable{
    let id: String?
    let message: String?
    let user : PostCommentUser?
    enum CodingKeys: String, CodingKey{
        case id, message
        case user = "user_id"
    }
}

struct PostCommentUser: Codable{
    let id : String?
    let firstName: String?
    let lastName: String?
    let picture: String?
}
