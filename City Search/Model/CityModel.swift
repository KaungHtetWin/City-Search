//
//  CityModel.swift
//  City Search
//
//  Created by Kaung Htet Win on 12/5/23.
//

import Foundation
// MARK: - City
struct City: Codable {
    let country, name: String
    let id: Int?
    let coord: Coord?

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}
