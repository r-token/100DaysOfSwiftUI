//
//  Project18_5_DiceApp.swift
//  Project18.5-Dice
//
//  Created by Ryan Token on 10/2/21.
//

import SwiftUI

@main
struct Project18_5_DiceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
