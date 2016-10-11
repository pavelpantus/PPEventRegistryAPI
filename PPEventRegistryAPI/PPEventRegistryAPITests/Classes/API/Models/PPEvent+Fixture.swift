//
//  PPEvent+Fixture.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/21/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import PPEventRegistryAPI

extension PPEvent {
    
    static func fixture1() -> [String: Any] {
        return [
            "info" : [
                "summary" : [
                    "eng" : "All Exxon Mobil Corp. had to do is run its Los Angeles-area refinery for 15 days before handing the keys to new owner PBF Energy.\n\nThat's turning into a struggle. More than a month after Exxon Mobil restarted a key gasoline-making unit that was damaged in a blast last year, PBF still hasn't taken control of the Torrance plant. In the latest snag, a crane fell over Monday. While Exxon says it had no effect on production and the handover to PBF is still scheduled for mid year, the incident highligh"
                ],
                "concepts": [
                    PPConcept.fixture1(),
                    PPConcept.fixture2()
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
                "uri" : "4480701"
            ]
        ]
    }

}
