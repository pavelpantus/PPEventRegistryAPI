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
        stub({ (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: AnyObject] = [
                "4480701" : PPEvent.fixture1()
            ]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Get Event Operation Stub: Success"
    }

    class func stubEventNotFound() {
        stub({ (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: AnyObject] = [
                "44808387" : [
                    "error" : "Provided event uri (44808387) is not a valid event uri"
                ]
            ]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Get Event Operation Stub: Event was not found"
    }


}
