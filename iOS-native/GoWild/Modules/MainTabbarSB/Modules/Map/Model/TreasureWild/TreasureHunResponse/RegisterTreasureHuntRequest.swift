//
//  RegisterTreasureHuntRequest.swift
//  GoWild
//
//  Created by SA - Haider Ali on 22/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterTreasureHuntRequest: Codable{
    let treasureChestId : String
    enum CodingKeys: String, CodingKey{
        case treasureChestId = "treasure_chest_id"
    }
}
