//
//  ContentView.swift
//  Project5
//
//  Created by Ryan Token on 7/10/21.
//

import SwiftUI

struct ContentView: View {
	let people = ["Finn", "Leia", "Luke", "Han"]
	
    var body: some View {
		List(people, id: \.self) { person in
			Text("\(person)")
		}
		.listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
