//
//  PPLoginOperation+Fixture.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/13/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import OHHTTPStubs
@testable import PPEventRegistryAPI

extension PPLoginOperation {

    class func stubSuccess() {
        stub(condition: { (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: Any] = ["action": "success",
                                                "desc": "Login successful"]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Login Operation Stub: Success"
    }

    class func stubUserNotFound() {
        stub(condition: { (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: Any] = ["action": "unknownUser",
                                                "desc": "User with specified email and password doesn't exist."]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Login Operation Stub: Unknown User"
    }

    class func stubUserMissingData() {
        stub(condition: { (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: Any] = ["action": "missingData",
                                                "desc": "Email or password was not specified."]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Login Operation Stub: Missing Data"
    }

}
