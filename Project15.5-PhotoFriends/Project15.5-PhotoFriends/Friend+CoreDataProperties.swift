//
//  Friend+CoreDataProperties.swift
//  Project15.5-PhotoFriends
//
//  Created by Ryan Token on 9/12/21.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var details: String?
    @NSManaged public var name: String?
    @NSManaged public var photoid: UUID?
    
    public var wrappedDetails: String {
        details ?? "Details Unknown"
    }
    
    public var wrappedName: String {
        name ?? "Name Unknown"
    }
    
    public var wrappedPhotoId: UUID {
        photoid ?? UUID()
    }

}

extension Friend : Identifiable {

}
