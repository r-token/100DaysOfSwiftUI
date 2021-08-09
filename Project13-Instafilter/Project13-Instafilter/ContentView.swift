//
//  ContentView.swift
//  Project13-Instafilter
//
//  Created by Ryan Token on 8/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                print("Got value \(blurAmount)")
                return blurAmount
            },
            set: {
                // perfect place to save to UserDefaults on slider change
                blurAmount = $0
                print("New value is \(blurAmount)")
            }
        )
        
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: blur, in: 0...20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
