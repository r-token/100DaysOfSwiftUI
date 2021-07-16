//
//  ContentView.swift
//  Project6.5
//
//  Created by Ryan Token on 7/14/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTables = [1]
    @State private var numberOfQuestions = "5"
    
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var question = ""
    @State private var correctAnswer = 0
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var progress = 1
    
    @State private var showingAnswerAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var showSetupView = true
    
    let tableOptions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    let numQuestionOptions = ["5", "10", "20", "All"]
	
    var body: some View {
		NavigationView {
			ZStack {
				Color.purple
					.edgesIgnoringSafeArea(.all)
                    
                if showSetupView {
                    Group {
                        VStack(spacing: 20) {
                            Spacer()
                            Spacer()
                            Text("Which times tables do you want to practice?")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(height: 10, alignment: .bottom)
                            
                            VStack(spacing: 25) {
                                HStack(spacing: 25) {
                                    ForEach(0..<4) { option in
                                        Button(action: {
                                            if selectedTables.contains(option+1) {
                                                if let itemToRemoveIndex = selectedTables.firstIndex(of: option+1) {
                                                    selectedTables.remove(at: itemToRemoveIndex)
                                                }
                                            } else {
                                                selectedTables.append(option+1)
                                            }
                                            print(selectedTables)
                                        }, label: {
                                            Text("\(tableOptions[option])s")
                                                .frame(width: 50, height: 50)
                                                .background(selectedTables.contains(option+1) ? Color.blue : Color.white)
                                                .foregroundColor(selectedTables.contains(option+1) ? .white : .blue)
                                                .buttonStyle()
                                        })
                                    }
                                }
                                HStack(spacing: 25) {
                                    ForEach(4..<8) { option in
                                        Button(action: {
                                            if selectedTables.contains(option+1) {
                                                if let itemToRemoveIndex = selectedTables.firstIndex(of: option+1) {
                                                    selectedTables.remove(at: itemToRemoveIndex)
                                                }
                                            } else {
                                                selectedTables.append(option+1)
                                            }
                                            print(selectedTables)
                                        }, label: {
                                            Text("\(tableOptions[option])s")
                                                .frame(width: 50, height: 50)
                                                .background(selectedTables.contains(option+1) ? Color.blue : Color.white)
                                                .foregroundColor(selectedTables.contains(option+1) ? .white : .blue)
                                                .buttonStyle()
                                        })
                                    }
                                }
                                HStack(spacing: 25) {
                                    ForEach(8..<12) { option in
                                        Button(action: {
                                            if selectedTables.contains(option+1) {
                                                if let itemToRemoveIndex = selectedTables.firstIndex(of: option+1) {
                                                    selectedTables.remove(at: itemToRemoveIndex)
                                                }
                                            } else {
                                                selectedTables.append(option+1)
                                            }
                                            print(selectedTables)
                                        }, label: {
                                            Text("\(tableOptions[option])s")
                                                .frame(width: 50, height: 50)
                                                .background(selectedTables.contains(option+1) ? Color.blue : Color.white)
                                                .foregroundColor(selectedTables.contains(option+1) ? .white : .blue)
                                                .buttonStyle()
                                        })
                                    }
                                }
                            }
                            
                            VStack(alignment: .center, spacing: 25) {
                                Spacer()
                                Text("How many questions should we ask?")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(height: 10, alignment: .bottom)
                                
                                HStack(spacing: 25) {
                                    ForEach(numQuestionOptions, id: \.self) { option in
                                        Button(action: {
                                            numberOfQuestions = option
                                            print(numberOfQuestions)
                                        }, label: {
                                            Text(option)
                                                .frame(width: 50, height: 50)
                                                .background(option == numberOfQuestions ? Color.blue : Color.white)
                                                .foregroundColor(option == numberOfQuestions ? .white : .blue)
                                                .buttonStyle()
                                        })
                                    }
                                }
                            }
                            
                            Spacer()
                            Spacer()
                            Spacer()
                            
                            Button(action: {
                                generateNewQuestion()
                                showSetupView = false
                            }, label: {
                                Text("Start!")
                                    .frame(width: 200, height: 50)
                                    .startButtonStyle()
                            })
                        }
                        .padding()
                    }
                } else { // show game view
                    Group {
                        VStack(spacing: 25) {
                            Spacer()
                            Text(question)
                                .foregroundColor(.white)
                                .font(.title)
                            
                            TextField("Your answer...", text: $userAnswer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .keyboardType(.numberPad)
                            
                            Button(action: {
                                checkAnswer()
                                UIApplication.shared.endEditing() // Call to dismiss keyboard
                            }, label: {
                                Text("Submit")
                                    .frame(width: 100, height: 35)
                                    .startButtonStyle()
                            })
                            
                            Spacer()
                            Spacer()
                            Spacer()
                            
                            Button(action: {
                                showSetupView = true
                            }, label: {
                                Text("Back to Options")
                                    .frame(width: 200, height: 50)
                                    .startButtonStyle()
                            })
                        }
                        .padding()
                    }
                }
			}
            .alert(isPresented: $showingAnswerAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: Alert.Button.default(
                        Text("OK"), action: { generateNewQuestion() }
                    )
                )
            })
            
            .navigationBarTitle(Text("Edutainment"))
		}
    }
    
    func generateNewQuestion() {
        userAnswer = ""
        if progress <= Int(numberOfQuestions) ?? 5 {
            print("Generating question...")
            firstNumber = selectedTables.randomElement() ?? 0
            secondNumber = Int.random(in: 1...12)
            
            correctAnswer = firstNumber * secondNumber
            
            question = "What is \(firstNumber) x \(secondNumber)?"
        } else {
            showSetupView = true
            progress = 1
            score = 0
        }
    }
    
    func checkAnswer() {
        print("Progress: \(progress)/\(Int(numberOfQuestions) ?? 0)")
        if progress != Int(numberOfQuestions) {
            if Int(userAnswer) == correctAnswer {
                alertTitle = "Correct!"
                alertMessage = "Way to go 👏"
                score += 1
            } else {
                alertTitle = "Incorrect"
                alertMessage = "Try again. The correct answer was \(correctAnswer) 😓"
            }
        } else {
            // game is over
            if Int(userAnswer) == correctAnswer {
                alertTitle = "Correct! Game Over."
            } else {
                alertTitle = "Incorrect. Game Over."
            }
            
            alertMessage = "You got \(score) out of \(numberOfQuestions) correct"
        }
        
        progress += 1
        showingAnswerAlert = true
    }
}

// extension for keyboard to dismiss
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
