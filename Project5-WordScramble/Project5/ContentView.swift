//
//  ContentView.swift
//  Project5
//
//  Created by Ryan Token on 7/10/21.
//

import SwiftUI

struct ContentView: View {
	@State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
	
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                GeometryReader { listGeo in
                    List {
                        ForEach(usedWords, id: \.self) { word in
                            GeometryReader { itemGeo in
                                HStack {
                                    Image(systemName: "\(word.count).circle")
                                        .foregroundColor(getColor(listGeo: listGeo, itemGeo: itemGeo))
                                    Text(word)
                                }
                                .frame(width: itemGeo.size.width, alignment: .leading)
                                .offset(x: getOffset(listGeo: listGeo, itemGeo: itemGeo), y: 0)
                                
                                .accessibilityElement(children: .ignore)
                                .accessibility(label: Text("\(word), \(word.count) letters"))
                            }
                        }
                    }
                }
                
                Text("Score: \(score)")
            }
            
            .navigationBarTitle(Text("\(rootWord)"))
            .navigationBarItems(leading: Button("Restart", action: startGame))
            .onAppear(perform: startGame)
            
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    func addNewWord() {
        // lowercase and trim the word, ensuring we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        let points = answer.count
        
        usedWords.insert(answer, at: 0)
        score += points
        
        newWord = ""
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: .newlines)
                
                // 4. Pick one random word, or use "silkworm" as a default - set back to start
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = []
                score = 0
                
                
                // If we are here, everything has worked, so we can exit
                return
            }
        }
        
        // If we are *here*, then there was a problem - trigger a crash and report the error
        fatalError("Could not load start.txt from the bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        guard word.count > 2 else {
            return false
        }
        
        guard word != rootWord else {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func getOffset(listGeo: GeometryProxy, itemGeo: GeometryProxy) -> CGFloat {
        let listHeight = listGeo.size.height
        let listStart = listGeo.frame(in: .global).minY
        let itemStart = itemGeo.frame(in: .global).minY

        let itemPercent =  (itemStart - listStart) / listHeight * 100

        let thresholdPercent: CGFloat = 60
        let indent: CGFloat = 2

        if itemPercent > thresholdPercent {
            return (itemPercent - (thresholdPercent - 1)) * indent
        }

        return 0
    }
    
    func getColor(listGeo: GeometryProxy, itemGeo: GeometryProxy) -> Color {
        let itemPercent = getItemPercent(listGeo: listGeo, itemGeo: itemGeo)

        let colorValue = Double(itemPercent / 100)

        // varying from green to red going through yellow,
        // using Color(red:green:blue:) as suggested
        return Color(red: 2 * colorValue, green: 2 * (1 - colorValue), blue: 0)

        // varying hue is easier to work with and offers more variety though
        //return Color(hue: colorValue, saturation: 0.9, brightness: 0.9)
    }
    
    func getItemPercent(listGeo: GeometryProxy, itemGeo: GeometryProxy) -> CGFloat {
        let listHeight = listGeo.size.height
        let listStart = listGeo.frame(in: .global).minY
        let itemStart = itemGeo.frame(in: .global).minY

        let itemPercent =  (itemStart - listStart) / listHeight * 100

        return itemPercent
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
