//
//  RetrievePostResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RetrievePostResponse: Codable{
    
    let data : [RetrievePostResponseData]?
    let errors : [[String: String]]?
    let message : String?
    
    enum CodingKeys: String, CodingKey{
        case data, errors, message
    }
    
}

struct RetrievePostResponseData: Codable{
    
    let id: String?
    let description: String?
    var comments: Int?
    var likes: Int?
    let userId: String?
    let title: String?
    let img: String?
    let isPublished: Bool?
    var share: Int?
    var picture: String?
    var views: Int?
    var createdDate: String?
    var user : CurrentUserResponse?
    var userLikes : [String]?
    var attachment: [PostAttachment]?
    
    enum CodingKeys: String, CodingKey{
        case id, description, comments, likes, title, img, share, picture, views, createdDate, user, attachment
        case userId = "user_id"
        case isPublished = "is_published"
        case userLikes = "likes_images"
    }
    
}

struct PostAttachment: Codable{
    let id : String?
    let attachment : String?
}
