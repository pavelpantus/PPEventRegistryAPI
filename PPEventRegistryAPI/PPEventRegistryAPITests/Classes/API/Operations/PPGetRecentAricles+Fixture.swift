//
//  PPGetRecentAricles+Fixture.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import OHHTTPStubs
@testable import PPEventRegistryAPI

extension PPGetRecentArticles {

    class func stubSuccess() {
        stub(condition: { (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(jsonObject: successResponseData(), statusCode: 200, headers: nil)
            }.name = "Get Recent Articles Operation Stub: Success"
    }

    class func stubNoArticlesFound() {
        stub(condition: { (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: Any] = [
                "recentActivity" : [
                    "articles" : [
                        "activity" : []
                    ]
                ]
            ]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Get Recent Articles Operation Stub: No new articles"
    }

    class func successResponseData() -> [String: Any] {
        return [
            "recentActivity" : [
                "articles" : [
                    "activity" : [
                        PPArticle.fixture1(),
                        PPArticle.fixture2(),
                        PPArticle.fixture3()
                    ],
                    "lastActivityId" : "97623711",
                    "oldActivityId" : "97623706",
                    "oldUpdate" : "2016-07-20 03:10:43.440",
                    "currTime" : "2016-07-20 03:11:16.531",
                    "lastUpdate" : "2016-07-20 03:10:43.575"
                ]
            ]
        ]
    }

    class func successDataNoLastActivity() -> [String: Any] {
        return [
            "recentActivity" : [
                "articles" : [
                    "activity" : [
                        PPArticle.fixture1(),
                    ],
                    "oldActivityId" : "97623706",
                    "oldUpdate" : "2016-07-20 03:10:43.440",
                    "currTime" : "2016-07-20 03:11:16.531",
                    "lastUpdate" : "2016-07-20 03:10:43.575"
                ]
            ]
        ]
    }

}
