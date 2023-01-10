//
//  Post.swift
//  pirategram
//
//  Created by Eddie Wei on 1/8/23.
//

import Foundation

class Post {
    var ID: String
    var image: String
    var message: String
    var numLikes: Int
    var userID: String
    var date: Date
    var commentIDs: Array<String>
    
    init(ID: String, image: String, message: String, numLikes: Int, userID: String, date: Date, commentIDs: Array<String>) {
        self.ID = ID
        self.image = image
        self.message = message
        self.numLikes = numLikes
        self.userID = userID
        self.date = date
        self.commentIDs = commentIDs
    }
}
