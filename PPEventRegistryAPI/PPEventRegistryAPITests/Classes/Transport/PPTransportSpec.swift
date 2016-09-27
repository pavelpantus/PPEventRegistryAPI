//
//  PPTransportSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/16/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
@testable import PPEventRegistryAPI

class PPTransportSpec: QuickSpec {
    override func spec() {

        describe("HttpMethod") {

            it ("Get case is in place") {
                expect(HttpMethod(rawValue: "Get")).to(equal(HttpMethod.Get))
            }

            it ("Post case is in place") {
                expect(HttpMethod(rawValue: "Post")).to(equal(HttpMethod.Post))
            }

        }

        describe("Controller") {

            it("Login controller is in place") {
                expect(Controller(rawValue: "Login")).to(equal(Controller.Login))
            }

            it("Overview controller is in place") {
                expect(Controller(rawValue: "Overview")).to(equal(Controller.Overview))
            }

            it("Event controller is in place") {
                expect(Controller(rawValue: "Event")).to(equal(Controller.Event))
            }

        }

        describe("postRequest") {

            let transport = PPTransport()

            beforeEach() {
                PPTransport.stubEmptyResponse()
            }

            afterEach() {
                OHHTTPStubs.removeAllStubs()
            }

            it("is safe to use from multiple threads") {
                waitUntil(timeout: 5) { done in
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                        for _ in 1...100 {
                            transport.postRequest(controller: .Event, method: .Get, parameters: [:]) { _,_ in }
                        }
                    }
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                        for _ in 1...100 {
                            transport.postRequest(controller: .Overview, method: .Post, parameters: [:]) { _,_ in }
                        }
                    }
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                        for _ in 1...130 {
                            transport.postRequest(controller: .Overview, method: .Post, parameters: [:]) { _,_ in }
                        }
                        done()
                    }
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
                        for _ in 1...100 {
                            transport.postRequest(controller: .Overview, method: .Post, parameters: [:]) { _,_ in }
                        }
                    }
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
                        for _ in 1...100 {
                            transport.postRequest(controller: .Login, method: .Get, parameters: [:]) { _,_ in }
                        }
                    }
                }
            }

            it("calls back with 'Response Data is Corrupt' error in case of invalid network response") {
                PPTransport.stubInvalidResponse()
                waitUntil { done in
                    transport.postRequest(controller: .Login, method: .Post, parameters: [:], completionHandler: { response, error in
                        expect(error?.domain).to(equal("Response Data is Corrupted"))
                        expect(error?.code).to(equal(0))
                        expect(response).to(beNil())
                        done()
                    })
                }
            }

        }

        describe("request(with: method: parameters:)") {

            let transport = PPTransport()

            it("returns correct request for .Overview and .Get") {
                let urlRequest = transport.request(with: .Overview, method: .Get, parameters: ["key1":"value1"])
                expect(urlRequest.url).to(equal(URL(string: "http://eventregistry.org/json/overview?key1=value1")!))
                expect(urlRequest.httpMethod).to(equal("GET"))
            }

            it("returns correct request for .Login and .Post") {
                let urlRequest = transport.request(with: .Login, method: .Post, parameters: ["key1":"value1"])
                expect(urlRequest.url).to(equal(URL(string: "http://eventregistry.org/login")!))
                expect(urlRequest.httpBody).to(equal(["key1":"value1"].pp_join().data(using: .utf8)))
                expect(urlRequest.httpMethod).to(equal("POST"))
            }

        }

    }
}
