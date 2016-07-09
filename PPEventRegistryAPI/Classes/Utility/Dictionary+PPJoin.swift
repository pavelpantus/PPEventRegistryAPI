//
//  Dictionary+PPJoin.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/20/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

public extension Dictionary {

    func pp_join() -> String {
        let joinedString = self.reduce("") { "\($0)\($1.0)=\($1.1)&" }
        return String(joinedString.characters.dropLast())
    }

}
