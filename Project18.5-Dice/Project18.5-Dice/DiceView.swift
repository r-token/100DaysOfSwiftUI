//
//  ContentView.swift
//  Project18.5-Dice
//
//  Created by Ryan Token on 10/2/21.
//

import SwiftUI
import CoreData

struct DiceView: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Roll.total, ascending: true)],
        animation: .default)
    private var rolls: FetchedResults<Roll>

    var body: some View {
        NavigationView {
            Text("Hay")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Text("Select an item")
        }
    }

    private func addItem(_ total: Int) {
        let int16Total = Int16(total)
        
        withAnimation {
            let newRoll = Roll(context: moc)
            newRoll.total = int16Total

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
