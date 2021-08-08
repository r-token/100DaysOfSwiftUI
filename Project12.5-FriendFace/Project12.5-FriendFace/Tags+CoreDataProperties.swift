//
//  Tags+CoreDataProperties.swift
//  Tags
//
//  Created by Ryan Token on 8/8/21.
//
//

import Foundation
import CoreData


extension Tags {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tags> {
        return NSFetchRequest<Tags>(entityName: "Tags")
    }

    @NSManaged public var name: String?
    @NSManaged public var user: NSSet?

    public var wrappedName: String {
        name ?? "Unknown tag name"
    }
    
    public var userArray: [User] {
        let set = user as? Set<User> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for user
extension Tags {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension Tags : Identifiable {

}
