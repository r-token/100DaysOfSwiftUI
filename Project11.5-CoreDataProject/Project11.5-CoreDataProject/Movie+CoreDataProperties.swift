//
//  Movie+CoreDataProperties.swift
//  Project11.5-CoreDataProject
//
//  Created by Ryan Token on 8/3/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
	
	@NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
	
	// this lets us not need to use nil coalescing whenever we want to access a managedObjectContext property
	public var wrappedTitle: String {
		title ?? "Unknown Title"
	}
	
	public var wrappedDirector: String {
		director ?? "Unknown Director"
	}
}

extension Movie : Identifiable {

}
