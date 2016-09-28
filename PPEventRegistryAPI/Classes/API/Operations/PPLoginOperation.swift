//
//  PPLoginOperation.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

final class PPLoginOperation: PPAsyncOperation {
    init(email: String, password: String, completionHandler: @escaping (_ error: NSError?) -> Void) {
        let parameters = ["email": email, "pass": password]
        super.init(controller: .Login, method: .Post, parameters: parameters)

        self.completionHandler = { response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(error)
                }
                return
            }

            var credsError: NSError?
            if let action = response?["action"] as? String,
                action == "unknownUser" || action == "missingData" {
                credsError = NSError(domain: action, code: 0, userInfo: nil)
            }

            DispatchQueue.main.async {
                completionHandler(credsError)
            }
        }
    }
}
