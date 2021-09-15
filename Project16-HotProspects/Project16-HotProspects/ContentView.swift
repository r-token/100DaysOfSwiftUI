//
//  ContentView.swift
//  Project16-HotProspects
//
//  Created by Ryan Token on 9/15/21.
//

import SwiftUI

struct ContentView: View {
    let user = User()
    
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
