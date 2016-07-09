//
//  Dictionary+PPJoin.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/20/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import XCTest

class Dictionary_PPJoin: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEmptyDictionaryReturnsEmptyString() {
        let emptyDictionary: [String: AnyObject] = [:]
        XCTAssertEqual(emptyDictionary.pp_join(), "")
    }

    func testDictionaryWithOneElementReturnsCorrectString() {
        XCTAssertEqual(["key1": "val1"].pp_join(), "key1=val1")
    }

    func testDictionaryWithTwoElementsReturnsCorrectString() {
        let joinedParams = ["key1": "val1", "key2": "val2"].pp_join()
        XCTAssertTrue(joinedParams.contains("key2=val2"))
        XCTAssertTrue(joinedParams.contains("key1=val1"))
        XCTAssertTrue(joinedParams.contains("&"))
    }

}
