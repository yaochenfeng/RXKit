//
//  Autowired.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/4.
//

import Foundation

@propertyWrapper
public struct Autowired<T>: Codable {
    var required: Bool = false
    weak var container: Container?
    public var wrappedValue: T? {
        return container?.optional()
    }
    public func encode(to encoder: Encoder) throws {
        
    }
    public init(required: Bool = false,
                _ container: Container = RXContainer.shared) {
        self.required = required
        self.container = container
    }
    public init(from decoder: Decoder) throws {
        
    }
}

extension KeyedDecodingContainer {
    /// decode
    public func decode<T>(_ type: Autowired<T>.Type, forKey key: Key) throws -> Autowired<T> {
        return Autowired<T>()
    }
}
extension KeyedEncodingContainer {
    /// encode
    public mutating func encode<T>(
        _ value: Autowired<T>,
        forKey key: KeyedEncodingContainer<K>.Key) throws {
        // Do nothing
    }
}
