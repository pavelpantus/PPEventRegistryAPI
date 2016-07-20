//
//  PPGetEventOperation+Fixture.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import OHHTTPStubs
@testable import PPEventRegistryAPI

extension PPGetEventOperation {

    class func stubSuccess() {
        stub({ (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: AnyObject] = [
                "4480701" : [
                    "info" : [
                        "summary" : [
                            "eng" : "All Exxon Mobil Corp. had to do is run its Los Angeles-area refinery for 15 days before handing the keys to new owner PBF Energy.\n\nThat's turning into a struggle. More than a month after Exxon Mobil restarted a key gasoline-making unit that was damaged in a blast last year, PBF still hasn't taken control of the Torrance plant. In the latest snag, a crane fell over Monday. While Exxon says it had no effect on production and the handover to PBF is still scheduled for mid year, the incident highligh"
                        ],
                        "location" : [
                            "type" : "place",
                            "label" : [
                            "eng" : "Torrance, California"
                            ],
                            "country" : [
                            "type" : "country",
                            "label" : [
                            "eng" : "United States"
                            ]
                            ]
                        ],
                        "images" : [
                            "https://assets.bwbx.io/business/public/images/social_fallbacks/bloomberg_default-a4f15fa7ee.jpg"
                        ],
                        "categories" : [
                            [
                                "id" : 1214,
                                "label" : "Recreation/Outdoors/Wildlife",
                                "wgt" : 43,
                                "uri" : "dmoz/Recreation/Outdoors/Wildlife"
                            ]
                        ],
                        "totalArticleCount" : 7,
                        "title" : [
                            "eng" : "Exxon Mobil struggles to run California plant long enough to dump it"
                        ],
                        "eventDate" : "2016-06-20",
                        "articleCounts" : [
                            "eng" : 7
                        ],
                        "uri" : "4480701",
                        "concepts" : [
                            [
                                "id" : "174535",
                                "score" : 9,
                                "label" : [
                                    "eng" : "Maxine Waters"
                                ],
                                "type" : "person",
                                "uri" : "http://en.wikipedia.org/wiki/Maxine_Waters"
                            ]
                        ]
                    ]
                ]
            ]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Get Event Operation Stub: Success"
    }

    class func stubEventNotFound() {
        stub({ (request) -> Bool in
            true
        }) { (response) -> OHHTTPStubsResponse in
            let responseData : [String: AnyObject] = [
                "44808387" : [
                    "error" : "Provided event uri (44808387) is not a valid event uri"
                ]
            ]
            return OHHTTPStubsResponse(jsonObject: responseData, statusCode: 200, headers: nil)
            }.name = "Get Event Operation Stub: Event was not found"
    }


}
