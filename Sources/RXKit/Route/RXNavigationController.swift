//
//  RXRouteController.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/5.
//

#if canImport(UIKit)
import UIKit

/// 路由转换协议
public protocol RXRouteConvertible {
    /// 字符串转路由
    init?(string: String)
    /// 路由ID
    var routeId: String { get }
    /// 路由转控制器
    func getController() -> UIViewController?
    /// 获取导航控制器
    static func getNavigationController() -> UINavigationController
    /// 导航到对应路由
    func navigate(animated: Bool, source: UIViewController?)
}
public extension RXRouteConvertible {
    /// 通用导航控制器
    static func getNavigationController() -> UINavigationController {
        return RXNavigationController.shared
    }
    /// 默认使用push
    func navigate(animated: Bool = true, source: UIViewController? = nil) {
        let nav = Self.getNavigationController()
        if let old = nav.rx.getRouteController(routeId) {
            nav.popToViewController(old, animated: animated)
        } else if let vc = getController() {
            nav.pushViewController(vc, animated: animated)
        }
    }
    
}
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
