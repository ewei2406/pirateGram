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
    var key: String
    
    func getString(key: String) -> String? {
        return rawDocument[key] as? String
    }
    
    func getNumber(key: String) -> Int? {
        return rawDocument[key] as? Int
    }
    
    func getStringArray(key: String) -> Array<String>? {
        return rawDocument[key] as? Array<String>
    }
    
    init(rawDocument: [String : Any?], key: String) {
        self.rawDocument = rawDocument
        self.key = key
    }
}
