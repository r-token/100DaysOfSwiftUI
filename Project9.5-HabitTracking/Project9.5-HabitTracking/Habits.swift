//
//  Habits.swift
//  Project9.5-HabitTracking
//
//  Created by Ryan Token on 7/28/21.
//

import Foundation

class Habits: ObservableObject {
    @Published var habitList = [IndividualHabit]() {
        didSet {
            let encoder = JSONEncoder()
            if let encodedItems = try? encoder.encode(habitList) {
                UserDefaults.standard.set(encodedItems, forKey: "HabitList")
            }
        }
    }
    
    init() {
        if let habitList = UserDefaults.standard.data(forKey: "HabitList") {
            let decoder = JSONDecoder()
            if let decodedItems = try? decoder.decode([IndividualHabit].self, from: habitList) {
                self.habitList = decodedItems
                return
            }
        }
        
        habitList = []
    }
}
