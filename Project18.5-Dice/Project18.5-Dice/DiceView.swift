//
//  ContentView.swift
//  Project18.5-Dice
//
//  Created by Ryan Token on 10/2/21.
//

import SwiftUI
import CoreData

struct DiceView: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Roll.total, ascending: true)],
        animation: .default)
    private var rolls: FetchedResults<Roll>
    
    @State private var numberOfDice = 0
    @State private var sidesOnDie = 4
    @State private var isShowingResultAlert = false
    @State private var total = 0
    @State private var feedback = UINotificationFeedbackGenerator()
    
    let diceSidesOptions = [4, 6, 8, 10, 12, 20, 100]

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Picker("Number of Dice", selection: $numberOfDice) {
                        ForEach(1..<6) { number in
                            if number == 1 {
                                Text("\(number) die")
                            } else {
                                Text("\(number) dice")
                            }
                        }
                    }
                    
                    Picker("Dice Type", selection: $sidesOnDie) {
                        ForEach(diceSidesOptions, id: \.self) { sideOption in
                            Text("\(sideOption) sides")
                        }
                    }
                    
                    Section(footer:
                        HStack {
                            Spacer()
                            VStack {
                                Text("Roll the Dice!")
                                    .font(.system(.title))
                                    .padding()
                                Button(action: rollDice) {
                                    Image(systemName: "dice.fill")
                                        .font(.largeTitle)
                                }
                            }
                            .padding(.vertical, 80)
                            Spacer()
                        }
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Dice")
            
            .alert(isPresented: $isShowingResultAlert) {
                Alert(title: Text("Roll Result"), message: Text("You rolled \(numberOfDice+1) \(sidesOnDie)-sided dice for a total of \(total)"), dismissButton: .default(Text("OK")) {
                    handleAlertDismiss()
                })
            }
        }
    }
    
    private func rollDice() {
        feedback.prepare()
        let diceRolls = numberOfDice+1
        print("diceRolls: \(diceRolls)")
        
        for _ in 1...diceRolls {
            feedback.notificationOccurred(.success)
            let roll = Int.random(in: 1...sidesOnDie)
            print("roll: \(roll)")
            total += roll
            print("total: \(total)")
        }
        
        isShowingResultAlert = true
    }

    private func saveRoll(_ total: Int) {
        let int16Total = Int16(total)
        
        withAnimation {
            let newRoll = Roll(context: moc)
            newRoll.total = int16Total
            newRoll.timestamp = Date()

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func handleAlertDismiss() {
        saveRoll(total)
        total = 0
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
