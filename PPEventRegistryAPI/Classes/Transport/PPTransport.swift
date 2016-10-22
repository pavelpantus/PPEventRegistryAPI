//
//  Transport.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

/// Protocol that real transport and mock conform to.
protocol PPTransportProtocol {
    func postRequest(controller: PPController, method: PPHttpMethod, parameters: [String: Any], completionHandler: @escaping (_ result: PPResult<[String: Any], PPError>) -> ())
}

/// Supported http methods.
enum PPHttpMethod: String {
    case Get
    case Post
}

/// Supported operation controllers.
enum PPController: String {
    case Login
    case Event
    case Overview
}

/// Transfer protocols that API object can use.
public enum PPTransferProtocol: String {
    case http
    case https
}

/// struct that represents transport of API object.
struct PPTransport {
    internal let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    internal var transferProtocol: PPTransferProtocol = .http
    internal var baseURI: String {
        return transferProtocol.rawValue + "://eventregistry.org"
    }
}

// MARK: PPTransportProtocol

extension PPTransport: PPTransportProtocol {
    
    /**
     Posts request to the network.
     - Parameters:
        - controller: Controller the request should be posted to.
        - method: Http method that should be used.
        - parameters: Request parameters.
        - completionHandler: Handler that is to be executed upon request completion.
        - result: Result of the request execution (see PPResult).
     */
    internal func postRequest(controller: PPController, method: PPHttpMethod, parameters: [String: Any], completionHandler: @escaping (_ result: PPResult<[String: Any], PPError>) -> ()) {

        let urlRequest = request(with: controller, method: method, parameters: parameters)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completionHandler(.Failure(.NetworkError(error?.localizedDescription ?? "")))
                return
            }

            guard let data = data,
                let resultObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                let response = resultObject as? [String: Any] else {
                    completionHandler(.Failure(.CorruptedResponse))
                    return
            }

            completionHandler(.Success(response))
        }
        task.resume()
    }

    /**
     Creates a request that will be posted to the network.
     - Parameters:
        - controller: Controller the request should be posted to.
        - method: Http method that should be used.
        - parameters: Request parameters.
     - Returns: Network request.
     */
    internal func request(with controller: PPController, method: PPHttpMethod, parameters: [String: Any]) -> URLRequest {
        var request: URLRequest

        if method == .Get {
            request = URLRequest(url: URL(string: baseURI + "/json/" + controller.rawValue.lowercased() + "?" + parameters.pp_join())!)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            request = URLRequest(url: URL(string: baseURI + "/" + controller.rawValue.lowercased())!)
            request.httpBody = parameters.pp_join().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)?.data(using: .utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }

        request.httpMethod = method.rawValue.uppercased()
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
}
