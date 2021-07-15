//
//  ButtonModifier.swift
//  Project6.5
//
//  Created by Ryan Token on 7/14/21.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.clipShape(RoundedRectangle(cornerRadius: 5.0))
			.font(.headline)
			.shadow(radius: 10)
	}
}

struct StartButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 50)
            .background(Color.white)
            .foregroundColor(.purple)
            .font(.title2)
            .clipShape(Capsule())
            .shadow(radius: 20)
    }
}

extension View {
	func buttonStyle() -> some View {
		return modifier(ButtonModifier())
	}
}

extension View {
    func startButtonStyle() -> some View {
        return modifier(StartButtonModifier())
    }
}
