//
//  Transport.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

protocol PPTransportProtocol {
    func postRequest(controller: Controller, method: HttpMethod, parameters: [String: Any], completionHandler: @escaping (_ result: PPResult<[String: Any], PPError>) -> ())
}

enum HttpMethod: String {
    case Get
    case Post
}

enum Controller: String {
    case Login
    case Event
    case Overview
}

public enum PPTransferProtocol: String {
    case http
    case https
}

final class PPTransport: NSObject {
    internal var session: URLSession!
    internal var transferProtocol: PPTransferProtocol = .http
    internal var baseURI: String {
        return transferProtocol.rawValue + "://eventregistry.org"
    }

    internal override init() {
        super.init()
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }
}

// MARK: PPTransportProtocol

extension PPTransport: PPTransportProtocol {
    internal func postRequest(controller: Controller, method: HttpMethod, parameters: [String: Any], completionHandler: @escaping (_ result: PPResult<[String: Any], PPError>) -> ()) {

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

    internal func request(with controller: Controller, method: HttpMethod, parameters: [String: Any]) -> URLRequest {
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

// MARK: URLSessionDelegate

extension PPTransport: URLSessionDelegate {
    internal func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print("Session did become invalid with error: \(error)")
    }
}
