//
//  DynamicFetchRequestView.swift
//  Project12-CoreDataProject
//
//  Created by Ryan Token on 8/4/21.
//

import SwiftUI

struct DynamicFetchRequestView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    enum Predicate: String {
        case beginsWith
        case contains
        case endsWith
        case like
        case matches
    }
    
    var body: some View {
        VStack {
            // list of matching singers
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, sortDescriptors: [
                NSSortDescriptor(keyPath: \Singer.lastName, ascending: true),
                NSSortDescriptor(keyPath: \Singer.firstName, ascending: true)
            ], predicate: Predicate.beginsWith.rawValue) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? moc.save()
            }

            Button("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

struct DynamicFetchRequestView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicFetchRequestView()
    }
}
