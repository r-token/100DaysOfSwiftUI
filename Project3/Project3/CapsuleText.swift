//
//  CapsuleText.swift
//  Project3
//
//  Created by Ryan Token on 7/3/21.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.title)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct CapsuleText_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleText(text: "Hi there")
    }
}
