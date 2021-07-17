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
    
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
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
            })
        }
        
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func addItem() {
        if let actualAmount = Int(expenseAmount) {
            let newItem = ExpenseItem(name: expenseName, type: expenseType, amount: actualAmount)
            
            expenses.items.append(newItem)
            presentationMode.wrappedValue.dismiss()
        } else {
            alertTitle = "Invalid expense amount ☹️"
            alertMessage = "Enter a number for the expense amount."
            isShowingAlert.toggle()
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
