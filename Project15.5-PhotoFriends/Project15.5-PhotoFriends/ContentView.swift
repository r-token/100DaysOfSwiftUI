//
//  ContentView.swift
//  Project15.5-PhotoFriends
//
//  Created by Ryan Token on 9/12/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc

    @State private var isShowingImagePicker = false
    @State private var isShowingImageNamePicker = false
    @State private var isShowingNameAlert = false
    @State private var selectedImage: UIImage?
    @State private var name = ""

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Friend.name, ascending: true)],
        animation: .default)
    
    private var friends: FetchedResults<Friend>

    var body: some View {
        NavigationView {
            List {
                ForEach(friends) { friend in
                    NavigationLink(destination: DetailView(friend: friend)) {
                        HStack {
                            getPhotoFrom(uuid: friend.wrappedPhotoId)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                            
                            Text(friend.wrappedName)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            .navigationBarTitle("PhotoFriends")
            .navigationBarItems(trailing: Button(action: addFriend) {
                HStack(spacing: 2) {
                    Image(systemName: "plus.app")
                    Text("PhotoFriend")
                }
            })
            
            .sheet(isPresented: $isShowingImagePicker, onDismiss: showImageNamePicker) {
                ImagePicker(image: $selectedImage)
            }
            
            .sheet(isPresented: $isShowingImageNamePicker, onDismiss: loadImage) {
                ImageNamerView(name: $name)
            }
        }
    }

    private func addFriend() {
        isShowingImagePicker = true
    }
    
    func showImageNamePicker() {
        isShowingImageNamePicker = true
    }
    
    func loadImage() {
            let newFriend = Friend(context: moc)
            let uuid = UUID()
            
            newFriend.name = name
            newFriend.details = ""
            newFriend.photoid = uuid

            do {
                if let jpegData = selectedImage?.jpegData(compressionQuality: 0.8) {
                    try? jpegData.write(to: getDocumentsDirectory().appendingPathComponent(uuid.uuidString), options: [.atomicWrite, .completeFileProtection])
                }
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { friends[$0] }.forEach(moc.delete)

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
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func getPhotoFrom(uuid: UUID) -> Image {
        let uuidString = uuid.uuidString
        guard let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(uuidString)) else { return Image(systemName: "person.crop.circle.badge.questionmark") }
        guard let uiImage = UIImage(data: data, scale: 1.0) else { return Image(systemName: "person.crop.circle.badge.questionmark") }
        return Image(uiImage: uiImage)
    }
}

