//
//  Project11_BookwormApp.swift
//  Project11-Bookworm
//
//  Created by Ryan Token on 7/31/21.
//

import SwiftUI

@main
struct Project11_BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
