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
    internal func postRequest(controller: Controller, method: HttpMethod, parameters: [String: Any], completionHandler: @escaping (_ result: PPResult<[String: Any], PPError>) -> ()) {
        if (rejectInvocation) {
            fatalError("Unexpected method was invoked")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.mockSuccess {
                completionHandler(.Success(["Result": "Success"]))
            } else {
                completionHandler(.Failure(.Error("Mocked Transport Failure")))
            }
        }
    }
}
