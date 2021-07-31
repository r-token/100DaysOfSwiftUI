//
//  AddressView.swift
//  Project10-CupcakeCorner
//
//  Created by Ryan Token on 7/30/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderClass: OrderClass
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderClass.order.name)
                TextField("Street Address", text: $orderClass.order.streetAddress)
                TextField("City", text: $orderClass.order.city)
                TextField("Zip", text: $orderClass.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(orderClass: orderClass)) {
                    Text("Check out")
                }
            }
            .disabled(orderClass.order.hasValidAddress == false)
        }
        
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderClass: OrderClass())
    }
}
