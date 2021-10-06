//
//  Favorites.swift
//  Project19-SnowSeeker
//
//  Created by Ryan Token on 10/5/21.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            let decoder = JSONDecoder()
            do {
                resorts = try decoder.decode(Set<String>.self, from: savedData)
            } catch {
                print("decoding failed")
                resorts = []
            }
        } else {
            print("no favorite resorts")
            resorts = []
        }
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(resorts)
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("encoding failed")
        }
    }
}
