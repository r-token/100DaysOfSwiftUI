//
//  ContentView.swift
//  Project17-Flashzilla
//
//  Created by Ryan Token on 9/22/21.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle tapped!")
                    }

                Circle()
                    .fill(Color.red)
                    .frame(width: 300, height: 300)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("Circle tapped!")
                    }
                    // .allowsHitTesting(false)
            }
            
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .contentShape(Rectangle())
            
            .onTapGesture {
                print("VStack tapped!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
