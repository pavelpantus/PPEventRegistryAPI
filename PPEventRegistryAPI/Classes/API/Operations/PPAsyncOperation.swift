//
//  PPAsyncOperation.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import SwiftyJSON

class PPAsyncOperation: Operation {
    private var _executing = false
    private var _finished = false
    private let controller: String
    private let parameters: [String: AnyObject]
    private let httpMethod: String
    internal var transport: PPTransport!
    internal var modelMapper: PPModelMapper!
    internal var completionHandler: ((JSON?, NSError?) -> Void)?

    init(controller: String, httpMethod: String, parameters: [String: AnyObject]) {
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
        super.start()

        if isCancelled {
            isFinished = true
            return
        }

        isExecuting = true

        transport.postRequest(to: controller, httpMethod: httpMethod, parameters: parameters) { (json, error) -> Void in
            if self.isCancelled {
                self.isExecuting = false
                self.isFinished = true
                return
            }

            self.completionHandler?(json, error)

            self.isExecuting = false
            self.isFinished = true
        }
    }
}
