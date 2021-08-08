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
                Text("Need to implement friends relationship here someone")
//                List(user.friends) { friend in
//                    NavigationLink(destination: UserView(users: users, userID: friend.id)) {
//                        Text(friend.name)
//                    }
//                }
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
    user.age = 27
    user.company = "Storyboard Technology, Inc."
    user.email = "ryantoken13@gmail.com"
    user.address = "1920 S Florence Ave, Tulsa, OK, 74104"
    user.about = "This dude is extremely cool"
    user.registered = "2021-08-07T01:47:18-00:00"
    user.tags = "test"
    
    return user
}
