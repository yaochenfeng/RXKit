//
//  Foundation.Rx.swift
//  Example
//
//  Created by yaochenfeng on 2023/7/17.
//

import Foundation
import RxSwift
extension UIEdgeInsets: ReactiveCompatible {}

extension Reactive where Base == UIEdgeInsets {
    /// 宽
    public var width: CGFloat {
        return base.left + base.right
    }
    
    /// 高
    public var height: CGFloat {
        return base.top + base.bottom
    }
}
