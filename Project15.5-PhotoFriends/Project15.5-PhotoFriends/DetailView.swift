//
//  DetailView.swift
//  Project15.5-PhotoFriends
//
//  Created by Ryan Token on 9/12/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    var friend: Friend
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(friend.wrappedName)
                .font(.largeTitle)
                .padding()
            
            getPhotoFrom(uuid: friend.wrappedPhotoId)
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer()
        }
    }
    
    func getPhotoFrom(uuid: UUID) -> Image {
        let uuidString = uuid.uuidString
        guard let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(uuidString)) else { return Image(systemName: "person.crop.circle.badge.questionmark") }
        guard let uiImage = UIImage(data: data, scale: 1.0) else { return Image(systemName: "person.crop.circle.badge.questionmark") }
        return Image(uiImage: uiImage)
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let friend = Friend(context: moc)
        friend.name = "Ryan Token"
        friend.details = "Some details"
        friend.photoid = UUID()
        
        return DetailView(friend: friend)
    }
}
