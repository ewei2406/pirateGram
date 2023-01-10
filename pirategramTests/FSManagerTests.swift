//
//  FirestoreManagerTests.swift
//  pirategramTests
//
//  Created by Eddie Wei on 1/9/23.
//

import XCTest
@testable import pirategram

final class FSManagerTests: XCTestCase {
    private var testFSManager: FSManager!
    
    override func setUp() {
        super.setUp()
        testFSManager = FSManager()
    }
    
    func testGetDocument() throws {
        let exp = expectation(description: "Getting document from testCollection")
        var res: Document?
        
        testFSManager.getDocument(collection: "testCollection", ID: "test1") { result in
            switch result {
            case .success(let document):
                res = document
                exp.fulfill()
            case .failure(_):
                XCTFail("Failed!")
            }
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual("this is a string", res!.getString(key: "testString"))
        XCTAssertEqual("value 2", res!.getStringArray(key: "testArray")![1])
    }
    
    func testGetCollection() throws {
        let exp = expectation(description: "Getting all documents from testCollection")
        var res: Array<Document>?
        
        testFSManager.getCollection(collection: "testCollection") { result in
            switch result {
            case .success(let documents):
                res = documents
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
        let docs = try XCTUnwrap(res)
        XCTAssertEqual(2, docs.count)
        XCTAssertEqual("this is the second document", docs[1].getString(key: "testString"))
        
    }
}
