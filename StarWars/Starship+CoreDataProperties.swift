//
//  Starship+CoreDataProperties.swift
//  StarWars
//
//  Created by Roman on 10/24/23.
//
//

import CoreData

@objc(Starsship)
public class Starship: NSManagedObject {}

extension Starship {
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var model: String?
    @NSManaged public var manufacturer: String?
    @NSManaged public var passengers: String?
}

extension Starship : Identifiable {}
