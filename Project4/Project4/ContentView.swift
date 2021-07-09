//
//  ContentView.swift
//  Project4
//
//  Created by Ryan Token on 7/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUpTime = Date()
    
    var body: some View {
        VStack {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
            
            DatePicker("Please enter a date", selection: $wakeUpTime, in: Date()..., displayedComponents: .hourAndMinute)
                // .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
