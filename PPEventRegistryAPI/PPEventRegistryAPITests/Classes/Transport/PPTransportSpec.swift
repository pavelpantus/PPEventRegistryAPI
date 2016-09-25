//
//  PPTransportSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/16/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPTransportSpec: QuickSpec {
    override func spec() {

        describe("HttpMethod") {

            it ("Get case is in place") {
                expect(HttpMethod(rawValue: "Get")).to(equal(HttpMethod.Get))
            }

            it ("Post case is in place") {
                expect(HttpMethod(rawValue: "Post")).to(equal(HttpMethod.Post))
            }

        }

        describe("Controller") {

            it("Login controller is in place") {
                expect(Controller(rawValue: "Login")).to(equal(Controller.Login))
            }

            it("Overview controller is in place") {
                expect(Controller(rawValue: "Overview")).to(equal(Controller.Overview))
            }

            it("Event controller is in place") {
                expect(Controller(rawValue: "Event")).to(equal(Controller.Event))
            }

        }

    }
}
