//
//  UserDatabase.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/21/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

var users : [String : ProfileVC] = ["Emily2" : ProfileVC(), "Michelle" : ProfileVC(), "Emily" : ProfileVC(), "Albert" : ProfileVC(), "Albert2" : ProfileVC(), "Michelle2" : ProfileVC(), "iOS" : ProfileVC(), "CS170" : ProfileVC(), "Wishlist" : ProfileVC(), "Price Tracker" : ProfileVC()]

func getUsernames() -> [String] {
    return Array(users.keys)
}

//func getUsernames(completion: @escaping ([String]) -> Void) {
//    var usernameArray: [String] = []
//    let dbRef = Database.database().reference()
//    dbRef.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
//        if snapshot.exists() {
//            if let userids = snapshot.value as? [String:AnyObject] {
//                for key in userids.keys {
//                    usernameArray.append(userids[key]!["username"] as! String)
//                }
//                completion(usernameArray)
//            } else {
//                completion([])
//            }
//        } else {
//            completion([])
//        }
//    })
//}

func addUser(name: String, profile: ProfileVC) {
    users[name] = profile
}

