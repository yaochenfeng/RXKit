//
//  RXRouteConvertible.swift
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
            vc.rx.setRoutePageId(routeId)
            nav.pushViewController(vc, animated: animated)
        }
    }
    
    /// 关闭当前页面，返回上一页面或多级页面
    /// - Parameters:
    ///   - delta: 返回的页面数，如果 delta 大于现有页面数，则返回到首页
    ///   - animated: 是否动画
    static func navigateBack(_ delta: Int = 1, animated: Bool = true) {
        let nav = Self.getNavigationController()
        if delta >= nav.viewControllers.count {
            nav.popToRootViewController(animated: animated)
        } else {
            let vc = nav.viewControllers[nav.viewControllers.count - delta - 1]
            nav.popToViewController(vc, animated: animated)
        }
    }
    /// 把顶部页面替换当前页面
    /// - Parameters:
    ///   - allowRoot: 是否可以替换root 默认不可以
    func redirectTo(_ animated: Bool = true, allowRoot: Bool = false) {
        guard let vc = getController() else { return }
        let nav = Self.getNavigationController()
        var vcs = nav.viewControllers
        if vcs.count > 1 {
            vcs[vcs.count - 1] = vc
        } else if allowRoot {
            vcs[vcs.count - 1] = vc
        } else {
            vcs.append(vc)
        }
        nav.setViewControllers(vcs, animated: animated)
    }
}

#endif
