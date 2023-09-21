//
//  VerifyTreasureHuntResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 22/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct VerifyTreasureHuntResponse: Codable{
    let message : String?
    let errors : [[String: String]]?
}
