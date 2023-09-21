//
//  CodableExtension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
    
    func asJSON() throws -> String{
        let data = try JSONEncoder().encode(self)
        guard let string = String(data: data, encoding: .utf8) else {throw NSError()}
        return string
    }
    
}
