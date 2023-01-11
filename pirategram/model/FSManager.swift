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
    case missingCollection
    case missingDocument
    case missingKey
    case failToCreateDocument
    case failToCastCodable
    case failToDelete
    case unknownError
}

class FSManager {
    var db = FirebaseFirestore.Firestore.firestore()
    
    /// Puts a document into a collection `collection` with ID `ID`.
    /// Will overwrite existing document or create a new one if not already existing.
    /// Returns the ID of the modified document, or `nil` if it failed.
    func putDoc(collection: String, ID: String, document: Codable) async -> String? {
        return await withCheckedContinuation { continuation in
            do {
                try self.db.collection(collection).document(ID).setData(from: document) { err in
                    if err != nil { continuation.resume(returning: nil) }
                    print("put document '\(document)' in collection '\(collection)' with ID '\(ID)'")
                    continuation.resume(returning: ID)
                }
            } catch {
                continuation.resume(returning: nil)
            }
        }
    }
    
    /// Creates a new document in a collection `collection`.
    /// Returns the ID of the newly created document.
    func addDoc(collection: String, ID: String, document: Codable) async -> String? {
        return await withCheckedContinuation { continuation in
            do {
                var ref: DocumentReference? = nil
                ref = try self.db.collection(collection).addDocument(from: document) { err in
                    if err != nil {
                        continuation.resume(returning: nil)
                    } else {
                        continuation.resume(returning: ref!.documentID)
                    }
                }
            } catch {
                continuation.resume(returning: nil)
            }
        }
    }
    
    /// Gets document specified by `ID` from collection `collection` and casts to `T: Codable`.
    /// If document is not found, returns `nil`.
    func getDoc<T: Codable>(of: T.Type, collection: String, ID: String) async -> T? {
        return await withCheckedContinuation { continuation in
            let docRef = self.db.collection(collection).document(ID)
            docRef.getDocument{ document, error in
                if error != nil { continuation.resume(returning: nil) }
                do {
                    let res: T
                    try res = document!.data(as: T.self)
                    print("retrieved document '\(res)' in collection '\(collection)' with ID '\(ID)'")
                    continuation.resume(returning: res)
                } catch {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    /// Gets and casts all documents of collection `collection` as `Array<T: Codable>`.
    /// If collection is empty or does not exist, returns an empty `Array`.
    /// Only returns documents that were successfully cast.
    func getCollection<T: Codable>(of: T.Type, collection: String) async -> Array<T> {
        return await withCheckedContinuation { continuation in
            self.db.collection(collection).getDocuments{ querySnapshot, error in
                if error != nil || querySnapshot == nil { continuation.resume(returning: []) }
                var docArray = [T]()
                for document in querySnapshot!.documents {
                    do {
                        let res: T
                        try res = document.data(as: T.self)
                        docArray.append(res)
                    } catch { }
                }
                print("retrieved \(docArray.count) documents from collection '\(collection)'")
                continuation.resume(returning: docArray)
            }
        }
    }
    
    /// Gets and casts documents that have field `whereField = isEqualTo` of collection `collection` as `Array<T: Codable>`.
    /// If nothing is found or collection does not exist, returns an empty `Array`.
    /// Only returns documents that were successfully cast.
    func getCollectionWithCondition<T: Codable>(of: T.Type, collection: String, whereField: String, isEqualTo: String) async -> Array<T> {
        return await withCheckedContinuation { continuation in
            self.db.collection(collection).whereField(whereField, isEqualTo: isEqualTo).getDocuments{ querySnapshot, error in
                if error != nil || querySnapshot == nil { continuation.resume(returning: []) }
                var docArray = [T]()
                for document in querySnapshot!.documents {
                    do {
                        let res: T
                        try res = document.data(as: T.self)
                        docArray.append(res)
                    } catch { }
                }
                print("retrieved \(docArray.count) documents from collection '\(collection)'")
                continuation.resume(returning: docArray)
            }
        }
    }
    
    /// Deletes document with ID `ID` from collection `collection`.
    func deleteDoc(collection: String, ID: String) async -> Void {
        return await withCheckedContinuation { continuation in
            self.db.collection(collection).document(ID).delete() { err in
                if err == nil { print("deleted document ID '\(ID)' from collection '\(collection)'") }
                continuation.resume()
            }
        }
    }
}
