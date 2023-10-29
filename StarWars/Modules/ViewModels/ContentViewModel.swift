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
    public let model: String?
    public let manufacturer: String?
    public let passengers: String?
    public var starships: [Starship] = []

    
    init(
        type: SearchType = SearchType.none,
        id: Int? = nil,
        name: String? = nil,

        gender: String?  = nil,
        diameter: String? = nil,
        population: String? = nil,
        
        model: String? = nil,
        manufacturer: String? = nil,
        passengers: String? = nil
        
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
        
        fetchPeople()
        fetchStarship()
    }
    
    // MARK: - Private Methods

    private mutating func fetchPeople() {
        people = CoreDataManager.shared.fetchPeople()
    }
    
    private mutating func fetchStarship() {
        starships = CoreDataManager.shared.fetchStarships()
    }
    
    // MARK: - Public Methods
    
    public mutating func createPerson(name: String, gender: String) {
//            guard people.first(where: { $0.name == contentViewModel.name}) == nil else { return }
        
        let id = UInt16.arc4random()
        CoreDataManager.shared.createPerson(
            id: Int32(id),
            name: name,
            gender: gender
        )
        fetchPeople()
        CoreDataManager.shared.isUpdate = true
    }
    
    public mutating func deletePerson(id: Int) {
        CoreDataManager.shared.deletePerson(id: Int32(id))
        people = CoreDataManager.shared.fetchPeople()
    }
}
