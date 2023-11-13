//
//  ContentViewModel.swift
//  StarWars
//
//  Created by Roman on 9/14/23.
//

import Foundation
import CoreData

public enum SearchType {
    case person
    case planet
    case starship
    case none
}

public struct ContentViewModel {
    /// General properties
    
    /// Model Person
    public var people: [Person] = []
    public var peopleModels = [FactoryObjectModel]()
    
    /// Model Planet
    public var planets: [Planet] = []
    public var planetModels = [FactoryObjectModel]()
    
    /// Model Starship
    public var starships: [Starship] = []
    public var starshipModels = [FactoryObjectModel]()
    
    init() {
        fetchPeople()
        fetchPlanets()
        fetchStarship()
    }
    
    // MARK: - Private Methods
    
    private mutating func fetchPeople() {
        peopleModels = []
        people = CoreDataManager.shared.fetchPeople()
        people.forEach { person in
            var personModel = FactoryObjectModel()
            personModel.makeDescriptionValue(entity: person)
            peopleModels.append(personModel)
        }
    }
    
    private mutating func fetchPlanets() {
        planets = []
        planets = CoreDataManager.shared.fetchPlanets()
        planets.forEach { planet in
            var planetModel = FactoryObjectModel()
            planetModel.makeDescriptionValue(entity: planet)
            planetModels.append(planetModel)
        }
    }
    
    private mutating func fetchStarship() {
        starships = CoreDataManager.shared.fetchStarships()
    }
    
    // MARK: - Public Methods
    
    /// Person
    public mutating func createPerson(name: String?, gender: String?, vehicles: [String]?) {
        guard
            let name = name,
            let gender = gender,
            let vehicles = vehicles
        else { return }
        
        //guard people.first(where: { $0.name == contentViewModel.name}) == nil else { return }
        
        let id = UInt16.arc4random()
        CoreDataManager.shared.createPerson(
            id: Int32(id),
            name: name,
            gender: gender,
            vehicles: vehicles
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

public struct ObjectModel {
    /// General properties
    public let type: SearchType?
    public let id: Int?
    public let name: String?
    public let favourite: Bool? = false
    
    /// Model Person
    public let gender: String?
    public let vehiclesURLStrig: [String]

    /// Model Planet
    public let diameter: String?
    public let population: String?
    
    /// Model Starship
    public let model: String?
    public let manufacturer: String?
    public let passengers: String?
    
    
    init(
        type: SearchType = SearchType.none,
        id: Int? = nil,
        name: String? = nil,
        
        gender: String?  = nil,
        vehiclesURLStrig: [String] = [],
        
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
        self.vehiclesURLStrig = vehiclesURLStrig
        
        self.diameter = diameter
        self.population = population
        
        self.model = model
        self.manufacturer = manufacturer
        self.passengers = passengers
    }
}

protocol ObjectModelProtocol {
    associatedtype Entity: NSManagedObject
    
    mutating func makeDescriptionValue(entity: Entity)
}

public struct FactoryObjectModel<T: NSManagedObject>: ObjectModelProtocol {
    typealias Entity = T
    
    public var id = 0
    public var descriptionValue: [String: String] = [:]
    
    mutating func makeDescriptionValue(entity: T) {
        switch entity {
        case let entity as Person:
            id = Int(entity.id)
            guard
                let name = entity.name,
                let gender = entity.gender,
                let countVehicles = entity.vehicles?.count
            else { return }
            descriptionValue = ["Name" : name, "Gender": gender, "Count piloted vehicles:": String(countVehicles)]
        case let entity as Planet:
            id = Int(entity.id)
            guard
                let name = entity.name,
                let diameter = entity.diameter,
                let population = entity.population
            else { return }
            descriptionValue = ["Name" : name, "Diameter": diameter, "Population": population]
        default:
            break
        }
    }
}
