//
//  PPAsyncOperationSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/16/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPAsyncOperationSpec: QuickSpec {
    override func spec() {

        var asyncOperation: PPAsyncOperation!
        let transportMock = PPTransportMock()

        beforeEach {
            let params: [String: Any] = ["key1": "arg1", "key2": "arg2"]
            asyncOperation = PPAsyncOperation(controller: "controller",
                                              httpMethod: "httpMethod",
                                              parameters: params)
            asyncOperation.transport = transportMock
        }

        afterEach {
            transportMock.rejectInvocation = false
            asyncOperation = nil
        }

        it("is not executing right after creation") {
            expect(asyncOperation.isExecuting).to(beFalse())
        }

        it("is not finished right after creation") {
            expect(asyncOperation.isFinished).to(beFalse())
        }

        it("is async") {
            expect(asyncOperation.isAsynchronous).to(beTrue())
        }

        it("correct controller set") {
            expect(asyncOperation.controller).to(equal("controller"))
        }

        it("correct httpMethod set") {
            expect(asyncOperation.httpMethod).to(equal("httpMethod"))
        }

        it("correct parameters set") {
            // TODO: reconsider once Quick supports dictionaries comparison
//            expect(asyncOperation.parameters).to(equal(["key1": "arg1", "key2": "arg2"] as [String: Any]))
            let params = asyncOperation.parameters as! [String: String]
            expect(params).to(haveCount(2))
            expect(params["key1"]).to(equal("arg1"))
            expect(params["key2"]).to(equal("arg2"))
        }

        it("does not post request if cancelled") {
            transportMock.rejectInvocation = true
            asyncOperation.cancel()

            waitUntil { done in
                asyncOperation.completionHandler = { json, error in
                    expect(json).to(beNil())
                    expect(error!.domain).to(equal("Operation was cancelled"))
                    expect(error!.code).to(equal(0))
                    done()
                }
                asyncOperation.start()
            }
            expect(asyncOperation.isFinished).to(beTrue())
            expect(asyncOperation.isExecuting).to(beFalse())
        }

        it("executes completion handler") {
            waitUntil { done in
                asyncOperation.completionHandler = { json, error in
                    done()
                }
                asyncOperation.start()
            }
            expect(asyncOperation.isFinished).to(beTrue())
            expect(asyncOperation.isExecuting).to(beFalse())
        }

        it("returns appropriate error is cancelled after request was posted") {
            waitUntil { done in
                asyncOperation.completionHandler = { json, error in
                    expect(json).toNot(beNil())
                    expect(error!.domain).to(equal("Operation was cancelled"))
                    expect(error!.code).to(equal(0))
                    done()
                }
                asyncOperation.start()
                asyncOperation.cancel()
            }
            expect(asyncOperation.isFinished).to(beTrue())
            expect(asyncOperation.isExecuting).to(beFalse())
        }

    }
}
