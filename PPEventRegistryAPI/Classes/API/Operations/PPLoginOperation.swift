//
//  PPLoginOperation.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

final class PPLoginOperation: PPAsyncOperation {
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
                var credsError: PPError?
                switch response["action"] as? String ?? "" {
                case "unknownUser":
                    credsError = .UnknownUser
                case "missingData":
                    credsError = .MissingData
                default:
                    credsError = nil
                }

                DispatchQueue.main.async {
                    completionHandler(credsError)
                }
            }
        }
    }
}
