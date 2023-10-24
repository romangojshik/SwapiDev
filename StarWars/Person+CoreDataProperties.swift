//
//  Person+CoreDataProperties.swift
//  StarWars
//
//  Created by Roman on 10/22/23.
//
//

import CoreData

@objc(Person)
public class Person: NSManagedObject {}

extension Person {
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var gender: String?
}

extension Person : Identifiable {}
