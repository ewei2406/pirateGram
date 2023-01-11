//
//  Comment.swift
//  pirategram
//
//  Created by Eddie Wei on 1/8/23.
//

import Foundation
import FirebaseFirestoreSwift

public struct Comment: Codable {
    @DocumentID var id: String?
    let message: String
    let post: String
    let user: String
    let prev: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case post
        case user
        case prev
    }
}
