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

        var loginOperation = PPLoginOperation(email: "a@b.c",
                                              password: "q",
                                              completionHandler: {_ in})

        beforeEach {
            loginOperation = PPLoginOperation(email: "email@email.com",
                                              password: "qwerty",
                                              completionHandler: {_ in})
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
            // TODO: reconsider once Quick supports dictionaries comparison
//            expect(loginOperation.parameters).to(equal(["email": "email@email.com",
//                                                        "pass": "qwerty"]))
            let params = loginOperation.parameters as! [String: String]
            expect(params).to(haveCount(2))
            expect(params["email"]).to(equal("email@email.com"))
            expect(params["pass"]).to(equal("qwerty"))
        }

    }
}
