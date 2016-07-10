//
//  Dictionary_PPJoin.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/10/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble

class Dictionary_PPJoinSpec: QuickSpec {
    override func spec() {
        describe("pp_join") {
            it("returns an empty string in case of empty dictionary") {
                let emptyDictionary: [String: String] = [:]
                expect(emptyDictionary.pp_join()).to(equal(""))
            }

            it("returns a correct string in case of dictionary with 1 element") {
                expect(["key1": "val1"].pp_join()).to(equal("key1=val1"))
            }

            it("returns a correct string in case of dictionary with 2 elements") {
                let joinedParams = ["key1": "val1", "key2": "val2"].pp_join()
                expect(joinedParams).to(contain("key1=val1"))
                expect(joinedParams).to(contain("&"))
                expect(joinedParams).to(contain("key2=val2"))
            }
        }
    }
}
