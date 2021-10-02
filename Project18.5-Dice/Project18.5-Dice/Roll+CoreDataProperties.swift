//
//  Roll+CoreDataProperties.swift
//  Project18.5-Dice
//
//  Created by Ryan Token on 10/2/21.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var total: Int16
    @NSManaged public var timestamp: Date?

    public var wrappedTotal: Int {
        Int(total)
    }
    
    public var wrappedTimestamp: Date {
        timestamp ?? Date()
    }
}

extension Roll : Identifiable {

}
