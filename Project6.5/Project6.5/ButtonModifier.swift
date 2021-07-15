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
			.frame(width: 50, height: 50)
			.background(Color.white)
			.clipShape(RoundedRectangle(cornerRadius: 5.0))
			.font(.headline)
			.shadow(radius: 10)
	}
}

extension View {
	func buttonStyle() -> some View {
		return modifier(ButtonModifier())
	}
}
