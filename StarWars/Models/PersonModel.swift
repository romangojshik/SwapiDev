//
//  PersonModel.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import Foundation

struct PersonModel: Codable {
    let name: String
    let gender: String
    let vehicles: [String]
}
