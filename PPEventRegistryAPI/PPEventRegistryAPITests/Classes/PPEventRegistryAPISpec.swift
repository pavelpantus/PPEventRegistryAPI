//
//  PPEventRegistryAPI.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/14/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
@testable import PPEventRegistryAPI

class PPEventRegistryAPISpec: QuickSpec {
    override func spec() {

        var api = PPEventRegistryAPI()

        beforeEach {
            api = PPEventRegistryAPI()
            api.state = .loggedIn(email: "a@b.com", password: "pwd")
            OHHTTPStubs.onStubActivation { request, stub, response in
                print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(stub.name)")
            }
        };

        afterEach {
            OHHTTPStubs.removeAllStubs()
        };

        it("Login returns nil error in case of success") {
            PPLoginOperation.stubSuccess()

            waitUntil { done in
                api.login("email@email.com", password: "password") { error in
                    expect(Thread.current).to(equal(Thread.main))
                    expect(error).to(beNil())
                    done()
                }
            }
        }

        it("Login returns an unknown user error in case of failure") {
            PPLoginOperation.stubUserNotFound()

            waitUntil { done in
                api.login("email@email.com", password: "password") { error in
                    expect(Thread.current).to(equal(Thread.main))
                    expect(error).to(equal(PPError.UnknownUser))
                    done()
                }
            }
        }

        it("Login returns a missing data error in case of an empty input") {
            PPLoginOperation.stubUserMissingData()

            waitUntil { done in
                api.login("", password: "") { error in
                    expect(Thread.current).to(equal(Thread.main))
                    expect(error).to(equal(PPError.MissingData))
                    done()
                }
            }
        }

        it("Login returns an appropriate error in case of transport error") {
            PPTransport.stubErrorResponse()

            waitUntil { done in
                api.login("", password: "") { error in
                    expect(error!).to(equal(PPError.NetworkError("The operation couldn’t be completed. (NSURLErrorDomain error -1009.)")))
                    done()
                }
            }
        }

        it("Get Event returns an event object in case of success") {
            PPGetEventOperation.stubSuccess()

            waitUntil { done in
                api.getEvent(withID: 123) { result in
                    expect(Thread.current).to(equal(Thread.main))
                    expect(result.value).toNot(beNil())
                    done()
                }
            }
        }

        it("Get Event returns an error and no event object in case of event was not found") {
            PPGetEventOperation.stubEventNotFound()

            waitUntil { done in
                api.getEvent(withID: 44808387) { result in
                    expect(Thread.current).to(equal(Thread.main))
                    expect(result.error!.debugDescription).to(equal("Error: Provided event uri (44808387) is not a valid event uri"))
                    done()
                }
            }
        }

        it("Get Event returns an appropriate error in case of transport error") {
            PPTransport.stubErrorResponse()
            
            waitUntil { done in
                api.getEvent(withID: 44808387) { result in
                    expect(result.error!).to(equal(PPError.NetworkError("The operation couldn’t be completed. (NSURLErrorDomain error -1009.)")))
                    done()
                }
            }
        }

        it("Get Event returns an appropriate error in case of an empty response") {
            PPGetEventOperation.stubEmptyResponse()
            
            waitUntil { done in
                api.getEvent(withID: 44808387) { result in
                    expect(result.error!).to(equal(PPError.Error("Event Not Found")))
                    done()
                }
            }
        }

        it("Recent Articles return new articles in case of available") {
            PPGetRecentArticles.stubSuccess()

            waitUntil { done in
                api.getRecentArticles(count: 3) { result in
                    expect(Thread.current).to(equal(Thread.main))
                    expect(result.value).to(haveCount(3))
                    done()
                }
            }
        }

        it("Recent Articles return empty array in case of no new articles") {
            PPGetRecentArticles.stubNoArticlesFound()

            waitUntil { done in
                api.getRecentArticles(count: 10) { result in
                    expect(Thread.current).to(equal(Thread.main))
                    expect(result.value).to(haveCount(0))
                    done()
                }
            }
        }

        it("Recent Articles return an appropriate error in case of transport error") {
            PPTransport.stubErrorResponse()
            
            waitUntil { done in
                api.getRecentArticles(count: 10) { result in
                    expect(result.error!).to(equal(PPError.NetworkError("The operation couldn’t be completed. (NSURLErrorDomain error -1009.)")))
                    done()
                }
            }
        }

        describe("schedule") {

            beforeEach {
                api.state = .loggedOut
            }

            it("returns Log In Needed error in logged out state") {
                waitUntil { done in
                    let operation = PPAsyncOperation(controller: .Event, method: .Post, parameters: [:])
                    operation.completionHandler = { result in
                        expect(Thread.current).to(equal(Thread.main))
                        expect(result.error!.debugDescription).to(equal("LogInNeeded"))
                        expect(operation.transport).to(beNil())
                        expect(operation.modelMapper).to(beNil())
                        done()
                    }
                    api.schedule(operation)
                }
            }

            it("adds login operation in logged out state") {
                PPLoginOperation.stubSuccess()

                waitUntil { done in
                    api.login("email@email.com", password: "password") { error in
                        expect(Thread.current).to(equal(Thread.main))
                        expect(error).to(beNil())
                        done()
                    }
                }
            }
        }
    }
}
