//
//  PPEvent.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/26/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

/// An article is a piece of news that Event Registry collects.
public struct PPArticle {
    let title: String
    let body: String
    let date: String
    let time: String
    let uri: String
    let url: URL?
    let image: URL?
    let concepts: [PPConcept]
}
