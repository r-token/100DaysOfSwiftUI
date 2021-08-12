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
    @State private var processedImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var isShowingImagePicker = false
    @State private var isShowingFilterSheet = false
    @State private var selectedImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
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
                        isShowingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = processedImage else { return }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Saved successfully!")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $selectedImage)
            }
            
            .actionSheet(isPresented: $isShowingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
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
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
