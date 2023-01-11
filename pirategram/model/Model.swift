//
//  Model.swift
//  pirategram
//
//  Created by Eddie Wei on 1/8/23.
//

import Foundation
import FirebaseFirestore

class Model: ObservableObject {
    var fsManager = FSManager()
    
    func getUser(userID: String) async -> User? {
        return await fsManager.getDoc(of: User.self, collection: "users", ID: userID)
    }
    
    func getAllPosts() async -> Array<Post> {
        return await fsManager.getCollection(of: Post.self, collection: "posts")
    }
    
    func getPostsForUser(user: String) async -> Array<Post> {
        return await fsManager.getCollectionWithCondition(of: Post.self, collection: "posts", whereField: "user", isEqualTo: user)
    }
    
    func createPost(post: Post) async {
        return 
    }
    
}
