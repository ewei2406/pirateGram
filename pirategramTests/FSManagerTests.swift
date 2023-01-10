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
    private var testUser = User(bio: "this is a permanent test user", followers: [], following: [], image: "none", likedPosts: [], posts: [])
    
    override func setUp() async throws {
        try await super.setUp()
        testFSManager = FSManager()
        try await testFSManager.deleteDocument(collection: "test", ID: "123")
    }
    
    func testGetDoc() async throws {
        let user = try await testFSManager.getDoc(of: User.self, collection: "test", ID: "permTest")
        XCTAssertEqual("this is a permanent test user", user.bio)
    }
    
    func testGetMissingDoc() async throws {
        let user = try await testFSManager.getDoc(of: User.self, collection: "test", ID: "doesntExist")
        XCTAssertNil(user)
    }
}
