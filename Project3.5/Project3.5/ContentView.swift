//
//  ContentView.swift
//  Project3.5
//
//  Created by Ryan Token on 7/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var answer = ""
    @State private var playerScore = 0
    @State private var progress = 0
    @State private var isShowingFinalScore = false
    
    let options = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                VStack(spacing: 10) {
                    HStack {
                        Text("Score:")
                        Text("\(playerScore)")
                            .bold()
                    }
                    HStack {
                        Text("App's move:")
                        Text("\(options[appChoice])")
                            .bold()
                    }
                    HStack {
                        Text("You should try to:")
                        Text("\(shouldWin == true ? "Win" : "Lose")")
                            .bold()
                    }
                }
                .font(.system(size: 20))
                
                Spacer()
                
                Text("\(answer)")
                    .font(.largeTitle)
                    .foregroundColor(answer == "Correct!" ? .white : .red)
                
                Spacer()
                
                Text("Make Your Move:")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            makeMove(guess: option)
                            newQuestion()
                        }, label: {
                            Text("\(option)")
                                .padding()
                                .background(Color.white)
                                .clipShape(Capsule())
                                .shadow(radius: 25)
                        })
                    }
                }
                
                Spacer()
            }
            
            .alert(isPresented: $isShowingFinalScore) {
                Alert(title: Text("Game Over"), message: Text("Final score: \(playerScore)"), dismissButton: .default(Text("Start Over")) {
                    newGame()
                })
        }
        }
    }
    
    func makeMove(guess: String) {
        let correctAnswer = "Correct!"
        let incorrectAnswer = "Incorrect ☹️"
        switch guess {
        case "Rock":
            if shouldWin == true {
                if appChoice == 2 {
                    answer = correctAnswer
                } else {
                    answer = incorrectAnswer
                }
            } else {
                if appChoice == 1 {
                    answer = correctAnswer
                } else {
                    answer = incorrectAnswer
                }
            }
            
        case "Paper":
            if shouldWin == true {
                if appChoice == 0 {
                    answer = correctAnswer
                } else {
                    answer = incorrectAnswer
                }
            } else {
                if appChoice == 2 {
                    answer = correctAnswer
                } else {
                    answer = incorrectAnswer
                }
            }
            
        case "Scissors":
            if shouldWin == true {
                if appChoice == 1 {
                    answer = correctAnswer
                } else {
                    answer = incorrectAnswer
                }
            } else {
                if appChoice == 0 {
                    answer = correctAnswer
                } else {
                    answer = incorrectAnswer
                }
            }
            
        default:
            print("Unknown")
        }
        
        if answer == correctAnswer {
            playerScore += 1
        } else {
            playerScore -= 1
        }
    }
    
    func newQuestion() {
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        progress += 1
        
        if progress == 10 {
            isShowingFinalScore = true
        }
    }
    
    func newGame() {
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        answer = ""
        playerScore = 0
        progress = 0
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
