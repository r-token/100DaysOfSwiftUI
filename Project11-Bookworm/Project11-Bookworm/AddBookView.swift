//
//  AddBookView.swift
//  Project11-Bookworm
//
//  Created by Ryan Token on 8/1/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingUnselectedGenreAlert = false
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                        .autocapitalization(.words)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Section {
                        RatingView(rating: $rating)
                        TextField("Write a review", text: $review)
                    }
                    
                    Section {
                        Button("Save") {
                            if genre == "" {
                                isShowingUnselectedGenreAlert = true
                            } else {
                                addBook()
                            }
                        }
                    }
                }
            }
            .alert(isPresented: $isShowingUnselectedGenreAlert) {
                Alert(title: Text("No Genre Selected"), message: Text("Please select a genre before saving"), dismissButton: .default(Text("OK")))
            }
            
			.navigationBarTitle("Add book")
        }
    }
    
    func addBook() {
        let newBook = Book(context: moc)
        newBook.title = title
        newBook.author = author
        newBook.rating = Int16(rating)
        newBook.genre = genre
        newBook.review = review
        newBook.date = Date.init()
        
        try? moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
