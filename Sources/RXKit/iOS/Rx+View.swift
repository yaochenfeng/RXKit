//
//  Rx+View.swift
//  
//
//  Created by yaochenfeng on 2023/1/16.
//
#if canImport(UIKit)
import UIKit
/// 通用UIView拓展
public extension Reactive where Base: UIView {
    /// 创建对象链式操作
    static var new: Reactive<Base> {
        return Base(frame: .zero).rx
    }
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
    /// - Parameters:
    ///   - radius: 度数
    ///   - corners: CACornerMask 默认四个角
    @discardableResult
    func cornerRadius(_ radius: CGFloat, corners: CACornerMask = .rxAll) -> Self {
        base.layer.cornerRadius = radius
        base.layer.maskedCorners = corners
        return self
    }
    
    /// 设置边框颜色
    @discardableResult
    func border(_ color: UIColor? = nil, width: CGFloat = 0.5) -> Self {
        base.layer.borderWidth = width
        base.layer.borderColor = color?.cgColor
        return self
    }
}

public extension CACornerMask {
    /// 四边都圆角
    static var rxAll = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
    /// 左侧两圆角
    static var rxLeft = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner)
    /// 右侧两圆角
    static var rxRight = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
    /// 顶部两圆角
    static var rxTop = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
}

#endif
