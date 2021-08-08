//
//  Project12_5_FriendFaceApp.swift
//  Project12.5-FriendFace
//
//  Created by Ryan Token on 8/7/21.
//

import SwiftUI

@main
struct Project12_5_FriendFaceApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
