//
//  Project12_CoreDataProjectApp.swift
//  Project12-CoreDataProject
//
//  Created by Ryan Token on 8/3/21.
//

import SwiftUI

@main
struct Project12_CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CoreDataRelationshipsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
