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
            Text("User is Leaving the App")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    print("Moving to the background!")
                }
            
            Text("User is Entering the App")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("Moving back to the foreground!")
                }
            
            Text("User is Taking a Screenshot")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                    print("User took a screenshot!")
                }
            
            Text("User's Clock Changed")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification)) { _ in
                    print("User's clock changed significantly!")
                }
            
            Text("User's Keyboard is Showing 🙈")
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                    print("User's keyboard is showing!'")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
