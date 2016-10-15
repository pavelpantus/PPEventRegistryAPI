//
//  PPError.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 10/12/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

public enum PPError {
    case OperationCancelled
    case LogInNeeded
    case UnknownUser
    case MissingData
    case CorruptedResponse
    case NetworkError(String)
    case Error(String)
}

extension PPError: Error {}

extension PPError: Equatable {

    public static func ==(lhs: PPError, rhs: PPError) -> Bool {
        switch (lhs, rhs) {
        case (.OperationCancelled, .OperationCancelled):
            return true
        case (.LogInNeeded, .LogInNeeded):
            return true
        case (.UnknownUser, .UnknownUser):
            return true
        case (.MissingData, .MissingData):
            return true
        case (.CorruptedResponse, .CorruptedResponse):
            return true
        case (let .NetworkError(el), let .NetworkError(er)):
            return el == er
        case (let .Error(el), let .Error(er)):
            return el == er
        default:
            return false
        }
    }

}

extension PPError: CustomDebugStringConvertible {

    public var debugDescription: String {
        switch self {
        case .OperationCancelled:
            return "OperationCancelled"
        case .LogInNeeded:
            return "LogInNeeded"
        case .UnknownUser:
            return "UnknownUser"
        case .MissingData:
            return "MissingData"
        case .CorruptedResponse:
            return "CorruptedResponse"
        case let .NetworkError(e):
            return "NetworkError \(e)"
        case let .Error(e):
            return "Error \(e)"
        }
    }

}
