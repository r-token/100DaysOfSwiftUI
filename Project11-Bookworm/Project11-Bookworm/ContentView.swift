//
//  ContentView.swift
//  Project11-Bookworm
//
//  Created by Ryan Token on 7/31/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
	@State private var rememberMe = false
	
    @Environment(\.managedObjectContext) var moc
	@Environment(\.horizontalSizeClass) var sizeClass

	@FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    // private var items: FetchedResults<Item>

    var body: some View {
		VStack {
			List {
				ForEach(students, id: \.id) { student in
					Text(student.name ?? "Unknown")
				}
			}
			
			Button("Add Student") {
				addStudent()
			}
		}
    }

    private func addStudent() {
		let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
		let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

		let chosenFirstName = firstNames.randomElement()!
		let chosenLastName = lastNames.randomElement()!
		
        withAnimation {
            let student = Student(context: moc)
			student.id = UUID()
			student.name = "\(chosenFirstName) \(chosenLastName)"

            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

struct PushButton: View {
	let title: String
	@Binding var isOn: Bool

	var onColors = [Color.red, Color.yellow]
	var offColors = [Color(white: 0.6), Color(white: 0.4)]

	var body: some View {
		Button(title) {
			self.isOn.toggle()
		}
		.padding()
		.background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
		.foregroundColor(.white)
		.clipShape(Capsule())
		.shadow(radius: isOn ? 0 : 5)
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
