//
//  CheckoutView.swift
//  Project10-CupcakeCorner
//
//  Created by Ryan Token on 7/30/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderClass: OrderClass
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var isShowingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(hidden: true)
                    
                    Text("Order Summary:")
                        .font(.headline)
                    
                    VStack(spacing: 5) {
                        Text("\(orderClass.order.quantity) \(OrderClass.types[orderClass.order.type]) cupcakes")
                        
                        if orderClass.order.specialRequestEnabled {
                            if orderClass.order.extraFrosting {
                                Text("* Extra Frosting")
                            }
                            if orderClass.order.addSprinkles {
                                Text("* Extra Sprinkles")
                            }
                        }
                    }
                    .padding()
                    
                    Text("Your total is $\(orderClass.order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        if #available(iOS 15.0, *) {
                            Task {
                                do {
                                    try await placeOrderAsync()
                                } catch {
                                    confirmationTitle = "Unable to place order"
                                    confirmationMessage = error.localizedDescription
                                    isShowingConfirmation = true
                                    print(error.localizedDescription)
                                }
                            }
                        } else {
                            // Fallback on earlier versions
                            placeOrder()
                        }
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $isShowingConfirmation) {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        
        .navigationBarTitle("Check out", displayMode: .inline)
    }
    
    func prepareURL() -> URLRequest? {
        // 1. Convert our current order object into some JSON data that can be sent
        guard let encodedOrder = try? JSONEncoder().encode(orderClass.order) else {
            print("Failed to encode order")
            return nil
        }
        
        // 2. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedOrder
        
        return request
    }
    
    func placeOrder() {
        print("Using normal placeOrder function.")
        
        if let request = prepareURL() {
            // 3. Run that request and process the response
            URLSession.shared.dataTask(with: request) { data, response, error in
                // we'll get `data` (if successful) OR `error` (if unsuccessful) back, but not both
                
                guard let data = data else {
                    confirmationTitle = "Unable to place order 😓"
                    confirmationMessage = "\(error?.localizedDescription ?? "Unknown error")"
                    isShowingConfirmation = true
                    return
                }
                
                if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                    confirmationTitle = "Thank you!"
                    confirmationMessage = "Your order for \(decodedOrder.quantity) \(OrderClass.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                    isShowingConfirmation = true
                } else {
                    print("Invalid response from server")
                }
            }.resume()
        } else {
            print("Got a nil response when encoding the order from prepareURL()")
        }
    }
    
    @available(iOS 15.0, *)
    func placeOrderAsync() async throws {
        print("Using async placeOrder function!")
        
        if let request = prepareURL() {
            // 3. Run that request and process the response using new ASYNC/AWAIT structure
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                confirmationTitle = "Thank you!"
                confirmationMessage = "Your order for \(decodedOrder.quantity) \(OrderClass.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                isShowingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        } else {
            print("Got a nil response when encoding the order from prepareURL()")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderClass: OrderClass())
    }
}
