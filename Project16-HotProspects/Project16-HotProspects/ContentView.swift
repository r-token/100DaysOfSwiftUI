//
//  ContentView.swift
//  Project16-HotProspects
//
//  Created by Ryan Token on 9/15/21.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(action: {
                        backgroundColor = .red
                    }) {
                        Text("Red")
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.red)
                    }

                    Button(action: {
                        backgroundColor = .green
                    }) {
                        Text("Green")
                    }

                    Button(action: {
                        backgroundColor = .blue
                    }) {
                        Text("Blue")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
