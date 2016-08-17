//
//  PPGetEventOperation.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/21/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

final class PPGetEventOperation: PPAsyncOperation {
    init(identifier: NSNumber, completionHandler: ((_ event: PPEvent?, _ error: NSError?) -> Void)?) {
        let parameters = ["action": "getEvent",
                          "eventUri": identifier,
                          "infoConceptLang": "eng",
                          "infoEventImageCount": 1,
                          "resultType": "info"] as [String : Any]
        super.init(controller: "event", httpMethod: "GET", parameters: parameters as [String : AnyObject])

        let completion: ([String: AnyObject]?, NSError?) -> Void = { response, error in
            var events: [PPEvent] = []
            var error: NSError?

            let eventData = response?[identifier.stringValue] as? [String: AnyObject]

            if let errorDescription = eventData?["error"] as? String {
                error = NSError(domain: errorDescription, code: 0, userInfo: nil)
            } else if let responseData = response {
                events = self.modelMapper.mapDataToModelObjects(responseData)
            }

            DispatchQueue.main.async {
                completionHandler?(events.first, error)
            }
        }

        self.completionHandler = completion
    }
}
