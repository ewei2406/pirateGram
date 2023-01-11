//
//  AuthManagerTests.swift
//  pirategramTests
//
//  Created by Eddie Wei on 1/10/23.
//

import XCTest
@testable import pirategram

final class authManagerTests: XCTestCase {
    private var testAuthManager: AuthManager!
    private final var joeUID = "3cecBwEDLXbBzDV5L3KAg0qWrYV2"
    
    override func setUp() async throws {
        try await super.setUp()
        testAuthManager = AuthManager()
    }

//    func testCreateUser() async throws {
//        try await testAuthManager.createUser(email: "joe@gmail.com", password: "123456")
//    }
    
    func testAuthUser() async throws {
        let foundUID = try await testAuthManager.authUser(email: "joe@gmail.com", password: "123456")
        XCTAssertNotNil(foundUID)
        XCTAssertEqual(self.joeUID, foundUID)
    }
    
    func testAuthWrongUser() async throws {
        do {
            let foundUID = try await testAuthManager.authUser(email: "joe@gmail.com", password: "654321")
            XCTFail()
        } catch let err {
            print(err)
        }
    }
}
