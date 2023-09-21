//
//  SuggestedDeleteResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 21/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SuggestedDeleteResponse: Codable{
    let errors : [[String: String]]?
    let message : String?
}
