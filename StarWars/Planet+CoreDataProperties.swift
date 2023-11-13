//
//  Planet+CoreDataProperties.swift
//  StarWars
//
//  Created by Roman on 10/30/23.
//
//

import CoreData

@objc(Planet)
public class Planet: NSManagedObject {}

extension Planet {
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var diameter: String?
    @NSManaged public var population: String?
}

extension Planet : Identifiable {}
