//
//  LocalTests.swift
//  TestKarmaTests
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import XCTest
@testable import TestKarma

class LocalTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateLocalEntity_ValidJson_Successfull() {
        let string = """
                        {
                            "id": 3335,
                            "name": "Wayne's Coffee Konserthuset",
                            "latitude": 59.335125,
                            "longitude": 18.063491,
                            "following": false,
                            "description": "Välkommen till Wayne's Coffee! Vi är Sveriges första KRAV-märkta kafékedja. I våra kaféer erbjuds kaffe av eget märke, bakverk från eget bageri och mat med naturliga råvaror av hög kvalitet.",
                            "phone": "08 - 442 2440",
                            "website": "http://www.waynescoffee.se"
                        }
                    """
        guard let data = string.data(using: .utf8) else {
            XCTFail()
            return
        }

        do {
            let local = try JSONDecoder().decode(Local.self, from: data)

            XCTAssertEqual(local.id, 3335)
            XCTAssertEqual(local.name, "Wayne's Coffee Konserthuset")
            XCTAssertEqual(local.latitude, 59.335125)
            XCTAssertEqual(local.longitude, 18.063491)
            XCTAssertEqual(local.following, false)
            XCTAssertEqual(local.description, "Välkommen till Wayne's Coffee! Vi är Sveriges första KRAV-märkta kafékedja. I våra kaféer erbjuds kaffe av eget märke, bakverk från eget bageri och mat med naturliga råvaror av hög kvalitet.")
            XCTAssertEqual(local.phone, "08 - 442 2440")
            XCTAssertEqual(local.website, "http://www.waynescoffee.se")

            //Computed properties
            XCTAssertEqual(local.location.coordinate.latitude, 59.335125)
            XCTAssertEqual(local.location.coordinate.longitude, 18.063491)
            XCTAssertEqual(local.coordinate.latitude, 59.335125)
            XCTAssertEqual(local.coordinate.longitude, 18.063491)
        } catch {
            XCTFail()
        }
    }

    func testCreateLocalEntity_InvalidJson_Successfull_Fail() {
        let string = """
                        {
                            "id": 3335,
                            "name": "Wayne's Coffee Konserthuset",
                            "latitude": "59.335125",
                            "longitude": "18.063491",
                            "following": false,
                            "description": "Välkommen till Wayne's Coffee! Vi är Sveriges första KRAV-märkta kafékedja. I våra kaféer erbjuds kaffe av eget märke, bakverk från eget bageri och mat med naturliga råvaror av hög kvalitet.",
                            "phone": "08 - 442 2440",
                            "website": "http://www.waynescoffee.se"
                        }
                    """
        guard let data = string.data(using: .utf8) else {
            XCTFail()
            return
        }

        do {
            _ = try JSONDecoder().decode(Local.self, from: data)
            XCTFail()
        } catch {
            //Success here!
        }
    }

    func testCreateLocalsArray_ValidJSON_Successfull() {
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

            do {
                let localsArray = try JSONDecoder().decode([Local].self, from: data)

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
            } catch {
                XCTFail()
            }
        }

    func testCreateLocalsArray_InvalidJSON_Fail() {
        let string = """
                        [
                        {
                            "id": 3335,
                            "name": "Wayne's Coffee Konserthuset",
                            "latitude": "59.335125",
                            "longitude": "18.063491",
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
                            "following": 14,
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

        do {
            _ = try JSONDecoder().decode([Local].self, from: data)
            XCTFail()
        } catch {
            //Success here!
        }
    }
}
