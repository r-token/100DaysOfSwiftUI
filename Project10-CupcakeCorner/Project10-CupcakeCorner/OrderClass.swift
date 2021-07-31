//
//  OrderClass.swift
//  Project10-CupcakeCorner
//
//  Created by Ryan Token on 7/31/21.
//

import Foundation

class OrderClass: ObservableObject {
    @Published var order = Order()
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
}
