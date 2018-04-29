//  CurrentUser.swift
//
//
//  Created by Albert Huang on 4/25/18.
//

import FirebaseAuth
import UIKit
import FirebaseDatabase
import FirebaseStorage
import MBProgressHUD

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
    
    func newUser(email_inp: String, username_inp: String, id_inp: String) {
        
    }
    
    func addNewItemPost(postID: String) {
        //TODO: change readposts self.id and post ID
        dbRef.child("Users/\(self.id!)/readPosts").childByAutoId().setValue(postID)
    }
    
}

