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
        var controller: UIViewController?
        
        switch self {
        case .home:
            DemoViewController.rx.new.chain { base in
                controller = base
                base.navigationItem.title = "demo"
            }
        }
        return controller?.rx.setRoutePageId(routeId).base
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
