//
//  TileQueryResponse.swift
//  GoWild
//
//  Created by Hamid on 07/08/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct TileQueryResponse: Codable {
    let type: String?
    let features: [Feature]?

    enum CodingKeys: String, CodingKey {
        case type, features
    }
}

struct Feature: Codable {
    let type: String?
    let id: Int?
    let geometry: Geometry?
    let properties: Properties?

    enum CodingKeys: String, CodingKey {
        case type, id, geometry, properties
    }
}

struct Geometry: Codable {
    let type: String?
    let coordinates: [Double]?

    enum CodingKeys: String, CodingKey {
        case type, coordinates
    }
}

struct Properties: Codable {
    let ele: Int?
    let index: Int?
    let tilequery: TileQuery?

    enum CodingKeys: String, CodingKey {
        case ele, index, tilequery
    }
}

struct TileQuery: Codable {
    let distance: Int?
    let geometry: String?
    let layer: String?

    enum CodingKeys: String, CodingKey {
        case distance, geometry, layer
    }
}
