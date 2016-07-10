//
//  PPEventRegistryAPI.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

public final class PPEventRegistryServerAPI {
    private let queue = OperationQueue()
    private let transport = PPTransport()
    private let modelMapper = PPModelMapper()

    public init() {}

    private func schedule(_ operation: PPAsyncOperation) {
        queue.addOperations([operation], waitUntilFinished: false)
        operation.transport = transport
        operation.modelMapper = modelMapper
    }
}

// MARK: Public API Methods

extension PPEventRegistryServerAPI {

    public func login(_ email: String, password: String, completionHandler: ((error: NSError?) -> Void)?) {
        let login = PPLoginOperation(email: email, password: password) { error in
            completionHandler?(error: error)
        }
        schedule(login)
    }

    public func getEvent(withID id: NSNumber, completionHandler: ((event: PPEvent?, error: NSError?) -> Void)?) {
        let getEvent = PPGetEventOperation(identifier: id) { (event, error) in
            completionHandler?(event: event, error: error)
        }
        schedule(getEvent)
    }

    public func getRecentArticles(_ completionHandler: ((articles: [PPArticle], error: NSError?) -> Void)?) {
        let getRecentActivity = PPGetRecentArticles(completionHandler: completionHandler)
        schedule(getRecentActivity)
    }

}
