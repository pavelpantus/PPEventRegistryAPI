//
//  PPGetEventOperationSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/14/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPGetEventOperationSpec: QuickSpec {
    override func spec() {

        var getEventOperation: PPGetEventOperation!

        beforeEach {
            getEventOperation = PPGetEventOperation(identifier: 123, completionHandler: nil)
        }

        afterEach {
            getEventOperation = nil
        }

        it("subclass of PPAsyncOperation") {
            expect(getEventOperation).to(beAKindOf(PPAsyncOperation.self))
        }

        it("configured with correct httpMethod") {
            expect(getEventOperation.httpMethod).to(equal("GET"))
        }

        it("configured with correct controller") {
            expect(getEventOperation.controller).to(equal("event"))
        }

        it("configured with a completion") {
            expect(getEventOperation.completionHandler).notTo(beNil())
        }

        it("configured with correct parameters") {
            expect(getEventOperation.parameters).to(equal(["action": "getEvent",
                                                           "eventUri": 123,
                                                           "infoConceptLang": "eng",
                                                           "infoEventImageCount": 1,
                                                           "resultType": "info"] as NSDictionary))
        }

    }
}
