//
//  Rx+Controller.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/5.
//

#if canImport(UIKit)
import UIKit
/// 通用UIViewController拓展
public extension Reactive where Base: UIViewController {
    /// 路由页面Id
    var routePageId: String {
        guard let value = objc_getAssociatedObject(base, &AssociatedKeys.routeId) as? String else {
            return ""
        }
        return value
    }
    /// 设置页面路由id
    @discardableResult
    func setRoutePageId(_ id: String) -> Self {
        objc_setAssociatedObject(base, &AssociatedKeys.routeId, id, .OBJC_ASSOCIATION_RETAIN)
        return self
    }
}
#endif
