//
//  FlagView.swift
//  Project2
//
//  Created by Ryan Token on 7/5/21.
//

import SwiftUI

extension Image {
    func flagViewModifier() -> some View {
        self
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
