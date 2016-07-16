//
//  PPTransportMock.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/16/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import SwiftyJSON
@testable import PPEventRegistryAPI

class PPTransportMock {
    var mockSuccess = true
    var rejectInvocation = false
    var delay = 0.3
}

// MARK: PPTransportProtocol

extension PPTransportMock: PPTransportProtocol {
    internal func postRequest(to controller: String, httpMethod: String, parameters: [String: AnyObject], completionHandler: (json: JSON?, error: NSError?) -> Void) {
        if (rejectInvocation) {
            fatalError("Unexpected method was invoked")
        }

        DispatchQueue.main.after(when: .now() + delay) {
            if self.mockSuccess {
                completionHandler(json: JSON("Success"), error: nil)
            } else {
                completionHandler(json: JSON("Failure"), error: NSError(domain: "Mocked Transport Failure", code: 123, userInfo: nil))
            }
        }
    }
}
