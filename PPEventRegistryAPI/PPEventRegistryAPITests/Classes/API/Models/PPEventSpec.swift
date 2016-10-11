//
//  PPEventSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/10/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPEventSpec: QuickSpec {
    override func spec() {
        describe("Initialization") {

            it("contains correct data after initialization without image"){
                let event = PPEvent(title: "title", summary: "summary", eventDate: "date", location: "NYC", image: nil, concepts: [])
                expect(event.title).to(equal("title"))
                expect(event.summary).to(equal("summary"))
                expect(event.eventDate).to(equal("date"))
                expect(event.location).to(equal("NYC"))
                expect(event.image).to(beNil())
                expect(event.concepts).to(haveCount(0))
            }

            it("contains correct data after initialization with image"){
                let event = PPEvent(title: "title", summary: "summary", eventDate: "date", location: "NYC", image: URL(string: "https://www.google.com"), concepts: [])
                expect(event.title).to(equal("title"))
                expect(event.summary).to(equal("summary"))
                expect(event.eventDate).to(equal("date"))
                expect(event.location).to(equal("NYC"))
                expect(event.image).to(equal(URL(string: "https://www.google.com")))
                expect(event.concepts).to(haveCount(0))
            }

        }
    }
}
