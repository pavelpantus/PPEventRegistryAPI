//
//  PPGetEventOperation+Fixture.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import OHHTTPStubs
@testable import PPEventRegistryAPI

extension PPGetEventOperation {

    class func stubSuccess() {
        stub(condition: { (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(jsonObject: successResponseData(), statusCode: 200, headers: nil)
            }.name = "Get Event Operation Stub: Success"
    }

    class func stubEventNotFound() {
        stub(condition: { (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: Any] = [
                "44808387" : [
                    "error" : "Provided event uri (44808387) is not a valid event uri"
                ]
            ]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Get Event Operation Stub: Event was not found"
    }

    class func stubEmptyResponse() {
        stub(condition: { (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: Any] = [:]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Get Event Operation Stub: Empty Response"
    }

    class func successResponseData() -> [String: Any] {
        return [ "4480701" : PPEvent.fixture1() ]
    }

}
