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
    public var planets: [Planet] = []
    
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
        fetchPlanets()
        fetchStarship()
    }
    
    // MARK: - Private Methods
    
    private mutating func fetchPeople() {
        people = CoreDataManager.shared.fetchPeople()
    }
    
    private mutating func fetchPlanets() {
        planets = CoreDataManager.shared.fetchPlanets()
    }
    
    private mutating func fetchStarship() {
        starships = CoreDataManager.shared.fetchStarships()
    }
    
    // MARK: - Public Methods
    
    /// Person
    public mutating func createPerson(name: String?, gender: String?) {
        guard
            let name = name,
            let gender = gender
        else { return }
        
        //guard people.first(where: { $0.name == contentViewModel.name}) == nil else { return }
        
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
        fetchPeople()
    }
    
    /// Planet
    public mutating func createPlanet(name: String?, diameter: String?, population: String?) {
        guard
            let name = name,
            let diameter = diameter,
            let population = population
        else { return }
        
        //guard people.first(where: { $0.name == contentViewModel.name}) == nil else { return }
        
        let id = UInt16.arc4random()
        CoreDataManager.shared.createPlanet(
            id: Int32(id),
            name: name,
            diameter: diameter,
            population: population
        )
        fetchPlanets()
        CoreDataManager.shared.isUpdate = true
    }
    
    public mutating func deletePlanet(id: Int) {
        CoreDataManager.shared.deletePlanet(id: Int32(id))
        fetchPlanets()
    }
    
    /// Starship
    public mutating func createStarship(
        name: String?,
        model: String?,
        manufacturer: String?,
        passengers: String?
    ) {
        guard
            let name = name,
            let model = model,
            let manufacturer = manufacturer,
            let passengers = passengers
        else { return }
        
        guard starships.first(where: { $0.name == name}) == nil else { return }

        let id = UInt16.arc4random()
        CoreDataManager.shared.createStarship(
            id: Int32(id),
            name: name,
            model: model,
            manufacturer: manufacturer,
            passengers: passengers
        )
        fetchStarship()
        CoreDataManager.shared.isUpdate = true
    }
    
    public mutating func deleteStarship(id: Int) {
        CoreDataManager.shared.deleteStarship(id: Int32(id))
        fetchStarship()
    }
    
}
