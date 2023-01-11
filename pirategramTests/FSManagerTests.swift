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
    private var testUser = User(nickname: "testUser", bio: "this is a test user", followers: [], following: [], image: "none", likedPosts: [], posts: [])
    
    override func setUp() async throws {
        try await super.setUp()
        testFSManager = FSManager()
    }
    
    func testGetDoc() async throws {
        let user = try await testFSManager.getDoc(of: User.self, collection: "test", ID: "permTest")
        let unwrapUser = try XCTUnwrap(user)
        XCTAssertEqual("this is a permanent test user", unwrapUser.bio)
    }
    
    func testPutDoc() async throws {
        var queryUser = try await testFSManager.getDoc(of: User.self, collection: "test", ID: "123")
        XCTAssertNil(queryUser)
        let putID = try await testFSManager.putDoc(collection: "test", ID: "123", document: testUser)
        XCTAssertNotNil(putID)
        queryUser = try await testFSManager.getDoc(of: User.self, collection: "test", ID: "123")
        XCTAssertNotNil(queryUser)
        await testFSManager.deleteDoc(collection: "test", ID: "123")
    }
    
    func testDelDoc() async throws {
        var queryUser = try await testFSManager.getDoc(of: User.self, collection: "test", ID: "123")
        XCTAssertNil(queryUser)
        
        let putID = try await testFSManager.putDoc(collection: "test", ID: "123", document: testUser)
        XCTAssertNotNil(putID)
        
        queryUser = try await testFSManager.getDoc(of: User.self, collection: "test", ID: "123")
        XCTAssertNotNil(queryUser)
        
        await testFSManager.deleteDoc(collection: "test", ID: "123")
        queryUser = try await testFSManager.getDoc(of: User.self, collection: "test", ID: "123")
        XCTAssertNil(queryUser)
    }
    
    func testAddDoc() async throws {
        let newDocID = try await testFSManager.addDoc(collection: "test", document: testUser)
        XCTAssertNotNil(newDocID)
        
        let query = try await testFSManager.getDoc(of: User.self, collection: "test", ID: newDocID!)
        XCTAssertEqual(testUser.bio, query?.bio)
        
        await testFSManager.deleteDoc(collection: "test", ID: newDocID!)
    }
    
    func testGetMissingDoc() async throws {
        let user = try await testFSManager.getDoc(of: User.self, collection: "test", ID: "doesntExist")
        XCTAssertNil(user)
    }
    
    func testGetCollection() async throws {
        var collection = try await testFSManager.getCollection(of: User.self, collection: "test")
        let unwrapCollection = try XCTUnwrap(collection)
        XCTAssertTrue(unwrapCollection.count > 1)
    }
    
    func testGetConditional() async throws {
        let collection = try await testFSManager.getCollectionWithCondition(of: User.self, collection: "test", whereField: "nickname", isEqualTo: "bob")
        XCTAssertEqual(1, collection.count)
        XCTAssertEqual("this is a permanent test user", collection[0].bio)
    }
}
