//
//  Mission.swift
//  Project8-Moonshot
//
//  Created by Ryan Token on 7/19/21.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        return "Apollo \(id)"
    }
    
    var image: String {
        return "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
