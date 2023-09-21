//
//  CreatePostRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct CreatePostRequest: Codable{
    let title : String
    let description : String
    let isPublished : Bool
    enum CodingKeys: String, CodingKey{
        case title, description
        case isPublished = "is_published"
    }
}
