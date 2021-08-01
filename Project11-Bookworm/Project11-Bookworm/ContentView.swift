//
//  ContentView.swift
//  Project11-Bookworm
//
//  Created by Ryan Token on 7/31/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
	
	@FetchRequest(entity: Book.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Book.title, ascending: true),
		NSSortDescriptor(keyPath: \Book.author, ascending: true)
	]) var books: FetchedResults<Book>
    
    @State private var isShowingAddBookSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
				.onDelete(perform: deleteBooks)
            }
                
            .sheet(isPresented: $isShowingAddBookSheet) {
                AddBookView().environment(\.managedObjectContext, moc)
            }
        
            .navigationBarTitle("Bookworm")
        
			.navigationBarItems(leading: EditButton(), trailing: Button(action: {
                isShowingAddBookSheet.toggle()
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "plus")
            })
        }
    }
	
	func deleteBooks(at offsets: IndexSet) {
		for offset in offsets {
			// find this book in our fetch request'
			let book = books[offset]
			
			// delete it from the context
			moc.delete(book)
		}
		
		// save the new context
		try? moc.save()
	}
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
