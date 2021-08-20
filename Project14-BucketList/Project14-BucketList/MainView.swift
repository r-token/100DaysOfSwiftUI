//
//  MainView.swift
//  Project14-BucketList
//
//  Created by Ryan Token on 8/20/21.
//

import SwiftUI
import MapKit

struct MainView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var isShowingEditScreen: Bool
    
    @Binding var locations: [CodableMKPointAnnotation]
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    PlusButton(centerCoordinate: $centerCoordinate, isShowingEditScreen: $isShowingEditScreen, locations: $locations, selectedPlace: $selectedPlace)
                }
            }
        }
    }
}


