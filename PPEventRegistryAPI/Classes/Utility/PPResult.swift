//
//  PPResult.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 10/12/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

public enum PPResult<Value, Error: Swift.Error> {
    case Success(Value)
    case Failure(Error)
}

extension PPResult {
    init(value: Value) {
        self = .Success(value)
    }

    init(error: Error) {
        self = .Failure(error)
    }
}

extension PPResult {
    public var value: Value? {
        switch self {
        case .Success(let value):
            return value
        default:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case .Failure(let error):
            return error
        default:
            return nil
        }
    }
}

extension PPResult: CustomDebugStringConvertible {

    public var debugDescription: String {
        switch self {
        case .Success(let value):
            return "Success: \(value)"
        case .Failure(let error):
            return "Failure: \(error)"
        }
    }

}

public func ==<V: Equatable, E: Equatable>(lhs: PPResult<V, E>, rhs: PPResult<V, E>) -> Bool {
    switch (lhs, rhs) {
    case (let .Success(sl), let .Success(sr)):
        return sl == sr
    case (let .Failure(fl), let .Failure(fr)):
        return fl == fr
    default:
        return false
    }
}
