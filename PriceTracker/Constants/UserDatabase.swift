//
//  UserDatabase.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/21/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import Foundation

var users : [String : ProfileVC] = ["Emily2" : ProfileVC(), "Michelle" : ProfileVC(), "Emily" : ProfileVC(), "Albert" : ProfileVC(), "Albert2" : ProfileVC(), "Michelle2" : ProfileVC(), "iOS" : ProfileVC(), "CS170" : ProfileVC(), "Wishlist" : ProfileVC(), "Price Tracker" : ProfileVC()]

func getUsernames() -> [String] {
    return Array(users.keys)
}

func addUser(name: String, profile: ProfileVC) {
    users[name] = profile
}
