//
//  AssignmentMinderaTests.swift
//  AssignmentMinderaTests
//
//  Created by Angelos Staboulis on 18/8/21.
//

import XCTest
@testable import AssignmentMindera

class AssignmentMinderaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = XCTestExpectation(description: "fetchLaunches")
        LaunchesNetwork.shared.fetchLaunches { (array) in
            defer{expectation.fulfill()}
            XCTAssertNotNil(array)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
