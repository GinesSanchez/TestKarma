//
//  NetworkManagerTests.swift
//  TestKarmaTests
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import XCTest
@testable import TestKarma

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!

    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testNetworkManager_executeRequest_SuccessResponse() {
        let components = NSURLComponents(string: "https://storage.googleapis.com/engineering-4b0b7d62/locations_filtered.json")
        let expectation = XCTestExpectation()

        guard let url = components?.url else {
            XCTFail()
            return
        }

        networkManager.execute(urlRequest: URLRequest(url: url)) { (data, response, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testNetworkManager_executeRequest_Error() {
        let components = NSURLComponents(string: "https://www.invented.url.com")
        let expectation = XCTestExpectation()

        guard let url = components?.url else {
            XCTFail()
            return
        }

        networkManager.execute(urlRequest: URLRequest(url: url)) { (data, response, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(response)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }


}
