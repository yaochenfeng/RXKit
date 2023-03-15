//
//  Rx+View.swift
//  
//
//  Created by yaochenfeng on 2023/1/16.
//
#if canImport(UIKit)
import UIKit

public extension Reactive where Base: UIView {
    /// 根据视图找到对应的控制器
    var controller: UIViewController? {
        for view in sequence(first: base.superview, next: { $0?.superview }) {
            if let responder = view?.next, responder.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
        }
        return nil
    }
    
    /// 设置圆角
    /// - Parameter radius: 度数
    /// - Returns: Reactive
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        base.layer.cornerRadius = radius
        base.layer.masksToBounds = true
        return self
    }
}
#endif
