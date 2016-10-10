//
//  PPArticleSpec.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/10/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Quick
import Nimble
@testable import PPEventRegistryAPI

class PPArticleSpec: QuickSpec {
    override func spec() {
        describe("Initialization") {

            it("contains correct data after initialization without url and image"){
                let article = PPArticle(title: "title", body: "body", date: "date", time: "time", uri: "123", url: nil, image: nil, concepts: [])

                expect(article.title).to(equal("title"))
                expect(article.body).to(equal("body"))
                expect(article.date).to(equal("date"))
                expect(article.time).to(equal("time"))
                expect(article.url).to(beNil())
                expect(article.image).to(beNil())
            }

            it("contains correct data after initialization with url and image"){
                let article = PPArticle(title: "title", body: "body", date: "date", time: "time", uri: "123", url: URL(string: "https://www.google.com"), image: URL(string: "https://www.yahoo.com"), concepts: [])

                expect(article.title).to(equal("title"))
                expect(article.body).to(equal("body"))
                expect(article.date).to(equal("date"))
                expect(article.time).to(equal("time"))
                expect(article.url).to(equal(URL(string: "https://www.google.com")))
                expect(article.image).to(equal(URL(string: "https://www.yahoo.com")))
            }

        }
    }
}
