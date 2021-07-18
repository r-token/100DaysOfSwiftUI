//
//  ContentView.swift
//  Project8-Moonshot
//
//  Created by Ryan Token on 7/18/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink(
                    destination: Text("Detail \(row)"),
                    label: {
                        Text("Row \(row)")
                    })
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
