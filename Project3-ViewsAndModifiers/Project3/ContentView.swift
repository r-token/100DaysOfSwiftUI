//
//  ContentView.swift
//  Project3
//
//  Created by Ryan Token on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isRed = false
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Hello, world!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(.white)
                
                Button("Hello World") {
                    print(type(of: self.body))
                }
                .frame(width: 100, height: 100)
                .background(Color.red)
                
                Text("Hello World")
                    .padding()
                    .background(Color.red)
                    .padding()
                    .background(Color.blue)
                    .padding()
                    .background(Color.green)
                    .padding()
                    .background(Color.yellow)
                
                Button("This button changes colors") {
                    isRed.toggle()
                }
                .foregroundColor(isRed ? .red : .blue)
                .padding()
                
                VStack {
                    Text("Gryffindor")
                        .font(.largeTitle) // child's modify takes priority over the default environment modifier under VStack
                    Text("Hufflepuff")
                    Text("Ravenclaw")
                    Text("Slytherin")
                }
                .font(.title)
                
                VStack {
                    motto1
                        .foregroundColor(.red)
                    motto2
                        .foregroundColor(.blue)
                    Text("Hiii there")
                        .bigBlueTitle()
                }
                
                VStack(spacing: 10) {
                    // CapsuleText is my own view type abstracted away to its own file
                    CapsuleText(text: "Hello there!")
                        .foregroundColor(.white)
                    CapsuleText(text: "General Kenobi!")
                        .foregroundColor(.yellow)
                }
                
                Text("Hello again")
                    .titleStyle() // using my custom modifier from CustomModifier.swift
                
                Color.blue
                    .frame(width: 100, height: 100)
                    .watermarked(with: "Hacking with Swift")
                
                GridStack(rows: 4, columns: 4) { row, col in
                    HStack {
                        Image(systemName: "\(row * 4 + col).circle")
                        Text("R\(row) C\(col)")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
