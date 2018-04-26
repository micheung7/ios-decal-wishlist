//  CurrentUser.swift
//
//
//  Created by Albert Huang on 4/25/18.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class CurrentUser {
    
    var username: String!
    var id: String!
    var email: String!
    var friendList: [String]
    var itemList: [String]
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
        email = currentUser?.email
        friendList = [String]()
        itemList = [String]()
    }
    
    func addNewItemPost(postID: String) {
        //TODO: change readposts self.id and post ID
        dbRef.child("Users/\(self.id!)/readPosts").childByAutoId().setValue(postID)
    }
    
}

