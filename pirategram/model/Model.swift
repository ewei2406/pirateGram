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
    
    func getUser(userID: String) async throws -> User? {
        return try await fsManager.getDoc(of: User.self, collection: "users", ID: userID)
    }
        
    func getAllPosts() async throws -> Array<Post> {
        return try await fsManager.getCollection(of: Post.self, collection: "posts")
    }
    
    func getPostsForUser(user: String) async throws -> Array<Post> {
        return try await fsManager.getCollectionWithCondition(of: Post.self, collection: "posts", whereField: "user", isEqualTo: user)
    }
    
    func createPost(post: Post) async throws -> String? {
        return try await fsManager.addDoc(collection: "posts", document: post)
    }
    
    func getCommentsForPost(postID: String) async throws -> Array<Comment> {
        return try await fsManager.getCollectionWithCondition(of: Comment.self, collection: "comments", whereField: "post", isEqualTo: postID)
    }
}
