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
    
//    public func logCoreDataDBPath() {
//        if let url =
//            appDelegate.persistentConatainer.persistentStoreCoordinator.persistentStores.first?.url
//        {
//            print("DB url - \(url)")
//        }
//    }
    
    public func createPeople(id: Int32, name: String, gender: String) {
        guard let peopleEntityDescription = NSEntityDescription.entity(forEntityName: "People", in: context) else { return }
        let people = People(entity: peopleEntityDescription, insertInto: context)
        people.id = id
        people.name = name
        people.gender = gender
        
        appDelegate.saveContext()
    }
    
    public func fetchPeoples() -> [People] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
        do {
            return (try? context.fetch(fetchRequest) as? [People]) ?? []
        }
    }
    
    public func fetchPeople(id: Int32) -> People? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
        do {
            let peoples = try? context.fetch(fetchRequest) as? [People] ?? []
            return peoples?.first(where: { $0.id == id })
        }
    }
    
    public func updatePeople(id: Int32, name: String, gender: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            guard let peoples = try? context.fetch(fetchRequest) as? [People],
                  let people =  peoples.first
            else { return }
            people.name = name
            people.gender = gender
        }
        appDelegate.saveContext()
    }
    
    public func deleteAllPeoples() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
        do {
            let peoples = try? context.fetch(fetchRequest) as? [People] ?? []
            peoples?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }
    
    public func deletePeople(id: Int32) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
        do {
            guard let peoples = try? context.fetch(fetchRequest) as? [People],
                  let people = peoples.first(where: { $0.id == id })
            else { return }
            context.delete(people)
        }
        appDelegate.saveContext()
    }
}
