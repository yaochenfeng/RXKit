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
}
extension RXRouteConvertible {
    /// 通用导航控制器
    public static func getNavigationController() -> UINavigationController {
        return RXNavigationController.shared
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
}

open class RXNavigationController: UINavigationController {
    public static let shared = RXNavigationController()
}
#endif
