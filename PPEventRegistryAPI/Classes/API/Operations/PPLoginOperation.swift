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
        let completion: ([String: Any]?, NSError?) -> Void = { response, error in
            if let action = response?["action"] as? String, action == "unknownUser" {
                DispatchQueue.main.async {
                    let error = NSError(domain: "Unknown User", code: 0, userInfo: nil)
                    completionHandler(error)
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(error)
                }
            }
        }

        super.init(controller: "login", httpMethod: "POST", parameters: parameters)
        self.completionHandler = completion
    }
}
