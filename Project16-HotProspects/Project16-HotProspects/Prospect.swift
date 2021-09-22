//
//  Prospect.swift
//  Project16-HotProspects
//
//  Created by Ryan Token on 9/19/21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false // this property can be read from anywhere, but only written from the current file
    var scanDate = Date()
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect] // only code inside Prospects can call the save() method
    
    // static let saveKey = "SavedData"

    init() {
        // DOCUMENTS DIRECTORY WAY OF SAVING
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = paths[0]
        
        if let data = try? Data(contentsOf: path.appendingPathComponent("people")) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        
        // USER DEFAULTS WAY OF SAVING
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
        
        people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        // DOCUMENTS DIRECTORY WAY OF SAVING
        if let encoded = try? JSONEncoder().encode(people) {
            try? encoded.write(to: getDocumentsDirectory().appendingPathComponent("people"), options: [.atomicWrite, .completeFileProtection])
            
            // USER DEFAULTS WAY OF SAVING
            // UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
