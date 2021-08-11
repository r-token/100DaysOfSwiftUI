//
//  ContentView.swift
//  Project13-Instafilter
//
//  Created by Ryan Token on 8/8/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var currentFilter = CIFilter.sepiaTone()
    
    let context = CIContext()

    
    var body: some View {
        let intensity = Binding<Double> (
            get: {
                filterIntensity
            },
            set: {
                filterIntensity = $0
                applyProcessing()
            }
        )
        
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    isShowingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        // change filter
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        // save the image
                    }
                }
            }
            
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $selectedImage)
            }
            
            .padding([.horizontal, .vertical])
            .navigationBarTitle("Instafilter")
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        
        let beginImage = CIImage(image: selectedImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
