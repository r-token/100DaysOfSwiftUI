//
//  ContentView.swift
//  Project14-BucketList
//
//  Created by Ryan Token on 8/15/21.
//

import SwiftUI

struct ContentView: View {
    var loadingState = LoadingState.loading
    
    enum LoadingState {
        case loading, success, failed
    }
    
    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else {
                FailedView()
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
