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
    public static let shared = CoreDataManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentConatainer.viewContext
    }
    
    public func createPerson(id: Int32, name: String, gender: String) {
        guard let personEntityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context) else { return }
        let person = Person(entity: personEntityDescription, insertInto: context)
        person.id = id
        person.name = name
        person.gender = gender
        
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
            guard let people = try? context.fetch(fetchRequest) as? [Person],
                  let person =  people.first
            else { return }
            person.name = name
            person.gender = gender
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
    
    public func deletePerson(id: Int32) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            guard let people = try? context.fetch(fetchRequest) as? [Person],
                  let person = people.first(where: { $0.id == id })
            else { return }
            context.delete(person)
        }
        appDelegate.saveContext()
    }
}
