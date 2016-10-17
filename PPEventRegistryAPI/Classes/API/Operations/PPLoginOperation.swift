//
//  PPLoginOperation.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

/// Operation that logs in user.
final class PPLoginOperation: PPAsyncOperation {
    
    /**
     Operation initializer.
     - Parameters:
        - email: Email to log in user with.
        - password: Password to log in user with.
        - completionHandler: Completion handler that is executed upon operation completion.
        - error: Error in case something went wrong.
     */
    init(email: String, password: String, completionHandler: @escaping (_ error: PPError?) -> ()) {
        let parameters = ["email": email, "pass": password]
        super.init(controller: .Login, method: .Post, parameters: parameters)
        
        self.completionHandler = { result in
            switch result {
            case let .Failure(error):
                DispatchQueue.main.async {
                    completionHandler(error)
                }
            case let .Success(response):
                var error: PPError?
                switch response["action"] as? String ?? "" {
                case "unknownUser":
                    error = .UnknownUser
                case "missingData":
                    error = .MissingData
                default:
                    error = nil
                }

                DispatchQueue.main.async {
                    completionHandler(error)
                }
            }
        }
    }
}
