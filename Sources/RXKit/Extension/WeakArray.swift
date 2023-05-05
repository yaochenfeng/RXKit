//
//  WeakArray.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/5.
//

import Foundation
/// 弱引用数组
public struct WeakArray<Element: AnyObject> {
    private var items: [WeakBox<Element>] = []
    /// 数组
    public init<S>(_ elements: S) where S: Sequence, Element == S.Element {
        items = elements.map { WeakBox($0) }
    }
}
extension WeakArray: Collection {
    public var startIndex: Int { items.startIndex }
    public var endIndex: Int { items.endIndex }
    public subscript(position: Int) -> Element? {
        items[position].unbox
    }
    public func index(after i: Int) -> Int {
        items.index(after: i)
    }
}
extension WeakArray: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

final class WeakBox<A: AnyObject> {
    weak var unbox: A?
    init(_ value: A) {
        unbox = value
    }
}
