//
//  PPErrorSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 10/16/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPErrorSpec: QuickSpec {
    override func spec() {

        describe("Equatable") {

            it("errors of the same type are equal") {
                expect(PPError.OperationCancelled).to(equal(PPError.OperationCancelled))
                expect(PPError.LogInNeeded).to(equal(PPError.LogInNeeded))
                expect(PPError.UnknownUser).to(equal(PPError.UnknownUser))
                expect(PPError.MissingData).to(equal(PPError.MissingData))
                expect(PPError.CorruptedResponse).to(equal(PPError.CorruptedResponse))
                expect(PPError.NetworkError("a")).to(equal(PPError.NetworkError("a")))
                expect(PPError.Error("b")).to(equal(PPError.Error("b")))
            }

            it("errors with the same type but different accociated values are not equal") {
                expect(PPError.NetworkError("a")).notTo(equal(PPError.NetworkError("b")))
                expect(PPError.Error("b")).notTo(equal(PPError.Error("c")))
            }

            it("errors of different types are not equal") {
                expect(PPError.Error("b")).notTo(equal(PPError.UnknownUser))
                expect(PPError.OperationCancelled).notTo(equal(PPError.NetworkError("a")))
            }

        }

        describe("debugDescription") {

            it("is correct for every error type") {
                expect(PPError.OperationCancelled.debugDescription).to(equal("OperationCancelled"))
                expect(PPError.LogInNeeded.debugDescription).to(equal("LogInNeeded"))
                expect(PPError.UnknownUser.debugDescription).to(equal("UnknownUser"))
                expect(PPError.MissingData.debugDescription).to(equal("MissingData"))
                expect(PPError.CorruptedResponse.debugDescription).to(equal("CorruptedResponse"))
                expect(PPError.NetworkError("abc").debugDescription).to(equal("NetworkError: abc"))
                expect(PPError.Error("def").debugDescription).to(equal("Error: def"))
            }

        }

    }
}
