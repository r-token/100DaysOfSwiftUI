//
//  ContentView.swift
//  Project14-BucketList
//
//  Created by Ryan Token on 8/15/21.
//

import SwiftUI

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text(user.lastName)
            Text(user.firstName)
        }
    }
}

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.lastName < rhs.lastName
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
