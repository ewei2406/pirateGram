//
//  Document.swift
//  pirategram
//
//  Created by Eddie Wei on 1/9/23.
//

import Foundation

enum DocumentError: Error {
    case missingKey(key: String)
}

class Document {
    private var rawDocument: [String: Any?]
    var ID: String?
    
    func keys() -> Array<String> {
        return Array(self.rawDocument.keys)
    }
    
    func addKeyPair(key: String, value: Any) {
        self.rawDocument[key] = value
    }
    
    func dropKey(key: String) {
        self.rawDocument.removeValue(forKey: key)
    }
    
    func dropAllKeys() {
        self.rawDocument.removeAll()
    }
    
    func getString(key: String) -> String? {
        return rawDocument[key] as? String
    }
    
    func getNumber(key: String) -> Int? {
        return rawDocument[key] as? Int
    }
    
    func getStringArray(key: String) -> Array<String>? {
        return rawDocument[key] as? Array<String>
    }
    
    init(rawDocument: [String : Any?]? = nil, ID: String? = nil) {
        self.rawDocument = rawDocument ?? [:]
        self.ID = ID
    }
}
