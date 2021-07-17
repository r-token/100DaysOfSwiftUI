//
//  ExpenseItem.swift
//  Project7-iExpense
//
//  Created by Ryan Token on 7/17/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
