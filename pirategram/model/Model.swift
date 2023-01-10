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
    
    func getUser(ID: String, completion: @escaping (Result<User, FSError>) -> Void) {
        fsManager.getDocument(collection: "users", ID: ID) { result in
            switch result {
            case .success(let document):
                
                let user = User(
                    ID: ID,
                    bio: document.getString(key: "bio"),
                    image: document.getString(key: "image"),
                    postIDs: document.getStringArray(key: "posts"),
                    followerIDs: document.getStringArray(key: "followers"),
                    followingIDs: document.getStringArray(key: "following"),
                    likedPostIDs: document.getStringArray(key: "likedPosts")
                )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    func getPost(ID: String, completion: @escaping (_ result: User?) -> Void) {
//        fsManager.getDocument(collection: "users", ID: ID) { rawUser in
//            guard let rawUser = rawUser else { return }
//            completion(User(
//                ID: ID,
//                bio: rawUser["bio"] as? String ?? "",
//                image: rawUser["image"] as? String ?? "",
//                postIDs: rawUser["posts"] as? Array<String> ?? [],
//                followerIDs: rawUser["followers"] as? Array<String> ?? [],
//                followingIDs: rawUser["following"] as? Array<String> ?? [],
//                likedPostIDs: rawUser["likedPosts"] as? Array<String> ?? []))
//        }
//    }
}
