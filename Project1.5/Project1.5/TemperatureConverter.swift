//
//  TemperatureConverter.swift
//  Project1.5
//
//  Created by Ryan Token on 7/1/21.
//

import SwiftUI

struct TemperatureConverter: View {
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    @State private var degreeValue = "0"
    
    let degreeOptions = ["Fahrenheit", "Celsius", "Kelvin"]
    
    var result: String {
        switch degreeOptions[inputUnit] {
        case "Fahrenheit":
            return fahrenheitConverter(inputValue: Double(degreeValue) ?? 0.00, outputUnit: degreeOptions[outputUnit])
        case "Celsius":
            return celsiusConverter(inputValue: Double(degreeValue) ?? 0.00, outputUnit: degreeOptions[outputUnit])
        case "Kelvin":
            return kelvinConverter(inputValue: Double(degreeValue) ?? 0.00, outputUnit: degreeOptions[outputUnit])
        default:
            return "Unknown"
        }
    }
    
    func fahrenheitConverter(inputValue: Double, outputUnit: String) -> String {
        switch outputUnit {
        case "Fahrenheit":
            return String(inputValue)
        case "Celsius":
            let celsiusValue = (inputValue - 32) * 0.5556
            return String(celsiusValue)
        case "Kelvin":
            let kelvinValue = 0.5556 * (inputValue - 32) + 273
            return String(kelvinValue)
        default:
            return "0"
        }
    }
    
    func celsiusConverter(inputValue: Double, outputUnit: String) -> String {
        switch outputUnit {
        case "Fahrenheit":
            let faherenheitValue = 0.5556 * (inputValue) + 32
            return String(faherenheitValue)
        case "Celsius":
            return String(inputValue)
        case "Kelvin":
            let kelvinValue = inputValue + 273
            return String(kelvinValue)
        default:
            return "0"
        }
    }
    
    func kelvinConverter(inputValue: Double, outputUnit: String) -> String {
        switch outputUnit {
        case "Fahrenheit":
            let faherenheitValue = 0.5556 * (inputValue - 273) + 32
            return String(faherenheitValue)
        case "Celsius":
            let celsiusValue = inputValue - 273
            return String(celsiusValue)
        case "Kelvin":
            return String(inputValue)
        default:
            return "0"
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Degrees")) {
                    TextField("Degrees", text: $degreeValue)
                }
                
                Section(header: Text("Input Unit")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0 ..< degreeOptions.count) { degree in
                            Text(degreeOptions[degree])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output Unit")) {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(0 ..< degreeOptions.count) { degree in
                            Text(degreeOptions[degree])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(Double(result) ?? 0.00, specifier: "%.2f") Degrees \(degreeOptions[outputUnit])")
                }
            }
            .navigationBarTitle("Temp Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConverter()
    }
}
