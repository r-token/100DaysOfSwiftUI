//
//  MKPointAnnotation-ObservableObject.swift
//  Project14-BucketList
//
//  Created by Ryan Token on 8/18/21.
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
