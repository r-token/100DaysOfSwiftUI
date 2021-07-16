//
//  ContentView.swift
//  Project2
//
//  Created by Ryan Token on 7/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var correct = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        flagTapped(number)
                    }, label: {
                        if number == correctAnswer {
                            Image(countries[number])
                                .flagViewModifier()
                                .rotation3DEffect(.degrees(correct ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .animation(.default)
                        } else {
                            Image(countries[number])
                                .flagViewModifier()
                                .opacity(correct ? 0.25 : 1.00)
                                .animation(.default)
                        }
                    })
                }
                
                Text(String(score))
                    .foregroundColor(.white)
                    .font(.title2)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            correct = true
            scoreTitle = "Correct"
            score += 1
        } else {
            correct = false
            scoreTitle = "Wrong. That's the flag of \(countries[number])"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        correct = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
