//
//  GridStack.swift
//  Project3
//
//  Created by Ryan Token on 7/3/21.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

//struct GridStack_Previews: PreviewProvider {
//    static var previews: some View {
//        GridStack()
//    }
//}
