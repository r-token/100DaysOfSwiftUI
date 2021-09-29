//
//  ContentView.swift
//  Project18-LayoutAndGeometry
//
//  Created by Ryan Token on 9/29/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@swiftui")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("SwiftUI")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 125, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("SwiftUI")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.title)
                
            }
        }
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
