//
//  Comment.swift
//  pirategram
//
//  Created by Eddie Wei on 1/8/23.
//

import Foundation

class Comment {
    var ID: String
    var userID: String
    var postID: String
    var prevID: String
    var message: String
    
    init(ID: String, userID: String, postID: String, prevID: String, message: String) {
        self.ID = ID
        self.userID = userID
        self.postID = postID
        self.prevID = prevID
        self.message = message
    }
}
