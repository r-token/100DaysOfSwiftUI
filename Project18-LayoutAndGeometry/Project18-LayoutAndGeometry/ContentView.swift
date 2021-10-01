//
//  ContentView.swift
//  Project18-LayoutAndGeometry
//
//  Created by Ryan Token on 9/29/21.
//

import SwiftUI

// Want to know where this view is on the screen? Use the global space.
// Want to know where this view is relative to its parent? Use the local space.
// What to know where this view is relative to some other view? Use a custom space.

struct ContentView: View {
    var body: some View {
//        VStack {
//            GeometryReader { geo in
//                Text("Hello, world!")
//                    .frame(width: geo.size.width * 0.9, height: 40)
//                    .background(Color.red)
//            }
//            .background(Color.green)
//
//            Text("More Text")
//        }
        
        OuterView()
            .background(Color.red)
            .coordinateSpace(name: "Custom")
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
