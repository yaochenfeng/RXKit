//
//  RXRouter.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/16.
//

import Foundation

public class RXRouter {
    public static let shared = RXRouter()
    public init() {}
    var items = [RXRouteConvertible.Type]()  
}

public extension RXRouter {
    func addRoute(_ item: RXRouteConvertible.Type) {
        items.append(item)
    }
    func canOpen(_ string: String) -> Bool {
        return items.contains { route in
            return route.init(string: string) != nil
        }
    }
    func open(_ string: String,
              animated: Bool = true,
              source: UIViewController? = nil) {
        let route = items.compactMap { route in
            return route.init(string: string)
        }.first
        route?.navigate(animated: animated, source: source)
    }
    
    func canOpen(_ url: URL) -> Bool {
        return canOpen(url.absoluteString)
    }
    func open(_ url: URL,
              animated: Bool = true,
              source: UIViewController? = nil) {
        return self.open(url.absoluteString, animated: animated, source: source)
    }
}
