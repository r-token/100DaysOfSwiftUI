//
//  Project11_5_CoreDataProjectApp.swift
//  Project11.5-CoreDataProject
//
//  Created by Ryan Token on 8/3/21.
//

import SwiftUI

@main
struct Project11_5_CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
