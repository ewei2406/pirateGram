//
//  User.swift
//  pirategram
//
//  Created by Eddie Wei on 1/8/23.
//

import Foundation

//class User {
//    var ID: String
//    var bio: String
//    var image: String
//    var postIDs: Array<String>
//    var followerIDs: Array<String>
//    var followingIDs: Array<String>
//    var likedPostIDs: Array<String>
//
//    init(ID: String,
//         bio: String? = "no bio provided",
//         image: String? = "none",
//         postIDs: Array<String>? = [],
//         followerIDs: Array<String>? = [],
//         followingIDs: Array<String>? = [],
//         likedPostIDs: Array<String>? = []) {
//        self.ID = ID
//        self.bio = bio ?? "no bio provided"
//        self.image = image ?? "none"
//        self.postIDs = postIDs ?? []
//        self.followerIDs = followerIDs ?? []
//        self.followingIDs = followingIDs ?? []
//        self.likedPostIDs = likedPostIDs ?? []
//    }
//}

import FirebaseFirestoreSwift
import FirebaseFirestore

public struct User: Codable {
    @DocumentID var id: String?
    let nickname: String
    let bio: String
    let followers: Array<String>
    let following: Array<String>
    let image: String
    let likedPosts: Array<String>
    let posts: Array<String>
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case bio
        case followers
        case following
        case image
        case likedPosts
        case posts
    }
}

func MissingUser() -> User {
    return User(nickname: "missingUser", bio: "hello World", followers: [], following: [], image: "none", likedPosts: [], posts: [])
}
