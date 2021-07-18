//
//  ContentView.swift
//  Project8-Moonshot
//
//  Created by Ryan Token on 7/18/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("wide-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
