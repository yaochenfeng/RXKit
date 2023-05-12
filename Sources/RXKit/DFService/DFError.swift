//
//  RXError.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/12.
//

import Foundation

public enum DFError {
    case unknown
    case unimplemented
    case beanNotFound
    case msg(String)
}

extension DFError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown:
            return "unknown error"
        case .unimplemented:
            return "unimplemented error"
        case .beanNotFound:
            return "bean not found"
        case .msg(let msg):
            return msg
        }
    }
}
