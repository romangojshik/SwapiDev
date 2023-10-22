//
//  PersonViewModel.swift
//  StarWars
//
//  Created by Roman on 9/14/23.
//

import Foundation

public struct ContentViewModel {
    /// General properties
    public let id: Int?
    public let name: String?
    public let favourite: Bool? = false
    
    /// Model Person
    public let gender: String?
    public var people: [Person] = []
    
    /// Model Planet
    public let diameter: String?
    public let population: String?
    
    init(
        id: Int? = nil,
        name: String? = nil,
        gender: String?  = nil,
        diameter: String? = nil,
        population: String? = nil,
        people: [Person] = []
    ) {
        self.id = id
        self.name = name
        self.gender = gender
        self.diameter = diameter
        self.population = population
    }
}
