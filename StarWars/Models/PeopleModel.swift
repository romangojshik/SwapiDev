//
//  Model.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import Foundation

struct PeopleModel: Codable {
    let name: String
    let gender: String
    let vehicles: [String]
}
