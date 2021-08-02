//
//  DetailView.swift
//  Project11-Bookworm
//
//  Created by Ryan Token on 8/1/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	@State private var isShowingDeleteAlert = false
	
	let book: Book
	
    var body: some View {
		GeometryReader { geometry in
			VStack {
				ZStack(alignment: .bottomTrailing) {
					Image(book.genre ?? "Fantasy")
						.frame(maxWidth: geometry.size.width)

					Text(book.genre?.uppercased() ?? "FANTASY")
						.font(.caption)
						.fontWeight(.black)
						.padding(8)
						.foregroundColor(.white)
						.background(Color.black.opacity(0.75))
						.clipShape(Capsule())
						.offset(x: -5, y: -5)
				}
				
				Text(book.author ?? "Unknown author")
					.font(.title)
					.foregroundColor(.secondary)
                
                if book.date != nil {
                    Text(getDate(date: book.date ?? nil))
                        .padding()
                }

				Text(book.review ?? "No review")
					.padding()

				RatingView(rating: .constant(Int(book.rating)))
					.font(.largeTitle)

				Spacer()
			}
		}
		.alert(isPresented: $isShowingDeleteAlert) {
			Alert(title: Text("Delete book"), message: Text("Are you sure you want to delete this book?"), primaryButton: .destructive(Text("Delete")) {
				deleteBook()
			}, secondaryButton: .cancel())
		}
		
		.navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
		
		.navigationBarItems(trailing: Button(action: {
			isShowingDeleteAlert = true
		}) {
			Image(systemName: "trash")
		})
    }
	
	func deleteBook() {
		moc.delete(book)

		try? self.moc.save()
		presentationMode.wrappedValue.dismiss()
	}
    
    func getDate(date: Date?) -> String {
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            
            return "Rated on \(dateFormatter.string(from: date ?? Date.init()))"
        } else {
            return ""
        }
    }
}

struct DetailView_Previews: PreviewProvider {
	static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

	static var previews: some View {
		let book = Book(context: moc)
		book.title = "Test book"
		book.author = "Test author"
		book.genre = "Fantasy"
		book.rating = 4
		book.review = "This was a great book; I really enjoyed it."

		return NavigationView {
			DetailView(book: book)
		}
	}
}
