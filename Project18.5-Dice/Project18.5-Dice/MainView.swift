//
//  MainView.swift
//  Project18.5-Dice
//
//  Created by Ryan Token on 10/2/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            DiceView()
                .tabItem {
                    Label("Roll", systemImage: "dice")
                }
            
            ResultsView()
                .tabItem {
                    Label("Results", systemImage: "list.bullet.rectangle.portrait")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
