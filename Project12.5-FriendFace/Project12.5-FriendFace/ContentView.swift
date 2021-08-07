//
//  ContentView.swift
//  Project12.5-FriendFace
//
//  Created by Ryan Token on 8/7/21.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: UserView(users: users, userID: user.id)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(user.name)
                            .font(.headline)
                        
                        Text("\(user.email)")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
            }
            
            .navigationBarTitle("FriendFace")
        }
        
        .task {
            do {
                try await getData()
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
    
    func getData() async throws {
        print("Fetching data from API")
        
        if let request = prepareURL() {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                users = decodedUsers
            } else {
                print("Could not decode data into [User]")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
