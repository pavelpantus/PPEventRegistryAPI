//
//  PPAsyncOperation.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

class PPAsyncOperation: Operation {
    private var _executing = false
    private var _finished = false
    internal let controller: String
    internal let parameters: [String: Any]
    internal let httpMethod: String
    internal var transport: PPTransportProtocol!
    internal var modelMapper: PPModelMapper!
    internal var completionHandler: ([String: Any]?, NSError?) -> Void = {_,_ in }

    init(controller: String, httpMethod: String, parameters: [String: Any]) {
        self.controller = controller
        self.httpMethod = httpMethod
        self.parameters = parameters

        super.init()
    }

    override var isExecuting: Bool {
        get { return _executing }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }

    override var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }

    override var isAsynchronous: Bool {
        get { return true }
    }

    override final func start() {
        if isCancelled {
            completionHandler(nil, NSError(domain: "Operation was cancelled", code: 0, userInfo: nil))
            isFinished = true
            return
        }

        isExecuting = true

        transport.postRequest(controller: controller, httpMethod: httpMethod, parameters: parameters) { response, error -> Void in
            if self.isCancelled {
                self.completionHandler(response, NSError(domain: "Operation was cancelled", code: 0, userInfo: nil))
            } else {
                self.completionHandler(response, error)
            }

            self.isExecuting = false
            self.isFinished = true
        }
    }
}
