//
//  PPEventRegistryAPI.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

public final class PPEventRegistryAPI {
    private let queue = OperationQueue()
    private let transport = PPTransport()
    private let modelMapper = PPModelMapper()

    public init() {}

    internal func schedule(_ operation: PPAsyncOperation) {
        queue.addOperations([operation], waitUntilFinished: false)
        operation.transport = transport
        operation.modelMapper = modelMapper
    }
}

// MARK: Public API Methods

extension PPEventRegistryAPI {

    public func login(_ email: String, password: String, completionHandler: ((_ error: NSError?) -> Void)?) {
        let login = PPLoginOperation(email: email, password: password) { error in
            completionHandler?(error)
        }
        schedule(login)
    }

    public func getEvent(withID id: NSNumber, completionHandler: ((_ event: PPEvent?, _ error: NSError?) -> Void)?) {
        let getEvent = PPGetEventOperation(identifier: id) { (event, error) in
            completionHandler?(event, error)
        }
        schedule(getEvent)
    }

    public func getRecentArticles(_ completionHandler: ((_ articles: [PPArticle], _ error: NSError?) -> Void)?) {
        let getRecentActivity = PPGetRecentArticles(completionHandler: completionHandler)
        schedule(getRecentActivity)
    }

}
