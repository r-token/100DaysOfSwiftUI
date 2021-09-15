//
//  ContentView.swift
//  Project16-HotProspects
//
//  Created by Ryan Token on 9/15/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "tabOne"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "tabTwo"
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
                }
                .tag("tabOne")
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
                .tag("tabTwo")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
