//
//  PPGetEventOperation.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/21/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import SwiftyJSON

final class PPGetEventOperation: PPAsyncOperation {
    init(identifier: NSNumber, completionHandler: ((event: PPEvent?, error: NSError?) -> Void)?) {
        let parameters = ["action": "getEvent",
                          "eventUri": identifier,
                          "infoConceptLang": "eng",
                          "infoEventImageCount": 1,
                          "resultType": "info"]
        super.init(controller: "event", httpMethod: "GET", parameters: parameters)

        let completion: (JSON?, NSError?) -> Void = { (json, error) -> Void in
            var events: [PPEvent] = []

            if let json = json {
                events = self.modelMapper.mapDataToModelObjects(json)
            }

            completionHandler?(event: events.first, error: error)
        }

        self.completionHandler = completion
    }
}
