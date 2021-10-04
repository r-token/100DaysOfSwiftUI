//
//  View+PhoneOnlyStackNavigationView.swift
//  Project19-SnowSeeker
//
//  Created by Ryan Token on 10/4/21.
//

import SwiftUI

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
