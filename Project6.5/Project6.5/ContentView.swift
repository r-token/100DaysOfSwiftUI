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
                            
                            Button(action: {
                                showSetupView = false
                            }, label: {
                                Text("Start!")
                                    .startButtonStyle()
                            })
                            
                            Spacer()
                        }
                        .padding()
                    }
                } else { // show game view
                    Group {
                        VStack {
                            Button(action: {
                                showSetupView = true
                            }, label: {
                                Text("Back to Options")
                                    .startButtonStyle()
                            })
                        }
                    }
                }
			}
            .navigationBarTitle(Text("Edutainment"))
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
