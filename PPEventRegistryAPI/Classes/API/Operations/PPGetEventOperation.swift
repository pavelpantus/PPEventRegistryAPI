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
    init(identifier: NSNumber, completionHandler: ((error: NSError?) -> Void)?) {
        let parameters = ["action": "getEvent",
                          "eventUri": identifier,
                          "infoConceptLang": "eng",
                          "infoEventImageCount": 1,
                          "resultType": "info"]
        let completion: (JSON?, NSError?) -> Void = { (data, error) -> Void in
            print("PPGetEventOperation \(error) items: \(data)")
            completionHandler?(error: error)
        }

        super.init(controller: "event", httpMethod: "GET", parameters: parameters)
        self.completionHandler = completion
    }
}
