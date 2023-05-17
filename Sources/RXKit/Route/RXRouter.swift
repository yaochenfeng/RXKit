//
//  RXRouter.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/16.
//

#if canImport(UIKit)
import UIKit
/// 路由
public class RXRouter {
    /// 共享实例
    public static let shared = RXRouter()
    /// 初始化
    public init() {}
    var items = [RXRouteConvertible.Type]()  
}

public extension RXRouter {
    /// 添加
    func addRoute(_ item: RXRouteConvertible.Type) {
        items.append(item)
    }
    /// 能否打开
    func canOpen(_ string: String) -> Bool {
        return items.contains { route in
            return route.init(string: string) != nil
        }
    }
    /// 路由页面
    func open(_ string: String,
              animated: Bool = true,
              source: UIViewController? = nil) {
        let route = items.compactMap { route in
            return route.init(string: string)
        }.first
        route?.navigate(animated: animated, source: source)
    }
    /// 能否打开
    func canOpen(_ url: URL) -> Bool {
        return canOpen(url.absoluteString)
    }
    /// 路由页面
    func open(_ url: URL,
              animated: Bool = true,
              source: UIViewController? = nil) {
        return self.open(url.absoluteString, animated: animated, source: source)
    }
}

#endif
