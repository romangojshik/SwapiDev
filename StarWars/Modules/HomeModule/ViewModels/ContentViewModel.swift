//
//  ContentViewModel.swift
//  StarWars
//
//  Created by Roman on 9/14/23.
//

import Foundation

public enum SearchType {
    case person
    case planet
    case starship
    case none
}

public struct ContentViewModel {
    /// General properties
    public let type: SearchType?
    public let id: Int?
    public let name: String?
    public let favourite: Bool? = false
    
    /// Model Person
    public let gender: String?
    public var people: [Person] = []
    
    /// Model Planet
    public let diameter: String?
    public let population: String?
    
    /// Model Starship
    let model: String?
    let manufacturer: String?
    let passengers: String?
    
    init(
        type: SearchType = SearchType.none,
        id: Int? = nil,
        name: String? = nil,

        gender: String?  = nil,
        diameter: String? = nil,
        population: String? = nil,
        
        model: String? = nil,
        manufacturer: String? = nil,
        passengers: String? = nil,
        
        people: [Person] = []
    ) {
        self.type = type
        self.id = id
        self.name = name
    
        self.gender = gender
        
        self.diameter = diameter
        self.population = population
        
        self.model = model
        self.manufacturer = manufacturer
        self.passengers = passengers
    }
}
