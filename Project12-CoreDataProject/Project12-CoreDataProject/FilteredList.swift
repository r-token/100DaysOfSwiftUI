//
//  FilteredList.swift
//  Project12-CoreDataProject
//
//  Created by Ryan Token on 8/4/21.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { item in
            content(item)
        }
    }
}
