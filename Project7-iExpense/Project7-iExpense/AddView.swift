//
//  AddView.swift
//  Project7-iExpense
//
//  Created by Ryan Token on 7/17/21.
//

import SwiftUI

struct AddView: View {
    @State private var expenseName = ""
    @State private var expenseType = "Personal"
    @State private var expenseAmount = ""
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.presentationMode) var presentationMode
    
    static let expenseTypes = ["Personal", "Business"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Expense Name", text: $expenseName)
                
                Picker("Expense Type", selection: $expenseType) {
                    ForEach(AddView.expenseTypes, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Expense Amount", text: $expenseAmount)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            
            .navigationBarTitle(Text("Add Expense"))
            .navigationBarItems(trailing: Button("Save") {
                addItem()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func addItem() {
        if let actualAmount = Int(expenseAmount) {
            let newItem = ExpenseItem(name: expenseName, type: expenseType, amount: actualAmount)
            
            expenses.items.append(newItem)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
