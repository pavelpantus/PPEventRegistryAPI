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
    fileprivate let transport = PPTransport()
    private let modelMapper = PPModelMapper()
    internal var state = AuthState.loggedOut

    public init() {}

    internal func schedule(_ operation: PPAsyncOperation) {
        guard self.state != .loggedOut
            || operation.isKind(of: PPLoginOperation.self) else {
            DispatchQueue.main.async {
                operation.completionHandler?(.Failure(.LogInNeeded))
            }
            return
        }

        operation.transport = transport
        operation.modelMapper = modelMapper
        queue.addOperations([operation], waitUntilFinished: false)
    }
}

private typealias TransferProtocolAPI = PPEventRegistryAPI
extension TransferProtocolAPI {

    public func setTransferProtocol(_ transferProtocol: PPTransferProtocol) {
        transport.transferProtocol = transferProtocol
    }

}

private typealias LoginAPI = PPEventRegistryAPI
extension LoginAPI {

    public func login(_ email: String, password: String, completionHandler: @escaping (_ error: PPError?) -> ()) {
        let login = PPLoginOperation(email: email, password: password) { error in
            self.state = error == nil ? .loggedIn(email: email, password: password) : .loggedOut
            completionHandler(error)
        }
        schedule(login)
    }

}

private typealias EventsAPI = PPEventRegistryAPI
extension EventsAPI {

    public func getEvent(withID id: NSNumber, completionHandler: @escaping (_ result: PPResult<PPEvent, PPError>) -> ()) {
        let getEvent = PPGetEventOperation(identifier: id, completionHandler: completionHandler)
        schedule(getEvent)
    }

}

private typealias ArticlesAPI = PPEventRegistryAPI
extension ArticlesAPI {

    public func getRecentArticles(count: Int = 5, _ completionHandler: @escaping (_ result: PPResult<[PPArticle], PPError>) -> ()) {
        let getRecentActivity = PPGetRecentArticles(count: count, completionHandler: completionHandler)
        schedule(getRecentActivity)
    }

}
