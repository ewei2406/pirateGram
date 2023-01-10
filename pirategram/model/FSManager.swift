//
//  FirestoreManager.swift
//  pirategram
//
//  Created by Eddie Wei on 1/9/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum FSError: Error {
    case missingCollection(collection: String)
    case missingDocument(ID: String)
    case missingKey(key: String)
    case failToCreateDocument(collection: String, ID: String)
    case failToCastCodable
}

class FSManager {
    var db = FirebaseFirestore.Firestore.firestore()
    
    func putDocByID(collectionName: String, ID: String, document: Codable, completion: @escaping (Error?) -> Void) {
        do {
            try self.db.collection(collectionName).document(ID).setData(from: document) { err in
                if let err = err {
                    completion(err)
                    return
                }
                completion(nil)
            }
        } catch let err {
            print("Error writing: \(err)")
            completion(err)
        }
    }
    
    func getDoc<T: Codable>(of: T.Type, collection: String, ID: String, completion: @escaping (Result<T, Error>) -> Void) {
        let docRef = self.db.collection(collection).document(ID)
        docRef.getDocument{ document, error in
            guard error == nil else {
                print(error!)
                completion(.failure(FSError.missingDocument(ID: ID)))
                return
            }
            
            do {
                let res: T
                try res = document!.data(as: T.self)
                completion(.success(res))
            } catch {
                completion(.failure(FSError.failToCastCodable))
            }
        }
    }
    
    func getCollection<T: Codable>(of: T.Type, collection: String, completion: @escaping (Result<Array<T>, Error>) -> Void) {
        self.db.collection(collection).getDocuments{ querySnapshot, error in
            guard error == nil else {
                print(error!)
                completion(.failure(error!))
                return
            }
            
            if let querySnapshot = querySnapshot {
                var out: Array<T> = []
                for document in querySnapshot.documents {
                    do {
                        let res: T
                        try res = document.data(as: T.self)
                        out.append(res)
                    } catch {
                        completion(.failure(FSError.failToCastCodable))
                    }
                }
                completion(.success(out))
            }
        }
    }
    
    func deleteDocument(collection: String, ID: String, completion: @escaping (Error?) -> Void) {
        db.collection(collection).document(ID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
                completion(err)
            } else {
                print("Document successfully removed!")
                completion(nil)
            }
        }
    }
}
