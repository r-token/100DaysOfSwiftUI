//
//  Project15_5_PhotoFriendsApp.swift
//  Project15.5-PhotoFriends
//
//  Created by Ryan Token on 9/12/21.
//

import SwiftUI

@main
struct Project15_5_PhotoFriendsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
