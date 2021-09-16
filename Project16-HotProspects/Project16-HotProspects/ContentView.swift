//
//  ContentView.swift
//  Project16-HotProspects
//
//  Created by Ryan Token on 9/15/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
