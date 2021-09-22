//
//  ContentView.swift
//  Project17-Flashzilla
//
//  Created by Ryan Token on 9/22/21.
//

import SwiftUI

struct ContentView: View {
    @State private var currentMagAmount: CGFloat = 0
    @State private var finalMagAmount: CGFloat = 1
    
    @State private var currentRotationAmount: Angle = .degrees(0)
    @State private var finalRotationAmount: Angle = .degrees(0)
    
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    // whether it is currently being dragged or not
    @State private var isDragging = false
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .onTapGesture(count: 2) {
                    print("Double Tapped!")
                }
            
                .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
                        print("In progress: \(inProgress)!")
                    }) {
                        print("Long pressed!")
                    }
            
                .scaleEffect(finalMagAmount + currentMagAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { amount in
                            currentMagAmount = amount - 1
                        }
                        .onEnded { amount in
                            finalMagAmount += currentMagAmount
                            currentMagAmount = 0
                        }
                )
            
                .rotationEffect(currentRotationAmount + finalRotationAmount)
                .simultaneousGesture(
                    RotationGesture()
                        .onChanged { angle in
                            currentRotationAmount = angle
                        }
                        .onEnded { angle in
                            finalRotationAmount += currentRotationAmount
                            currentRotationAmount = .degrees(0)
                        }
                )
                
            .padding()
        }
        
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }

        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
