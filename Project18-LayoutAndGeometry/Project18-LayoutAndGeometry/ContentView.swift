//
//  ContentView.swift
//  Project18-LayoutAndGeometry
//
//  Created by Ryan Token on 9/29/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hi!")
                .position(x: 100, y: 100)
                .background(Color.red)
                
            
            Text("Hi!")
                .offset(x: 20, y: 20)
                .background(Color.red)
                
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
