//
//  FirestoreManagerTests.swift
//  pirategramTests
//
//  Created by Eddie Wei on 1/9/23.
//

import XCTest
import FirebaseFirestore
@testable import pirategram

final class FSManagerTests: XCTestCase {
    private var testFSManager: FSManager!
    private var testUser: User!
    
    override func setUp() {
        super.setUp()
        testFSManager = FSManager()
        testUser = User(bio: "this is a test user", followers: [], following: [], image: "none", likedPosts: [], posts: [])
    }
    
    func testPutDoc() throws {
        let exp = expectation(description: "Putting document in testCollection")
        var success = true
        testFSManager.putDocByID(collectionName: "test", ID: "123", document: testUser) { err in
            guard err != nil else {
                exp.fulfill()
                return
                success = false
            }
        }
        waitForExpectations(timeout: 3)
        XCTAssertTrue(success)
    }
    
    func testGetDoc() throws {
        let exp = expectation(description: "Getting document from testCollection")
        var res: User?
        
        testFSManager.getDoc(of: User.self, collection: "test", ID: "123") { result in
            switch result {
            case .success(let document):
                res = document
                exp.fulfill()
            case .failure(_):
                XCTFail("Failed!")
            }
        }

        waitForExpectations(timeout: 3)
        XCTAssertNotNil(res)
        XCTAssertEqual("this is a test user", res?.bio)
    }
//
//    func testGetCollection() throws {
//        let exp = expectation(description: "Getting all documents from testCollection")
//        var res: Array<Document>?
//
//        testFSManager.getCollection(collection: "testCollection") { result in
//            switch result {
//            case .success(let documents):
//                res = documents
//                exp.fulfill()
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//                exp.fulfill()
//            }
//        }
//
//        waitForExpectations(timeout: 3)
//        let docs = try XCTUnwrap(res)
//        XCTAssertEqual(2, docs.count)
//        XCTAssertEqual("this is the second document", docs[1].getString(key: "testString"))
//
//    }
}
