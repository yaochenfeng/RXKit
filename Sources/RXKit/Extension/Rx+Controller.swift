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
    internal(set) var routePageId: String {
        get {
            guard let value = objc_getAssociatedObject(base, &AssociatedKeys.routeId) as? String else {
                return ""
            }
            return value
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.routeId, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
#endif
