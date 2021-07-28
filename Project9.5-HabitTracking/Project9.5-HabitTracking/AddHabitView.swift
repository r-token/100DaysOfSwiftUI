//
//  AddHabitView.swift
//  Project9.5-HabitTracking
//
//  Created by Ryan Token on 7/28/21.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var habits: Habits
    
    @State private var habitName = ""
    @State private var habitDescription = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit Name", text: $habitName)
                    .padding()
                
                TextField("Habit Description", text: $habitDescription)
                    .padding()
            }
            
            .navigationBarTitle(Text("New Habit"))
            .navigationBarItems(trailing: Button("Save") {
                addHabit()
            })
        }
    }
    
    func addHabit() {
        let newHabit = IndividualHabit(name: habitName, description: habitDescription, timesCompleted: 0)
        habits.habitList.append(newHabit)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
