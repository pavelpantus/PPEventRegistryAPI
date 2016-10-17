//
//  PPGetEventOperation.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/21/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

/// Operation to request event by identifier.
final class PPGetEventOperation: PPAsyncOperation {
    
    /**
     Operation initializer.
     - Parameters:
        - identifier: Requested event identifier.
        - completionHandler: Completion handler that is executed upon operation completion.
        - result: Result of the operation (see PPResult).
     */
    init(identifier: NSNumber, completionHandler: @escaping (_ result: PPResult<PPEvent, PPError>) -> ()) {
        let parameters: [String : Any] = ["action": "getEvent",
                                          "eventUri": identifier,
                                          "infoConceptLang": "eng",
                                          "infoEventImageCount": 1,
                                          "resultType": "info"]
        super.init(controller: .Event, method: .Get, parameters: parameters)

        self.completionHandler = { result in
            switch result {
            case let .Success(response):
                let eventData = response[identifier.stringValue] as? [String: Any]

                if let errorDescription = eventData?["error"] as? String {
                    DispatchQueue.main.async {
                        completionHandler(.Failure(.Error(errorDescription)))
                    }
                } else {
                    let events: [PPEvent] = self.modelMapper.mapDataToModelObjects(response)
                    DispatchQueue.main.async {
                        if let event = events.first {
                            completionHandler(.Success(event))
                        } else {
                            completionHandler(.Failure(.Error("Event Not Found")))
                        }
                    }
                }
            case let .Failure(error):
                DispatchQueue.main.async {
                    completionHandler(.Failure(error))
                }
            }
        }
    }
}
