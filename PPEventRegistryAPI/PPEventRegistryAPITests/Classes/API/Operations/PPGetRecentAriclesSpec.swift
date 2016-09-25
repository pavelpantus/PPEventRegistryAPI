//
//  PPGetRecentAriclesSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/15/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPGetRecentArticlesSpec: QuickSpec {
    override func spec() {

        var getRecentArticles = PPGetRecentArticles(marker: nil) {_,_,_ in}

        beforeEach {
            getRecentArticles = PPGetRecentArticles(marker: nil) {_,_,_ in}
        }

        it("subclass of PPAsyncOperation") {
            expect(getRecentArticles).to(beAKindOf(PPAsyncOperation.self))
        }

        it("configured with correct httpMethod") {
            expect(getRecentArticles.httpMethod).to(equal("GET"))
        }

        it("configured with correct controller") {
            expect(getRecentArticles.controller).to(equal("overview"))
        }

        it("configured with a completion") {
            expect(getRecentArticles.completionHandler).notTo(beNil())
        }

        it("configured with correct parameters") {
            // TODO: reconsider once Quick supports dictionaries comparison
//            expect(getRecentArticles!.parameters).to(equal(["action": "getRecentActivity",
//                                                            "addEvents": false,
//                                                            "addActivity": false,
//                                                            "addArticles": true,
//                                                            "recentActivityArticlesMaxArticleCount": 5,
//                                                            "recentActivityArticlesMaxMinsBack": 10 * 60,
//                                                            "recentActivityArticlesMandatorySourceLocation": false,
//                                                            "recentActivityArticlesLastActivityId": 0]))
            let params = getRecentArticles.parameters
            expect(params).to(haveCount(7))
            expect(params["action"] as? String).to(equal("getRecentActivity"))
            expect(params["addEvents"] as? Bool).to(beFalsy())
            expect(params["addActivity"] as? Bool).to(beFalsy())
            expect(params["addArticles"] as? Bool).to(beTruthy())
            expect(params["recentActivityArticlesMaxArticleCount"] as? Int).to(equal(5))
            expect(params["recentActivityArticlesMaxMinsBack"] as? Int).to(equal(7 * 24 * 60 * 60))
            expect(params["recentActivityArticlesMandatorySourceLocation"]  as? Bool).to(beFalsy())
            expect(params["recentActivityArticlesLastActivityId"] as? String).to(equal("0"))
            expect(params["recentActivityEventsLastActivityId"]).to(beNil())
        }

        it("adds a recent activity id if marker was provided") {
            let marker = PPFetchMarker(id: "123")
            getRecentArticles = PPGetRecentArticles(marker: marker) {_,_,_ in}
            let params = getRecentArticles.parameters
            expect(params["recentActivityArticlesLastActivityId"] as? String).to(equal("123"))
        }

    }
}
