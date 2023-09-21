//
//  PostUpdatePictureResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct PostUpdatePictureResponse: Codable{
    let data : RetrievePostResponseData?
    let errors : [[String: String]]?
    let message : String?
}
