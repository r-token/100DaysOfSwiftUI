//
//  ResultsView.swift
//  Project18.5-Dice
//
//  Created by Ryan Token on 10/2/21.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Roll.total, ascending: true)],
        animation: .default)
    private var rolls: FetchedResults<Roll>
    
    var body: some View {
        List {
            ForEach(rolls) { roll in
                Text("Roll Total: \(roll.total)!")
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { rolls[$0] }.forEach(moc.delete)

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

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
