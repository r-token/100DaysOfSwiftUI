//
//  Expenses.swift
//  Project7-iExpense
//
//  Created by Ryan Token on 7/17/21.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encodedItems = try? encoder.encode(items) {
                UserDefaults.standard.set(encodedItems, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decodedItems = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decodedItems
                return
            }
        }
        
        items = []
    }
}
