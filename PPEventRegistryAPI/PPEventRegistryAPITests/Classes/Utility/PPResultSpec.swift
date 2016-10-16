//
//  PPResultSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 10/16/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPResultSpec: QuickSpec {
    override func spec() {

        describe("Initialization") {

            it("init with value creates success") {
                let result = PPResult<String, PPError>(value: "a")
                expect(result.debugDescription).to(equal("Success: a"))
            }

            it("init with error creates failure") {
                let result = PPResult<Int, PPError>(error: .OperationCancelled)
                expect(result.debugDescription).to(equal("Failure: OperationCancelled"))
            }

        }

        describe("Accessors") {

            describe("value") {

                it("value is returned in case of success") {
                    let result = PPResult<[String], PPError>.Success(["a", "b", "c"])
                    expect(result.value!).to(equal(["a", "b", "c"]))
                }
                
                it("nil is returned in case of failure") {
                    let result = PPResult<[String], PPError>.Failure(.Error("no cheese"))
                    expect(result.value).to(beNil())
                }

            }

            describe("error") {

                it("error is returned in case of failure") {
                    let result = PPResult<[String], PPError>.Failure(.Error("no cheese"))
                    expect(result.error!).to(equal(PPError.Error("no cheese")))
                }

                it("nil is returned in case of success") {
                    let result = PPResult<[String], PPError>.Success(["a", "b", "c"])
                    expect(result.error).to(beNil())
                }

            }

        }

        describe("debugDescription") {

            it("correctly prints success") {
                let result = PPResult<String, PPError>.Success("b")
                expect(result.debugDescription).to(equal("Success: b"))
            }

            it("correctly prints failures without associated value") {
                let result = PPResult<String, PPError>.Failure(.UnknownUser)
                expect(result.debugDescription).to(equal("Failure: UnknownUser"))
            }

            it("correctly prints failures with associated values") {
                let result = PPResult<String, PPError>.Failure(.NetworkError("no cheese"))
                expect(result.debugDescription).to(equal("Failure: NetworkError: no cheese"))
            }

        }

        describe("Equasion") {

            it("success is not equal to error") {
                let result1 = PPResult<String, PPError>.Failure(.Error("no cheese"))
                let result2 = PPResult<String, PPError>.Success("b")
                expect(result1 == result2).to(beFalsy())
            }

            it("successes with equal associated types are equal") {
                let result1 = PPResult<String, PPError>(value: "a")
                let result2 = PPResult<String, PPError>.Success("a")
                expect(result1 == result2).to(beTruthy())
            }

            it("successes with not equal associated types are not equal") {
                let result1 = PPResult<String, PPError>(value: "a")
                let result2 = PPResult<String, PPError>.Success("b")
                expect(result1 == result2).to(beFalsy())
            }

            it("failures with the same errors are equal") {
                let result1 = PPResult<String, PPError>(error: .Error("no cheese"))
                let result2 = PPResult<String, PPError>.Failure(.Error("no cheese"))
                expect(result1 == result2).to(beTruthy())
            }

            it("failures with not same errors are not equal") {
                let result1 = PPResult<String, PPError>(error: .Error("no cheese"))
                let result2 = PPResult<String, PPError>.Failure(.OperationCancelled)
                expect(result1 == result2).to(beFalsy())
            }

        }
    }
}
