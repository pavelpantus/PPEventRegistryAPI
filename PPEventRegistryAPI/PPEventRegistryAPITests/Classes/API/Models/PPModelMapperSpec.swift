//
//  PPModelMapperSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/21/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPModelMapperSpec: QuickSpec {
    override func spec() {
        describe("Initialization") {

            var modelMapper = PPModelMapper()

            beforeEach {
                modelMapper = PPModelMapper()
            }

            it("Maps article correctly") {
                let article: PPArticle = modelMapper.mapDataToModelObject(PPArticle.fixture1())
                expect(article.title).to(equal("Astrazeneca PLC (AZN) Sees Strong Trading Volume"))
                expect(article.body).to(equal("Tweet\n\nAstrazeneca PLC (NYSE:AZN) shares saw unusually-high trading volume on Tuesday . Approximately 5,276,985 shares were traded during trading, a decline of 23% from the previous session's volume of 6,868,391 shares.The stock last traded at $30.22 and had previously closed at $30.55.\n\nAZN has ..."))
                expect(article.date).to(equal("2016-07-20"))
                expect(article.time).to(equal("01:06:00"))
                expect(article.uri).to(equal("476179196"))
                expect(article.url).to(equal(URL(string: "http://www.dailypolitical.com/2016/07/19/astrazeneca-plc-azn-sees-strong-trading-volume-2/")))
                expect(article.image).to(equal(URL(string: "www.image.com/image")))
            }

            it("Maps articles correctly") {
                let articles: [PPArticle] = modelMapper.mapDataToModelObjects(PPGetRecentArticles.successResponseData())
                expect(articles).to(haveCount(3))
            }

            it("Creates an empty URL object in case of absence of the data") {
                let article: PPArticle = modelMapper.mapDataToModelObject(PPArticle.fixtureEmptyURLAndBrokenImage())
                expect(article.url).to(beNil())
            }

            it("Creates an empty image object in case of nil data") {
                let article: PPArticle = modelMapper.mapDataToModelObject(PPArticle.fixtureEmptyURLAndBrokenImage())
                expect(article.image).to(beNil())
            }

            it("Creates an empty article in case of an empty input") {
                let article: PPArticle = modelMapper.mapDataToModelObject([:])
                expect(article.title).to(equal(""))
                expect(article.body).to(equal(""))
                expect(article.date).to(equal(""))
                expect(article.time).to(equal(""))
                expect(article.uri).to(equal(""))
                expect(article.url).to(beNil())
                expect(article.image).to(beNil())
            }

            it("Maps event correctly") {
                let event: PPEvent = modelMapper.mapDataToModelObject(PPEvent.fixture1())
                expect(event.title).to(equal("Exxon Mobil struggles to run California plant long enough to dump it"))
                expect(event.summary).to(equal("All Exxon Mobil Corp. had to do is run its Los Angeles-area refinery for 15 days before handing the keys to new owner PBF Energy.\n\nThat's turning into a struggle. More than a month after Exxon Mobil restarted a key gasoline-making unit that was damaged in a blast last year, PBF still hasn't taken control of the Torrance plant. In the latest snag, a crane fell over Monday. While Exxon says it had no effect on production and the handover to PBF is still scheduled for mid year, the incident highligh"))
                expect(event.eventDate).to(equal("2016-06-20"))
                expect(event.location).to(equal("Torrance, California"))
                expect(event.image).to(equal(URL(string: "https://assets.bwbx.io/business/public/images/social_fallbacks/bloomberg_default-a4f15fa7ee.jpg")))
            }

            it("Maps events correctly") {
                let events: [PPEvent] = modelMapper.mapDataToModelObjects(PPGetEventOperation.successResponseData())
                expect(events).to(haveCount(1))
            }

            it("Creates an empty event in case of an empty input") {
                let event: PPEvent = modelMapper.mapDataToModelObject([:])
                expect(event.title).to(equal(""))
                expect(event.summary).to(equal(""))
                expect(event.eventDate).to(equal(""))
                expect(event.location).to(equal(""))
                expect(event.image).to(beNil())
            }
        }
    }
}
