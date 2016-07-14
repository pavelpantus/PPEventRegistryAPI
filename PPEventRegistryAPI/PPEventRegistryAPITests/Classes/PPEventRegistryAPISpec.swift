//
//  PPEventRegistryAPI.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/14/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
@testable import PPEventRegistryAPI

class PPEventRegistryAPISpec: QuickSpec {
    override func spec() {

        beforeEach {
            OHHTTPStubs.onStubActivation { request, stub, response in
                print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(stub.name)")
            }
        };

        afterEach {
            OHHTTPStubs.removeAllStubs()
        };

    }
}
