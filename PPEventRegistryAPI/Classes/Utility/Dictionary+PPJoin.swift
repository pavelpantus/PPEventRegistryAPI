//
//  Dictionary+PPJoin.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/20/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

public extension Dictionary {

    /**
     Reduces dictionary to a string.
     # Example: #
     ````
     [ "k1":"v1", "k2":"v2" ] -> "k1=v1&k2=v2"
     ````
     - Returns: String representation of the dictionary.
     */
    func pp_join() -> String {
        let joinedString = self.reduce("") { "\($0)\($1.0)=\($1.1)&" }
        return String(joinedString.characters.dropLast())
    }

}
