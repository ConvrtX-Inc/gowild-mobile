//
//  PostAddCommentResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct PostAddCommentResponse: Codable{
    let data : PostComment?
    let errors : [[String: String]]?
    let message : String?
}
