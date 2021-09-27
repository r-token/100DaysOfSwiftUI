//
//  ContentView.swift
//  Project17-Flashzilla
//
//  Created by Ryan Token on 9/22/21.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var showingEditScreen = false
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var isActive = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                
                VStack {
                    HStack {
                        Spacer()

                        Button(action: {
                            showingEditScreen = true
                        }) {
                            Image(systemName: "plus.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                    }

                    Spacer()
                }
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding()
                
                if differentiateWithoutColor || accessibilityEnabled {
                    VStack {
                        Spacer()

                        HStack {
                            Button(action: {
                                withAnimation {
                                    removeCard(at: self.cards.count - 1)
                                }
                            }) {
                                Image(systemName: "xmark.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .accessibility(label: Text("Wrong"))
                            .accessibility(hint: Text("Mark your answer as being incorrect."))
                            Spacer()

                            Button(action: {
                                withAnimation {
                                    removeCard(at: self.cards.count - 1)
                                }
                            }) {
                                Image(systemName: "checkmark.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .accessibility(label: Text("Correct"))
                            .accessibility(hint: Text("Mark your answer as being correct."))
                        }
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                    }
                }
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibility(hidden: index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            isActive = false
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if cards.isEmpty == false {
                isActive = true
            }
        }
        
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCardsView()
        }
        
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
