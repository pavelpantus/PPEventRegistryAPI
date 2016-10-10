//
//  PPConcept+Fixture.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 10/9/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import PPEventRegistryAPI

extension PPConcept {

    static func fixture1() -> [String: Any] {
        return [ "uri": "http://en.wikipedia.org/wiki/United_States",
                 "id": "233",
                 "image": "http://upload.wikimedia.org/wikipedia/commons/thumb/0/03/USA-satellite.jpg/1280px-USA-satellite.jpg",
                 "description": "<p>The United States of America (USA), commonly referred to as the United States (U.S.), America, and sometimes the States, is a federal republic consisting of 50 states, 16 territories, and a federal district. The 48 contiguous states and Washington, D.C., are in central North America between Canada and Mexico. The state of Alaska is located in the northwestern part of North America and the state of Hawaii is an archipelago in the mid-Pacific.</p>"
                ]
    }

    static func fixture2() -> [String: Any] {
        return [
                "id": "25891",
                "uri": "http://en.wikipedia.org/wiki/Cleveland_Browns",
                "type": "org",
                "score": 100,
                "label": [ "eng": "Cleveland Browns" ]
                ]
    }

}
