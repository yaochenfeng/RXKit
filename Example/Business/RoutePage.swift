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
        switch self {
        case .home:
            return DemoViewController()
        }
    }
    /// 通用导航控制器
    static func getNavigationController() -> UINavigationController {
        let nav = RXNavigationController.shared
        if nav.viewControllers.isEmpty, let home = RoutePage.home.getController() {
            nav.setViewControllers([home], animated: false)
        }
        return nav
    }
}
