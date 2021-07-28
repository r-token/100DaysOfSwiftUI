//
//  ContentView.swift
//  Project9.5-HabitTracking
//
//  Created by Ryan Token on 7/28/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var isShowingNewHabitSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.habitList.indices, id: \.self) { index in
                    NavigationLink(destination: HabitView(habitIndex: index).environmentObject(habits)) {
                        Text(habits.habitList[index].name)
                    }
                }
            }
            
            .sheet(isPresented: $isShowingNewHabitSheet) {
                AddHabitView(habits: habits)
            }
            
            .navigationBarTitle(Text("Habitracker"))
            
            .navigationBarItems(trailing: Button(action: {
                isShowingNewHabitSheet.toggle()
            }, label: {
                Text("New Habit")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
