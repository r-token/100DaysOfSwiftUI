//
//  ContentView.swift
//  Project10-CupcakeCorner
//
//  Created by Ryan Token on 7/29/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var orderClass = OrderClass()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderClass.order.type) {
                        ForEach(0..<OrderClass.types.count) {
                            Text(OrderClass.types[$0])
                        }
                    }
                    
                    Stepper(value: $orderClass.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(orderClass.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $orderClass.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if orderClass.order.specialRequestEnabled {
                        Toggle(isOn: $orderClass.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $orderClass.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(orderClass: orderClass)) {
                        Text("Delivery details")
                    }
                }
            }
            
            .navigationBarTitle("CupcakeCorner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
