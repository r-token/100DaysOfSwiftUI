//
//  ContentView.swift
//  Project19-SnowSeeker
//
//  Created by Ryan Token on 10/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var activeSheet: ActiveSheet?
    
    enum ActiveSheet: Identifiable {
        case picker
        
        var id: UUID {
            UUID()
        }
    }
    
    var body: some View {
        NavigationView {
            Text("Hello, World!")
            
            .sheet(item: $activeSheet) { sheet in
                SheetView()
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        activeSheet = ActiveSheet.picker
                    }) {
                        Text("Choose Me")
                    }
                }
            }
        }
    }
}

struct SheetView: View {
    var body: some View {
        Text("A new sheet")
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
