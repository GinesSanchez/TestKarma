//
//  LocalManagerTests.swift
//  TestKarmaTests
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import XCTest
@testable import TestKarma

class LocalManagerTests: XCTestCase {

    var mockNetworkManager: MockNetworkManager!
    var localManager: LocalManager!

    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        localManager = LocalManager(networkManager: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testGetLocals_WithValidResponse_ReturnLocalsArray() {
        let string = """
                        [
                        {
                            "id": 3335,
                            "name": "Wayne's Coffee Konserthuset",
                            "latitude": 59.335125,
                            "longitude": 18.063491,
                            "following": false,
                            "description": "Välkommen till Wayne's Coffee! Vi är Sveriges första KRAV-märkta kafékedja. I våra kaféer erbjuds kaffe av eget märke, bakverk från eget bageri och mat med naturliga råvaror av hög kvalitet.",
                            "phone": "08 - 442 2440",
                            "website": "http://www.waynescoffee.se"
                        },
                        {
                            "id": 3331,
                            "name": "Nybrogatan 38",
                            "latitude": 59.337782,
                            "longitude": 18.079946,
                            "following": false,
                            "description": "Välkommen till Nybrogatan 38! Vi hämtar inspiration från de sydeuropeiska och de svenska grytorna. Kvarterskrogsaktigt och gott. Ni kommer gilla oss.",
                            "phone": "08-662 33 22",
                            "website": "http://www.nybrogatan38.com"
                        }
                        ]
                    """
        guard let data = string.data(using: .utf8) else {
            XCTFail()
            return
        }

        mockNetworkManager.customData = data
        mockNetworkManager.customError = nil
        mockNetworkManager.customResponse = nil

        localManager.getLocals { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let localsArray):
                XCTAssertEqual(localsArray.count, 2)

                guard let firstLocal = localsArray.first else {
                    XCTFail()
                    return
                }

                XCTAssertEqual(firstLocal.id, 3335)
                XCTAssertEqual(firstLocal.name, "Wayne's Coffee Konserthuset")
                XCTAssertEqual(firstLocal.latitude, 59.335125)
                XCTAssertEqual(firstLocal.longitude, 18.063491)
                XCTAssertEqual(firstLocal.following, false)
                XCTAssertEqual(firstLocal.description, "Välkommen till Wayne's Coffee! Vi är Sveriges första KRAV-märkta kafékedja. I våra kaféer erbjuds kaffe av eget märke, bakverk från eget bageri och mat med naturliga råvaror av hög kvalitet.")
                XCTAssertEqual(firstLocal.phone, "08 - 442 2440")
                XCTAssertEqual(firstLocal.website, "http://www.waynescoffee.se")

                //Computed properties
                XCTAssertEqual(firstLocal.location.coordinate.latitude, 59.335125)
                XCTAssertEqual(firstLocal.location.coordinate.longitude, 18.063491)
                XCTAssertEqual(firstLocal.coordinate.latitude, 59.335125)
                XCTAssertEqual(firstLocal.coordinate.longitude, 18.063491)
            }
        }
    }

    func testGetLocals_WithInvalidResponseData_ReturnInvalidJsonError() {
        let string = """
                        [
                        {""}
                        ]
                    """
        guard let data = string.data(using: .utf8) else {
            XCTFail()
            return
        }

        mockNetworkManager.customData = data
        mockNetworkManager.customError = nil
        mockNetworkManager.customResponse = nil

        localManager.getLocals { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidJson)
            case .success:
                XCTFail()
            }
        }
    }

    func testGetLocals_WithErrorResponse_ReturnResponseError() {
        mockNetworkManager.customData = nil
        mockNetworkManager.customError = LocalManagerError.responseError    //We can use any kind of error here
        mockNetworkManager.customResponse = nil

        localManager.getLocals { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .responseError)
            case .success:
                XCTFail()
            }
        }
    }

    func testGetLocals_WithNoResponseData_ReturnResponseError() {
        mockNetworkManager.customData = nil
        mockNetworkManager.customError = nil
        mockNetworkManager.customResponse = nil

        localManager.getLocals { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .noResponseData)
            case .success:
                XCTFail()
            }
        }
    }
}
