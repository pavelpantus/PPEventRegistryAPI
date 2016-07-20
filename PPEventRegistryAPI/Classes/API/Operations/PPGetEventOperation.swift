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
            var error: NSError?

            if let json = json {
                if let errorDescription = json[identifier.stringValue]["error"].string {
                    error = NSError(domain: errorDescription, code: 0, userInfo: nil)
                } else {
                    events = self.modelMapper.mapDataToModelObjects(json)
                }
            } else {
                error = NSError(domain: "Corrupted json", code: 0, userInfo: nil)
            }

            DispatchQueue.main.async {
                completionHandler?(event: events.first, error: error)
            }
        }

        self.completionHandler = completion
    }
}
