//
//  Tags+CoreDataClass.swift
//  Tags
//
//  Created by Ryan Token on 8/8/21.
//
//

import Foundation
import CoreData


@objc(Tags)
public class Tags: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case name
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        self.name = try container.decode(String.self, forKey: .name)
    }
}
