//
//  PPFetchMarker.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 9/22/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

public struct PPFetchMarker {
    internal let id: String
    
    init?(id: String) {
        guard id.characters.count > 0 else { return nil }
        self.id = id
    }
}
