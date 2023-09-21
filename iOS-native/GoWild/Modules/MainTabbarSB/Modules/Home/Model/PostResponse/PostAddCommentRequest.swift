//
//  PostAddCommentRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct PostAddCommentRequest: Codable{
    let postFeedId : String
    let message : String
    enum CodingKeys: String, CodingKey{
        case postFeedId = "postfeed_id"
        case message
    }
}
