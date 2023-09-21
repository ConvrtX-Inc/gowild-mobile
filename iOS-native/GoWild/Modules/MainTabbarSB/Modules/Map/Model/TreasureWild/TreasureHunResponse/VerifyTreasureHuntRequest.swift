//
//  VerifyTreasureHuntRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 22/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct VerifyTreasureHuntRequest: Codable{
    let treasureChestId : String
    let code : String
    enum CodingKeys: String, CodingKey{
        case code
        case treasureChestId = "treasure_chest_id"
    }
}
