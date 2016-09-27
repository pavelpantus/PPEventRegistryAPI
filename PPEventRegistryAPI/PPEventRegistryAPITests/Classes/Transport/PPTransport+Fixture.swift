//
//  PPTransport+Fixture.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 9/25/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import OHHTTPStubs
@testable import PPEventRegistryAPI

extension PPTransport {

    class func stubEmptyResponse() {
        stub(condition: { request -> Bool in
            true
        }) { response -> OHHTTPStubsResponse in
            let responseData : [String: Any] = [:]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "PPTransport Stub: Empty Response"
    }

    class func stubInvalidResponse() {
        stub(condition: { request -> Bool in
            true
        }) { response -> OHHTTPStubsResponse in
            let responseData: [Any] = []
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "PPTransport Stub: Invalid Response"
    }

}
