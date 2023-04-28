//
//  App+root.swift
//  Example
//
//  Created by yaochenfeng on 2023/4/28.
//

import UIKit

extension MainAppWrapper {
    /// 项目根控制器
    static func rootController() -> UIViewController {
        return RXNavigationController.rx.new.base
    }
}
