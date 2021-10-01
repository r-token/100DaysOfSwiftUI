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
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
    //                        Text("Row #\(index)")
    //                            .font(.title)
    //                            .frame(width: fullView.size.width)
    //                            .background(colors[index % 7])
    //                            // .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY) / 5), axis: (x: 0, y: 1, z: 0))
    //                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
                            
                            Rectangle()
                                .fill(colors[index % 7])
                                .frame(height: 150)
                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                        }
                        // .frame(height: 40)
                        .frame(width: 150)
                    }
                }
                .padding(.horizontal, (fullView.size.width - 150) / 2)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
