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

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "SwiftUI") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
        // NEW FILTER API
        
        // let currentFilter = CIFilter.sepiaTone()
        // let currentFilter = CIFilter.pixellate()
        // let currentFilter = CIFilter.crystallize()
        
        // currentFilter.intensity = 1
        // currentFilter.scale = 8
        // currentFilter.radius = 15
        
        // currentFilter.inputImage = beginImage
        
        // OLD FILTER API
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(100, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2), forKey: kCIInputCenterKey)
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        // attempt to get a CGImage from our CIImage
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgImage)
            
            // and convert THAT to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
