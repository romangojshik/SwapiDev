//
//  People+CoreDataProperties.swift
//  
//
//  Created by Roman on 9/18/23.
//
//

import Foundation
import CoreData

@objc(People)
public class People: NSManagedObject {}

extension People {

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var gender: String?

}
