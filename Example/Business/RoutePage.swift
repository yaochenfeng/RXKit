//
//  RoutePage.swift
//  Example
//
//  Created by yaochenfeng on 2023/5/5.
//

import Foundation
enum RoutePage: String {
    case home
}
extension RoutePage: RXRouteConvertible {
    init?(string: String) {
        return nil
    }
    
    var routeId: String {
        return rawValue
    }
    
    func getController() -> UIViewController? {
        return nil
    }
    /// 通用导航控制器
    static func getNavigationController() -> UINavigationController {
        return RXNavigationController.rx.new.base
    }
}

extension Reactive where Base: RXNavigationController {
    static var new: Reactive<Base> {
        return Base().rx
    }
}
