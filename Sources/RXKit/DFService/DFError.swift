//
//  RXError.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/12.
//

import Foundation

public enum DFError: Error {
    case unimplemented
    case notFound
    case msg(String)
}

extension DFError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unimplemented:
            return "unimplemented error"
        case .notFound:
            return "not found"
        case .msg(let msg):
            return msg
        }
    }
}
