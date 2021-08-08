//
//  User+CoreDataClass.swift
//  User
//
//  Created by Ryan Token on 8/8/21.
//
//

import Foundation
import CoreData


@objc(User)
public class User: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
        // need to figure out array of tags and friends here
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(String.self, forKey: .registered)
        self.tags = try container.decode(Set<Tags>.self, forKey: .tags) as NSSet
        self.friends = try container.decode(Set<Friend>.self, forKey: .friends) as NSSet
    }
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}
