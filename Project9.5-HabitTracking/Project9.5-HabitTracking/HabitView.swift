//
//  HabitView.swift
//  Project9.5-HabitTracking
//
//  Created by Ryan Token on 7/28/21.
//

import SwiftUI

struct HabitView: View {
    var habitIndex: Int
    @EnvironmentObject var habits: Habits
    
    var body: some View {
        VStack {
            Text(habits.habitList[habitIndex].name)
                .font(.largeTitle)
                .padding()
            
            Text(habits.habitList[habitIndex].description)
                .font(.headline)
                .padding()
            
            Form {
                Stepper("Completed \(habits.habitList[habitIndex].timesCompleted) times", onIncrement: incrementTimesCompleted, onDecrement: decrementTimesCompleted)
            }
            
            Spacer()
        }
    }
    
    func incrementTimesCompleted() {
        habits.habitList[habitIndex].timesCompleted += 1
    }
    
    func decrementTimesCompleted() {
        habits.habitList[habitIndex].timesCompleted -= 1
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habitIndex: 0)
    }
}
