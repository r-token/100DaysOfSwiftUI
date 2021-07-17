//
//  ContentView.swift
//  Project7-iExpense
//
//  Created by Ryan Token on 7/16/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingAddExpenseView = false
    @ObservedObject var expenses = Expenses()

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItem)
            }
            
            .sheet(isPresented: $isShowingAddExpenseView) {
                AddView(expenses: expenses)
            }
            
            .navigationBarTitle(Text("iExpense"))
            .navigationBarItems(trailing: Button(action: {
                isShowingAddExpenseView.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
