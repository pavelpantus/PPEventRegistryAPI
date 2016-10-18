//
//  PPEventRegistryAPI.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation


/// Represents current state of API client.
enum AuthState {
    /// Client is not logged in.
    case loggedOut;
    /// Client is logged in.
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
    fileprivate var transport = PPTransport()
    private let modelMapper = PPModelMapper()
    internal var state = AuthState.loggedOut

    /**
     Public initializer.
     */
    public init() {}

    /**
     Routine that schedules execution of provided operation.
     - Parameter operation: Operation to be scheduled.
     - Precondition: API client has to be logged in.
     */
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

    /**
     Sets preferred transport protocol.
     - Parameter transferProtocol: protocol to be used.
     */
    public func setTransferProtocol(_ transferProtocol: PPTransferProtocol) {
        transport.transferProtocol = transferProtocol
    }

}

private typealias LoginAPI = PPEventRegistryAPI
extension LoginAPI {

    /**
     Logs in api client with provided credentials.
     - Parameters:
        - email: Email to be used in log in operation.
        - password: Password to be used in log in operation.
        - completionHandler: Handler to be called upon operation completion.
        - error: Error is returned in case of something went wrong (see PPError enum).
     */
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

    /**
     Gets event by identifier.
     - Parameters:
        - id: Event identifier.
        - completionHandler: Handler to be called upon operation completion.
        - result: A result of the operation (see PPResult for more details).
     */
    public func getEvent(withID id: NSNumber, completionHandler: @escaping (_ result: PPResult<PPEvent, PPError>) -> ()) {
        let getEvent = PPGetEventOperation(identifier: id, completionHandler: completionHandler)
        schedule(getEvent)
    }

}

private typealias ArticlesAPI = PPEventRegistryAPI
extension ArticlesAPI {

    /**
     Gets most recent articles.
     - Parameters:
        - count: Count of articles to be requested. 5 by default.
        - completionHandler: Handler to be called upon operation completion.
        - result: A result of the operation (see PPResult for more details).
     */
    public func getRecentArticles(count: Int = 5, _ completionHandler: @escaping (_ result: PPResult<[PPArticle], PPError>) -> ()) {
        let getRecentActivity = PPRecentArticlesOperation(count: count, completionHandler: completionHandler)
        schedule(getRecentActivity)
    }

}
