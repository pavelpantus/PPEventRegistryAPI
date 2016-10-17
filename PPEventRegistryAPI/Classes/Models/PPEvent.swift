//
//  PPEvent.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 7/10/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

/// An event is a collection of one or more stories that all report about the same world event.
public struct PPEvent {
    let title: String
    let summary: String
    let eventDate: String
    let location: String
    let image: URL?
    let concepts: [PPConcept]
}
