//
//  User.swift
//  pirategram
//
//  Created by Eddie Wei on 1/8/23.
//

import Foundation

class User {
    var ID: String
    var bio: String
    var image: String
    var postIDs: Array<String>
    var followerIDs: Array<String>
    var followingIDs: Array<String>
    var likedPostIDs: Array<String>
    
    init(ID: String,
         bio: String? = "no bio provided",
         image: String? = "none",
         postIDs: Array<String>? = [],
         followerIDs: Array<String>? = [],
         followingIDs: Array<String>? = [],
         likedPostIDs: Array<String>? = []) {
        self.ID = ID
        self.bio = bio ?? "no bio provided"
        self.image = image ?? "none"
        self.postIDs = postIDs ?? []
        self.followerIDs = followerIDs ?? []
        self.followingIDs = followingIDs ?? []
        self.likedPostIDs = likedPostIDs ?? []
    }
}

func MissingUser() -> User {
    return User(ID: "")
}
