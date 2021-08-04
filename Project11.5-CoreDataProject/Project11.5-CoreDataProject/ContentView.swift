//
//  ContentView.swift
//  Project11.5-CoreDataProject
//
//  Created by Ryan Token on 8/3/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
	
	@FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>

	var body: some View {
		VStack {
			List(wizards, id: \.self) { wizard in
				Text(wizard.name ?? "Unknown")
			}

			Button("Add") {
				let wizard = Wizard(context: moc)
				wizard.name = "Harry Potter"
			}
			
			Button("Save MOC if there have been changes") {
				if moc.hasChanges {
					do {
						// container.viewContext.mergePolicy is set to NSMergeByPropertyObjectTrumpMergePolicy in Persistence.swift, so any data collisons (like adding Harry Potter multiple times, will only actually get saved once :)
						try moc.save()
					} catch {
						print(error.localizedDescription)
					}
				}
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
