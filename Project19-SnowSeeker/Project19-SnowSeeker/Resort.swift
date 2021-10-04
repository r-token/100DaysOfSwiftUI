//
//  Resort.swift
//  Project19-SnowSeeker
//
//  Created by Ryan Token on 10/4/21.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    // static let = lazy loading. when we try to read Resort.example, Swift will be forced to  create Resort.allResorts before sending back the first item in the array
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
