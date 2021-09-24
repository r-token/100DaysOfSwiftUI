//
//  ContentView.swift
//  Project17-Flashzilla
//
//  Created by Ryan Token on 9/22/21.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect() // take out tolerance if you need the timer to be exact
    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel() // stop the timer
                } else {
                    print("The time is now \(time)")
                }

                counter += 1
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
