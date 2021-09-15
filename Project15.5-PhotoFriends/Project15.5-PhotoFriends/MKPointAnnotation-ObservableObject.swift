//
//  MKPointAnnotation-ObservableObject.swift
//  Project15.5-PhotoFriends
//
//  Created by Ryan Token on 9/14/21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
