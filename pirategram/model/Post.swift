//
//  Post.swift
//  pirategram
//
//  Created by Eddie Wei on 1/8/23.
//

import Foundation
import FirebaseFirestoreSwift

public struct Post: Codable {
    @DocumentID var id: String?
    let comments: Array<String>
    let date: Date
    let image: String
    let message: String
    let numLikes: Int
    let user: String
    
    enum CodingKeys: String, CodingKey {
        case comments
        case date
        case image
        case message
        case numLikes
        case user
    }
}
