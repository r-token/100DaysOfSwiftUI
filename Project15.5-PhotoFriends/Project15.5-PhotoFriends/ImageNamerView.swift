//
//  ImageNamerView.swift
//  Project15.5-PhotoFriends
//
//  Created by Ryan Token on 9/12/21.
//

import SwiftUI

struct ImageNamerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var name: String
    
    var body: some View {
        VStack {
            TextField("Enter a Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.words)
                .padding()
            
            Button("Done") {
                print(name)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
