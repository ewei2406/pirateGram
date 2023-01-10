//
//  FirestoreManager.swift
//  pirategram
//
//  Created by Eddie Wei on 1/9/23.
//

import Foundation
import FirebaseFirestore

enum FSError: Error {
    case missingCollection(key: String)
    case missingDocument(key: String)
}

class FSManager {
    var db = FirebaseFirestore.Firestore.firestore()
    
    func getDocument(collection: String, ID: String, completion: @escaping (Result<Document, FSError>) -> Void) {
        let docRef = self.db.collection(collection).document(ID)
        docRef.getDocument{ (document, error) in
            guard error == nil else {
                print(error!)
                completion(.failure(.missingDocument(key: ID)))
                return
            }
            
            if let document = document, document.exists {
                var data = document.data()!
                completion(.success(Document(rawDocument: data, key: ID)))
            }
        }
    }
    
    func getCollection(collection: String, completion: @escaping (Result<Array<Document>, FSError>) -> Void) {
        self.db.collection(collection).getDocuments{ (querySnapshot, error) in
            guard error == nil else {
                print(error!)
                completion(.failure(.missingCollection(key: collection)))
                return
            }
            
            if let querySnapshot = querySnapshot {
                var out: Array<Document> = []
                for document in querySnapshot.documents {
                    var docData = document.data()
                    out.append(Document(rawDocument: docData, key: document.documentID))
                }
                completion(.success(out))
            }
        }
    }
}
