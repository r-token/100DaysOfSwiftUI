//
//  User+CoreDataProperties.swift
//  User
//
//  Created by Ryan Token on 8/8/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var friends: NSSet?

    public var wrappedAbout: String {
        about ?? "Unknown about"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown email"
    }
    
    public var wrappedId: String {
        id ?? "Unknown ID"
    }
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    public var wrappedRegistered: String {
        registered ?? "Unknown registered"
    }
    
    public var wrappedTags: [String] {
        tags ?? [""]
    }
    
    public var friendArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return Array(set)
    }
}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension User : Identifiable {

}
