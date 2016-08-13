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
            let responseData : [String: AnyObject] = [
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
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Login Operation Stub: Success"
    }

    class func stubNoArticlesFound() {
        stub(condition: { (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: AnyObject] = [
                "recentActivity" : [
                    "articles" : [
                        "activity" : []
                    ]
                ]
            ]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Login Operation Stub: No new articles"
    }

}
