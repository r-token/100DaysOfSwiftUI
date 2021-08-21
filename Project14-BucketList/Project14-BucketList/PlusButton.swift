//
//  PlusButton.swift
//  Project14-BucketList
//
//  Created by Ryan Token on 8/20/21.
//

import SwiftUI
import MapKit

struct PlusButton: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var isShowingEditScreen: Bool
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    
    var body: some View {
        Button(action: {
            let newLocation = CodableMKPointAnnotation()
            newLocation.coordinate = centerCoordinate
            newLocation.title = "Example location"
            locations.append(newLocation)
            selectedPlace = newLocation
            isShowingEditScreen.toggle()
        }) {
            Image(systemName: "plus")
        }
        .padding()
        .background(Color.black.opacity(0.75))
        .foregroundColor(.white)
        .font(.title)
        .clipShape(Circle())
        .padding(.trailing)
    }
}

