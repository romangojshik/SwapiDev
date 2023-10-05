//
//  GeneralResponse.swift
//  StarWars
//
//  Created by Roman on 9/8/23.
//

import Foundation

class GeneralResponse<T: Codable>: Codable {
    var results: [T]
}
