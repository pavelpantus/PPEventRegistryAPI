//
//  PPConceptSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 10/9/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPConceptSpec: QuickSpec {
    override func spec() {
        describe("Initialization") {

            it("Concept is initialized with provided values") {
                let concept = PPConcept(identifier: "123", description: "description", uri: URL(string: "http://en.wikipedia.org/wiki/United_States"), image: URL(string: "http://upload.wikimedia.org/wikipedia/commons/thumb/0/03/USA-satellite.jpg/1280px-USA-satellite.jpg"), score: 100)
                expect(concept.uri).to(equal(URL(string: "http://en.wikipedia.org/wiki/United_States")!))
                expect(concept.identifier).to(equal("123"))
                expect(concept.image).to(equal(URL(string: "http://upload.wikimedia.org/wikipedia/commons/thumb/0/03/USA-satellite.jpg/1280px-USA-satellite.jpg")!))
                expect(concept.description).to(equal("description"))
                expect(concept.score).to(equal(100))
            }

            it("can be initialized with an empty uri and image") {
                let concept = PPConcept(identifier: "123", description: "description", uri: nil, image: nil, score: 5)
                expect(concept.uri).to(beNil())
                expect(concept.identifier).to(equal("123"))
                expect(concept.image).to(beNil())
                expect(concept.description).to(equal("description"))
                expect(concept.score).to(equal(5))
            }
        }
    }
}
