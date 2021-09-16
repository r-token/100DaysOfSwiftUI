//
//  ContentView.swift
//  Project16-HotProspects
//
//  Created by Ryan Token on 9/15/21.
//

import SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View {
    @ObservedObject var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is \(updater.value)")
    }
}

class DelayedUpdater: ObservableObject {
    var value = 0 {
        // this works just like @Published does, but now we can add extra functionality within willSet like logging or calling another method
        willSet {
            objectWillChange.send()
            print("Going up!")
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
