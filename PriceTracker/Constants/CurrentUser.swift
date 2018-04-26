//
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
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
    }
    
    func getReadPostIDs(completion: @escaping ([String]) -> Void) {
        var postArray: [String] = []
        dbRef.child("Users/\(id!)/readPosts").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    for key in posts.keys {
                        postArray.append(posts[key] as! String)
                    }
                    completion(postArray)
                } else {
                    completion([])
                }
            } else {
                completion([])
            }
        })
    }
    
    func addNewReadPost(postID: String) {
        dbRef.child("Users/\(self.id!)/readPosts").childByAutoId().setValue(postID)
    }
    
}
