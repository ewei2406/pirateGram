//
//  pirategramTests.swift
//  pirategramTests
//
//  Created by Eddie Wei on 1/9/23.
//

import XCTest

final class pirategramTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        var a = 10
        let b = 20
        a *= 2
        XCTAssertEqual(a, b)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
