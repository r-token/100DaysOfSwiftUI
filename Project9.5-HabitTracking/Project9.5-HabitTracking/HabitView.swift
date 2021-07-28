//
//  HabitView.swift
//  Project9.5-HabitTracking
//
//  Created by Ryan Token on 7/28/21.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habits: Habits
    
    @State var habit: IndividualHabit
    
    var body: some View {
        VStack {
            Text(habit.name)
                .padding()
            
            Text(habit.description)
                .padding()
            
            HStack {
                Text("\(habit.timesCompleted)")
                Stepper("Times Completed", onIncrement: habit.incrementTimesCompleted, onDecrement: habit.decrementTimesCompleted)
            }
        }
    }
}

//struct HabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitView()
//    }
//}
