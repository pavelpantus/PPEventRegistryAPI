//
//  PPFetchMarger.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 9/23/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPFetchMarkerSpec: QuickSpec {
    override func spec() {
        describe("Initialization") {

            it("is created with a valid id") {
                let marker = PPFetchMarker(id: "123")
                expect(marker?.id).to(equal("123"))
            }

            it("is NOT created if id is invalid") {
                let marker = PPFetchMarker(id: "")
                expect(marker).to(beNil())
            }

        }
    }
}
