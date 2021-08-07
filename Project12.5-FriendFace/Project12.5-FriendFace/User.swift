//
//  User.swift
//  User
//
//  Created by Ryan Token on 8/7/21.
//

import Foundation

struct User: Codable, Identifiable {
    var id = ""
    var isActive = false
    var name = ""
    var age = 0
    var company = ""
    var email = ""
    var address = ""
    var about = ""
    var registered = ""
    var tags = [""]
    
    var friends = [Friend]()
}
