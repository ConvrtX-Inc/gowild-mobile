//
//  PostAllCommentsRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct PostAllCommentsRequest: Codable{
    let postFeedId : String
    enum CodingKeys: String, CodingKey{
        case postFeedId = "postfeed_id"
    }
}
