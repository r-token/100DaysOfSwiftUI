//
//  ContentView.swift
//  Project12.5-FriendFace
//
//  Created by Ryan Token on 8/7/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { (user: User) in
                NavigationLink(destination: UserView(users: Array(users), userID: user.wrappedId)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(user.wrappedName)
                            .font(.headline)
                        
                        Text("\(user.wrappedEmail)")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
            }
            
            .navigationBarTitle("FriendFace")
        }
        
        .task {
            do {
                if users.isEmpty {
                    let usersFromApi = try await getData()
                    saveData(users: usersFromApi)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func prepareURL() -> URLRequest? {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        return request
    }
    
    func getData() async throws -> [User]? {
        print("Fetching data from API")
        
        if let request = prepareURL() {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                return decodedUsers
            } else {
                print("Could not decode data into [User]")
            }
        }
        
        return nil
    }
    
    func saveData(users: [User]?) {
        if let users = users {
            for user in users {
                let newUser = User(context: moc)
                newUser.id = user.wrappedId
                newUser.isActive = user.isActive
                newUser.name = user.wrappedName
                newUser.age = user.age
                newUser.company = user.wrappedCompany
                newUser.email = user.wrappedEmail
                newUser.address = user.wrappedAddress
                newUser.about = user.wrappedAbout
                newUser.registered = user.wrappedRegistered
                newUser.tags = user.wrappedTags
            }
            
            do {
                try moc.save()
                print("Saved users successfully")
            } catch {
                print("Error saving users: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
