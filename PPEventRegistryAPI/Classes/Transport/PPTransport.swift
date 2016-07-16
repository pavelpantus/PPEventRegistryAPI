//
//  Transport.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol PPTransportProtocol {
    func postRequest(to controller: String, httpMethod: String, parameters: [String: AnyObject], completionHandler: (json: JSON?, error: NSError?) -> Void)
}

final class PPTransport: NSObject {
    private var session: URLSession!
    private let baseURI = "http://eventregistry.org"

    internal override init() {
        super.init()
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }
}

// MARK: PPTransportProtocol

extension PPTransport: PPTransportProtocol {
    internal func postRequest(to controller: String, httpMethod: String, parameters: [String: AnyObject], completionHandler: (json: JSON?, error: NSError?) -> Void) {
        var request: URLRequest!
        if httpMethod == "GET" {
            request = URLRequest(url: URL(string: baseURI + "/json/" + controller + "?" + parameters.pp_join())!)
        } else {
            request = URLRequest(url: URL(string: baseURI + "/" + controller)!)
            request.httpBody = parameters.pp_join().data(using: .utf8)
        }

        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: NSError?) in
            guard error == nil else {
                completionHandler(json: nil, error: error)
                return
            }

            guard let data = data,
                let resultObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                    completionHandler(json: nil, error: NSError(domain: "Response Data is Corrupted", code: 0, userInfo: nil))
                    return
            }

            completionHandler(json: JSON(resultObject), error: nil)
        }
        task.resume()
    }
}

// MARK: URLSessionDelegate

extension PPTransport: URLSessionDelegate {
    internal func urlSession(_ session: URLSession, didBecomeInvalidWithError error: NSError?) {
        print("Session did become invalid with error: \(error)")
    }
}
