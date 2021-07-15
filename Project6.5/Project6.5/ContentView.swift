//
//  ContentView.swift
//  Project6.5
//
//  Created by Ryan Token on 7/14/21.
//

import SwiftUI

struct ContentView: View {
	@State private var selectedTables = [Int]()
	@State private var numberOfQuestions = 5
	
	let tableOptions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
	let numQuestionOptions = ["5", "10", "20", "All"]
	
    var body: some View {
		NavigationView {
			ZStack {
				Color.purple
					.edgesIgnoringSafeArea(.all)
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
										// button pressed
									}, label: {
										Text("\(tableOptions[option])s")
											.buttonStyle()
									})
								}
							}
							HStack(spacing: 25) {
								ForEach(4..<8) { option in
									Button(action: {
										// button pressed
									}, label: {
										Text("\(tableOptions[option])s")
											.buttonStyle()
									})
								}
							}
							HStack(spacing: 25) {
								ForEach(8..<12) { option in
									Button(action: {
										// button pressed
									}, label: {
										Text("\(tableOptions[option])s")
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
										// button pressed
									}, label: {
										Text(option)
											.buttonStyle()
									})
								}
							}
						}
						
						Spacer()
						Spacer()
						
						Button(action: {
							// start game
						}, label: {
							Text("Start!")
								.frame(width: 200, height: 50)
								.background(Color.white)
								.foregroundColor(.pink)
								.font(.title2)
								.clipShape(Capsule())
								.shadow(radius: 10)
						})
						
						Spacer()
					}
					.padding()
				}
				.navigationBarTitle(Text("Edutainment"))
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
