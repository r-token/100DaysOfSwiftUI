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
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
}
