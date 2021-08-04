//
//  ContentView.swift
//  Project12-CoreDataProject
//
//  Created by Ryan Token on 8/3/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
	
    // get all Wizards
	@FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    // get just the Star Wars ships
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var starWarsShips: FetchedResults<Ship>
    
    // get ships that start with letters before F
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name < %@", "F")) var aThroughEships: FetchedResults<Ship>
    
    // get ships from any of the three universes specified here
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])) var universeShips: FetchedResults<Ship>
    
    // get ships that begin with the letter E (case-sensitive)
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH %@", "E")) var EShips: FetchedResults<Ship>
    
    // get ships that begin with the letter e or E (non case-sensitive)
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "e")) var eEships: FetchedResults<Ship>
    
    // get ships that container the letter R (non case-sensiste)
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS[c] %@", "r")) var shipsWithR: FetchedResults<Ship>
    
    // get ships that container the letter R (non case-sensiste)
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var shipsThatDontBeginWithE: FetchedResults<Ship>

	var body: some View {
        VStack {
            List(shipsThatDontBeginWithE, id: \.self) { shipThatDoesntBeginWithE in
                Text(shipThatDoesntBeginWithE.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? moc.save()
            }
        }
	}
}

struct Student: Hashable {
	let name: String
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
