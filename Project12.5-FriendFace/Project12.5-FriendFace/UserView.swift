//
//  UserView.swift
//  UserView
//
//  Created by Ryan Token on 8/7/21.
//

import SwiftUI

struct UserView: View {
    @State private var user: User
    
    var users: [User]
    var userID: String
    
    init(users: [User], userID: String) {
        self.users = users
        self.userID = userID
        user = users.first(where: { $0.id == userID}) ?? testUser()
    }
    
    var body: some View {
        Form {
            Section("Info") {
                HStack {
                    Text("Age:")
                        .font(.headline)
                    Spacer()
                    Text("\(user.age)")
                }
                HStack {
                    Text("Company:")
                        .font(.headline)
                    Spacer()
                    Text(user.company)
                }
                HStack {
                    Text("Email:")
                        .font(.headline)
                    Spacer()
                    Text(user.email)
                }
                HStack {
                    Text("Address:")
                        .font(.headline)
                    Spacer()
                    Text(user.address)
                }
            }
            
            Section("About") {
                Text(user.about)
            }
            
            Section("Friends") {
                List(user.friends) { friend in
                    NavigationLink(destination: UserView(users: users, userID: friend.id)) {
                        Text(friend.name)
                    }
                }
            }
            
            .navigationBarTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

func testUser() -> User {
    var user = User()
    user.id = "ihfi8uy34t8uhe9p8t-asdfasdfwt34t-q34t5yhh"
    user.isActive = true
    user.name = "Ryan Token"
    user.age = 27
    user.company = "Storyboard Technology, Inc."
    user.email = "ryantoken13@gmail.com"
    user.address = "1920 S Florence Ave, Tulsa, OK, 74104"
    user.about = "This dude is extremely cool"
    user.registered = "2021-08-07T01:47:18-00:00"
    user.tags = [
        "cillum",
         "consequat",
         "deserunt",
         "nostrud",
         "eiusmod",
         "minim",
         "tempor"
    ]
    user.friends = [
        Friend(id: "lkasjd;gkhakj", name: "Matt Rechtien"),
        Friend(id: "2k3jhoiuagfva", name: "Carter Krafft"),
        Friend(id: "kljahweiot34i", name: "Alex Newell"),
        Friend(id: "lkjsadgohwei8", name: "Alex Haueisen"),
        Friend(id: "hiufoweuioheg", name: "Alex Token")
    ]
    
    return user
}
