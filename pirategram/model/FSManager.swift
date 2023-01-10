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
    /// Returns `true` if successful, `false` otherwise.
    func putDocument(collection: String, ID: String, document: Codable) async -> Bool {
        return await withCheckedContinuation { continuation in
            do {
                try self.db.collection(collection).document(ID).setData(from: document) { err in
                    if err != nil { continuation.resume(returning: false) }
                    continuation.resume(returning: true)
                }
            } catch {
                continuation.resume(returning: false)
            }
        }
    }
    
    /// Gets document specified by `ID` from collection `collection` and casts to `T: Codable`.
    func getDoc<T: Codable>(of: T.Type, collection: String, ID: String) async throws -> T {
        return try await withCheckedThrowingContinuation{ continuation in
            let docRef = self.db.collection(collection).document(ID)
            docRef.getDocument{ document, error in
                if error != nil { continuation.resume(throwing: FSError.missingDocument) }
                do {
                    let res: T
                    try res = document!.data(as: T.self)
                    continuation.resume(with: .success(res))
                } catch {
                    continuation.resume(throwing: FSError.failToCastCodable)
                }
            }
        }
    }

    /// Gets and casts all documents of collection `collection` as `Array<T: Codable>`.
    func getCollection<T: Codable>(of: T.Type, collection: String) async throws -> Array<T> {
        return try await withCheckedThrowingContinuation { continuation in
            self.db.collection(collection).getDocuments{ querySnapshot, error in
                if error != nil || querySnapshot == nil { continuation.resume(throwing: FSError.missingCollection) }
                var docArray: Array<T> = []
                for document in querySnapshot!.documents {
                    do {
                        let res: T
                        try res = document.data(as: T.self)
                        docArray.append(res)
                    } catch {
                        continuation.resume(throwing: FSError.failToCastCodable)
                    }
                }
                continuation.resume(with: .success(docArray))
            }
        }
    }
    
    /// Deletes document with ID `ID` from collection `collection`.
    func deleteDocument(collection: String, ID: String) async throws -> Void {
        return try await withCheckedThrowingContinuation { continuation in
            self.db.collection(collection).document(ID).delete() { err in
                if err != nil { continuation.resume(throwing: FSError.failToDelete) }
                continuation.resume()
            }
        }
    }
}
