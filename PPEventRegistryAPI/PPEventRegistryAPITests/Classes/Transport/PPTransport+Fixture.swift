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

    static func stubEmptyResponse() {
        stub(condition: { request -> Bool in
            true
        }) { response -> OHHTTPStubsResponse in
            let responseData : [String: Any] = [:]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "PPTransport Stub: Empty Response"
    }

    static func stubInvalidResponse() {
        stub(condition: { request -> Bool in
            true
        }) { response -> OHHTTPStubsResponse in
            let responseData: [Any] = []
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "PPTransport Stub: Invalid Response"
    }

    static func stubErrorResponse() {
        stub(condition: { request -> Bool in
            true
        }) { response -> OHHTTPStubsResponse in
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
            return OHHTTPStubsResponse(error: error)
        }.name = "PPTransport Stub: Error Response"
    }
}
