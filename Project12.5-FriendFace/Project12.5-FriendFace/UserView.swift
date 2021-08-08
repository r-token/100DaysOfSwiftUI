//
//  UserView.swift
//  UserView
//
//  Created by Ryan Token on 8/7/21.
//

import SwiftUI
import CoreData

struct UserView: View {
    @Environment(\.managedObjectContext) private var moc
    
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
                    Text(user.wrappedCompany)
                }
                HStack {
                    Text("Email:")
                        .font(.headline)
                    Spacer()
                    Text(user.wrappedEmail)
                }
                HStack {
                    Text("Address:")
                        .font(.headline)
                    Spacer()
                    Text(user.wrappedAddress)
                }
            }
            
            Section("About") {
                Text(user.wrappedAbout)
            }
            
            Section("Friends") {
                List(user.friendArray, id: \.self) { friend in
                    NavigationLink(destination: UserView(users: users, userID: friend.wrappedId)) {
                        Text(friend.wrappedName)
                    }
                }
            }
            
            .navigationBarTitle(user.wrappedName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

func testUser() -> User {
    let user = User()
    user.id = "ihfi8uy34t8uhe9p8t-asdfasdfwt34t-q34t5yhh"
    user.isActive = true
    user.name = "Ryan Token"
    user.age = 200
    user.company = "Some company"
    user.email = "someemail@gmail.com"
    user.address = "Some address"
    user.about = "This guy is extremely cool"
    user.registered = "2021-08-07T01:47:18-00:00"
    
    return user
}
