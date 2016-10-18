//
//  PPAsyncOperation.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

/**
 Class representing a asynchronous network request.
 While async operation can be used as-is, it should be subclassed to represent a concrete network operation.
 Parameters and completion handler should be configured in a subclass' initializer.
 - Examples: PPLoginOperation, PPGetEventOperation, PPGetRecentArticles
 */
class PPAsyncOperation: Operation {
    private var _executing = false
    private var _finished = false
    internal let controller: PPController
    internal let parameters: [String: Any]
    internal let method: PPHttpMethod
    internal var transport: PPTransportProtocol!
    internal var modelMapper: PPModelMapper!
    internal var completionHandler: ((PPResult<[String: Any], PPError>) -> ())?

    /**
     Initializer that should be used by subclasses.
     - Parameters:
        - controller: Controller operation belongs to (See PPController).
        - method: HTTP method that operation should use (See PPHttpOperation).
        - parameters: Operation parameters that should be attached to the request.
     */
    init(controller: PPController, method: PPHttpMethod, parameters: [String: Any]) {
        self.controller = controller
        self.method = method
        self.parameters = parameters

        super.init()
    }

    /// Flag representing current execution state of the operation.
    override var isExecuting: Bool {
        get { return _executing }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }

    /// Flag representing current state of the operation.
    override var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }

    /// Flag representing that the operation is asynchronous.
    override var isAsynchronous: Bool {
        get { return true }
    }

    override final func start() {
        if isCancelled {
            completionHandler?(.Failure(.OperationCancelled))
            isFinished = true
            return
        }

        isExecuting = true

        transport.postRequest(controller: controller, method: method, parameters: parameters) { result in
            if self.isCancelled {
                self.completionHandler?(.Failure(.OperationCancelled))
            } else {
                self.completionHandler?(result)
            }

            self.isExecuting = false
            self.isFinished = true
        }
    }
}
