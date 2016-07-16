//
//  PPLoginOperationSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/13/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPLoginOperationSpec: QuickSpec {
    override func spec() {

        var loginOperation: PPLoginOperation!

        beforeEach {
            loginOperation = PPLoginOperation(email: "email@email.com", password: "qwerty", completionHandler: nil)
        }

        afterEach {
            loginOperation = nil
        }

        it("subclass of PPAsyncOperation") {
            expect(loginOperation).to(beAKindOf(PPAsyncOperation.self))
        }

        it("configured with correct httpMethod") {
            expect(loginOperation.httpMethod).to(equal("POST"))
        }

        it("configured with correct controller") {
            expect(loginOperation.controller).to(equal("login"))
        }

        it("configured with a completion") {
            expect(loginOperation.completionHandler).notTo(beNil())
        }

        it("configured with correct parameters") {
            expect(loginOperation.parameters).to(equal(["email": "email@email.com",
                                                        "pass": "qwerty"] as NSDictionary))
        }

    }
}
