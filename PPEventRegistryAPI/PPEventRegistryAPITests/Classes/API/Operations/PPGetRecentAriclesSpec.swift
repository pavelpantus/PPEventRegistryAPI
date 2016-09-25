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

        var getRecentArticles = PPGetRecentArticles(completionHandler: {_,_ in})

        beforeEach {
            getRecentArticles = PPGetRecentArticles(completionHandler: {_,_ in})
        }

        it("subclass of PPAsyncOperation") {
            expect(getRecentArticles).to(beAKindOf(PPAsyncOperation.self))
        }

        it("configured with correct httpMethod") {
            expect(getRecentArticles.method).to(equal(HttpMethod.Get))
        }

        it("configured with correct controller") {
            expect(getRecentArticles.controller).to(equal(Controller.Overview))
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
            expect(params).to(haveCount(8))
            expect(params["action"] as? String).to(equal("getRecentActivity"))
            expect(params["addEvents"] as? Bool).to(beFalsy())
            expect(params["addActivity"] as? Bool).to(beFalsy())
            expect(params["addArticles"] as? Bool).to(beTruthy())
            expect(params["recentActivityArticlesMaxArticleCount"] as? Int).to(equal(5))
            expect(params["recentActivityArticlesMaxMinsBack"] as? Int).to(equal(600))
            expect(params["recentActivityArticlesMandatorySourceLocation"]  as? Bool).to(beFalsy())
            expect(params["recentActivityArticlesLastActivityId"] as? Int).to(equal(0))
            
        }

    }
}
