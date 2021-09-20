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
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        people = []
    }
}
