//
//  SettingsView.swift
//  Project17-Flashzilla
//
//  Created by Ryan Token on 9/28/21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var recycleIncorrectAnswers: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Recycle Incorrect Answers?", isOn: $recycleIncorrectAnswers)
            }
            
            .navigationBarTitle("Settings")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
        }
    }
}
