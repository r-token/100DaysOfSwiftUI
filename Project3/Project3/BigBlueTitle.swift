//
//  BigBlueTitle.swift
//  Project3
//
//  Created by Ryan Token on 7/5/21.
//

import SwiftUI

struct BigBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .font(.body.bold())
            .foregroundColor(.blue)
    }
}

extension View {
    func bigBlueTitle() -> some View {
        self.modifier(BigBlueTitle())
    }
}
