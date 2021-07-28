//
//  IndividualHabit.swift
//  Project9.5-HabitTracking
//
//  Created by Ryan Token on 7/28/21.
//

import Foundation

struct IndividualHabit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var timesCompleted: Int
    
    mutating func incrementTimesCompleted() {
        timesCompleted += 1
    }
    
    mutating func decrementTimesCompleted() {
        timesCompleted += 1
    }
}
