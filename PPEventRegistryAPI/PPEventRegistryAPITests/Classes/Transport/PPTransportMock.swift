//
//  PPTransportMock.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/16/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
@testable import PPEventRegistryAPI

class PPTransportMock {
    var mockSuccess = true
    var rejectInvocation = false
    var delay = 0.3
}

// MARK: PPTransportProtocol

extension PPTransportMock: PPTransportProtocol {
    internal func postRequest(controller: String, httpMethod: String, parameters: [String: Any], completionHandler: @escaping (_ response: [String: Any]?, _ error: NSError?) -> Void) {
        if (rejectInvocation) {
            fatalError("Unexpected method was invoked")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.mockSuccess {
                completionHandler(["Result": "Success"], nil)
            } else {
                completionHandler(["Result": "Failure"], NSError(domain: "Mocked Transport Failure", code: 123, userInfo: nil))
            }
        }
    }
}
