//
//  PPEventRegistryAPI.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

enum AuthState {
    case loggedOut;
    case loggedIn(email: String, password: String)
}

extension AuthState: Equatable {

    public static func ==(lhs: AuthState, rhs: AuthState) -> Bool {
        switch (lhs, rhs) {
        case ( .loggedOut, .loggedOut):
            return true
        case (let .loggedIn(email1, pwd1), let .loggedIn(email2, pwd2)):
            return email1 == email2 && pwd1 == pwd2
        default:
            return false
        }
    }

}

public final class PPEventRegistryAPI {
    private let queue = OperationQueue()
    private let transport = PPTransport()
    private let modelMapper = PPModelMapper()
    internal var state = AuthState.loggedOut

    public init() {}

    internal func schedule(_ operation: PPAsyncOperation) {
        guard self.state != .loggedOut
            || operation.isKind(of: PPLoginOperation.self) else {
            DispatchQueue.main.async {
                let error = NSError(domain: "Log In Needed", code: 100, userInfo: nil)
                operation.completionHandler(nil, error)
            }
            return
        }

        operation.transport = transport
        operation.modelMapper = modelMapper
        queue.addOperations([operation], waitUntilFinished: false)
    }
}

// MARK: Public API Methods

extension PPEventRegistryAPI {

    public func login(_ email: String, password: String, completionHandler: @escaping (_ error: NSError?) -> Void) {
        let login = PPLoginOperation(email: email, password: password) { error in
            self.state = error == nil ? .loggedIn(email: email, password: password) : .loggedOut
            completionHandler(error)
        }
        schedule(login)
    }

    public func getEvent(withID id: NSNumber, completionHandler: @escaping (_ event: PPEvent?, _ error: NSError?) -> Void) {
        let getEvent = PPGetEventOperation(identifier: id) { event, error in
            completionHandler(event, error)
        }
        schedule(getEvent)
    }

    public func getRecentArticles(marker: PPFetchMarker?, _ completionHandler: @escaping (_ marker: PPFetchMarker?, _ articles: [PPArticle], _ error: NSError?) -> Void) {
        let getRecentActivity = PPGetRecentArticles(marker: marker, completionHandler: completionHandler)
        schedule(getRecentActivity)
    }

}
