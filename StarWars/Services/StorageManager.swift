//
//  StorageManager.swift
//  StarWars
//
//  Created by Roman on 9/18/23.
//

import CoreData
import UIKit

// MARK: - CRUD
public final class CoreDataManager: NSObject {
    // MARK: - Public Properties
    
    public static let shared = CoreDataManager()
    public var isUpdate = false
    
    // MARK: - Private Properties
    
    private var appDelegate: AppDelegate { UIApplication.shared.delegate as! AppDelegate }
    
    // MARK: - Private Methods
    
    private override init() {}
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentConatainer.viewContext
    }
    
    // MARK: - Public Methods
    
    /// Person
    public func createPerson(id: Int32, name: String, gender: String, vehicles: [String]) {
        guard let personEntityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context) else { return }
        let person = Person(entity: personEntityDescription, insertInto: context)
        person.id = id
        person.name = name
        person.gender = gender
        person.vehicles = vehicles
        
        appDelegate.saveContext()
    }
    
    public func fetchPeople() -> [Person] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            return (try? context.fetch(fetchRequest) as? [Person]) ?? []
        }
    }
    
    public func fetchPerson(id: Int32) -> Person? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let people = try? context.fetch(fetchRequest) as? [Person] ?? []
            return people?.first(where: { $0.id == id })
        }
    }
    
    public func updatePerson(id: Int32, name: String, gender: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            guard
                let people = try? context.fetch(fetchRequest) as? [Person],
                let person =  people.first
            else { return }
            person.name = name
            person.gender = gender
        }
        appDelegate.saveContext()
    }
    
    public func deletePerson(id: Int32) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            guard
                let people = try? context.fetch(fetchRequest) as? [Person],
                let person = people.first(where: { $0.id == id })
            else { return }
            context.delete(person)
        }
        appDelegate.saveContext()
    }
    
    public func deleteAllPerson() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let people = try? context.fetch(fetchRequest) as? [Person] ?? []
            people?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }
    
    /// Planet
    public func createPlanet(
        id: Int32,
        name: String,
        diameter: String,
        population: String
    ) {
        guard let planetEntityDescription = NSEntityDescription.entity(forEntityName: "Planet", in: context) else { return }
        let planet = Planet(entity: planetEntityDescription, insertInto: context)
        planet.id = id
        planet.name = name
        planet.diameter = diameter
        planet.population = population
        
        appDelegate.saveContext()
    }
    
    public func fetchPlanets() -> [Planet] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
        do {
            return (try? context.fetch(fetchRequest) as? [Planet]) ?? []
        }
    }
    
    public func fetchPlanet(id: Int32) -> Planet? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
        do {
            let planets = try? context.fetch(fetchRequest) as? [Planet] ?? []
            return planets?.first(where: { $0.id == id })
        }
    }
    
    public func updatePlanet(
        id: Int32,
        name: String,
        diameter: String,
        population: String
    ) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            guard
                let planets = try? context.fetch(fetchRequest) as? [Planet],
                let planet =  planets.first
            else { return }
            planet.name = name
            planet.diameter = diameter
            planet.population = population
        }
        
        appDelegate.saveContext()
    }
    
    public func deletePlanet(id: Int32) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
        
        do {
            guard
                let planets = try? context.fetch(fetchRequest) as? [Planet],
                let planet = planets.first(where: { $0.id == id })
            else { return }
            context.delete(planet)
        }
        
        appDelegate.saveContext()
    }
    
    public func deleteAllPlanets() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
        
        do {
            let planets = try? context.fetch(fetchRequest) as? [Planet] ?? []
            planets?.forEach { context.delete($0) }
        }
        
        appDelegate.saveContext()
    }
    
    /// Starship
    public func createStarship(
        id: Int32,
        name: String,
        model: String,
        manufacturer: String,
        passengers: String
    ) {
        guard let starshipEntityDescription = NSEntityDescription.entity(forEntityName: "Starship", in: context) else { return }
        let starship = Starship(entity: starshipEntityDescription, insertInto: context)
        starship.id = id
        starship.name = name
        starship.model = model
        starship.manufacturer = manufacturer
        starship.passengers = passengers
        
        appDelegate.saveContext()
    }
    
    public func fetchStarships() -> [Starship] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Starship")
        do {
            return (try? context.fetch(fetchRequest) as? [Starship]) ?? []
        }
    }
    
    public func fetchStarship(id: Int32) -> Starship? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Starship")
        do {
            let starships = try? context.fetch(fetchRequest) as? [Starship] ?? []
            return starships?.first(where: { $0.id == id })
        }
    }
    
    public func updateStarship(
        id: Int32,
        name: String,
        model: String,
        manufacturer: String,
        passengers: String
    ) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Starship")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            guard
                let starships = try? context.fetch(fetchRequest) as? [Starship],
                let starship =  starships.first
            else { return }
            starship.name = name
            starship.model = model
            starship.manufacturer = manufacturer
            starship.passengers = passengers
        }
        
        appDelegate.saveContext()
    }
    
    public func deleteStarship(id: Int32) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Starship")
        
        do {
            guard
                let starships = try? context.fetch(fetchRequest) as? [Starship],
                let starship = starships.first(where: { $0.id == id })
            else { return }
            context.delete(starship)
        }
        
        appDelegate.saveContext()
    }
    
    public func deleteAllStarships() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Starship")
        
        do {
            let people = try? context.fetch(fetchRequest) as? [Starship] ?? []
            people?.forEach { context.delete($0) }
        }
        
        appDelegate.saveContext()
    }
}
