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

        var getEventOperation = PPGetEventOperation(identifier: 123, completionHandler: {_ in})

        beforeEach {
            getEventOperation = PPGetEventOperation(identifier: 123, completionHandler: {_ in})
        }

        it("subclass of PPAsyncOperation") {
            expect(getEventOperation).to(beAKindOf(PPAsyncOperation.self))
        }

        it("configured with correct httpMethod") {
            expect(getEventOperation.method).to(equal(PPHttpMethod.Get))
        }

        it("configured with correct controller") {
            expect(getEventOperation.controller).to(equal(PPController.Event))
        }

        it("configured with a completion") {
            expect(getEventOperation.completionHandler).notTo(beNil())
        }

        it("configured with correct parameters") {
            // TODO: reconsider once Quick supports dictionaries comparison
//            expect(getEventOperation.parameters).to(equal(["action": "getEvent",
//                                                           "eventUri": 123,
//                                                           "infoConceptLang": "eng",
//                                                           "infoEventImageCount": 1,
//                                                           "resultType": "info"]))
            let params = getEventOperation.parameters
            expect(params).to(haveCount(5))
            expect(params["action"] as? String).to(equal("getEvent"))
            expect(params["eventUri"] as? Int).to(equal(123))
            expect(params["infoConceptLang"] as? String).to(equal("eng"))
            expect(params["infoEventImageCount"] as? Int).to(equal(1))
            expect(params["resultType"] as? String).to(equal("info"))
        }

    }
}
