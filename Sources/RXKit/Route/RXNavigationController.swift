//
//  RXRouteController.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/5.
//

#if canImport(UIKit)
import UIKit

/// 通用UIViewController拓展
public extension Reactive where Base: UINavigationController {
    /// 是否已经包含某个路由
    func contain(_ routeId: String) -> Bool {
        guard !routeId.isEmpty else { return false }
        return base.viewControllers.contains { vc in
            return vc.rx.routePageId == routeId
        }
    }
    /// 根据routeId 获取controller
    func getRouteController(_ routeId: String) -> UIViewController? {
        guard !routeId.isEmpty else { return nil }
        return base.viewControllers.first { vc in
            return vc.rx.routePageId == routeId
        }
    }
}

open class RXNavigationController: UINavigationController {
    public static let shared = RXNavigationController()
}
#endif
