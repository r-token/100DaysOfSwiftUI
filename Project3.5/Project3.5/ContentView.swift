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
    @State private var playerScore = 0
    @State private var progress = 0
    @State private var isShowingFinalScore = false
    
    let options = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        VStack {
            Spacer()
            
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
            
            Spacer()
            
            HStack {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        makeMove(guess: option)
                        newQuestion()
                    }, label: {
                        Text("\(option)")
                    })
                }
            }
            
            Spacer()
        }
        
        .alert(isPresented: $isShowingFinalScore) {
            Alert(title: Text("Game Over"), message: Text("Final score: \(playerScore)"), dismissButton: .default(Text("Start Over")) {
                fullReset()
            })
        }
    }
    
    func makeMove(guess: String) {
        switch guess {
        case "Rock":
            if shouldWin == true {
                if appChoice == 2 {
                    playerScore += 1
                } else {
                    playerScore -= 1
                }
            } else {
                if appChoice == 1 {
                    playerScore += 1
                } else {
                    playerScore -= 1
                }
            }
            
        case "Paper":
            if shouldWin == true {
                if appChoice == 0 {
                    playerScore += 1
                } else {
                    playerScore -= 1
                }
            } else {
                if appChoice == 2 {
                    playerScore += 1
                } else {
                    playerScore -= 1
                }
            }
            
        case "Scissors":
            if shouldWin == true {
                if appChoice == 1 {
                    playerScore += 1
                } else {
                    playerScore -= 1
                }
            } else {
                if appChoice == 0 {
                    playerScore += 1
                } else {
                    playerScore -= 1
                }
            }
            
        default:
            print("Unknown")
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
    
    func fullReset() {
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        playerScore = 0
        progress = 1
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
