//
//  UIView.Rx.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/7/13.
//

#if canImport(SnapKit)
import SnapKit
/// 转换UIView协议
public protocol RXViewConvertible {
    /// 转为视图
    /// - Returns: UIView
    func asView() -> ConstraintView
}

extension ConstraintView: RXViewConvertible {
    public func asView() -> ConstraintView {
        return self
    }
}

public extension Reactive where Base: ConstraintView {
    /// SnapKit DSL
    var snp: ConstraintViewDSL {
        return base.snp
    }
    
    /// 添加到父视图
    /// - Parameter sp: 父视图
    /// - Returns: Reactive
    @discardableResult
    func add2(_ sp: RXViewConvertible) -> Self {
        sp.asView().addSubview(base)
        return self
    }
    /// snapkit make布局
    /// - Parameter mk: 布局描述
    /// - Returns: 自身(for chainable)
    @discardableResult
    func layout(_ mk: (ConstraintMaker) -> Void) -> Self {
        snp.makeConstraints(mk)
        return self
    }
}

extension Reactive: RXViewConvertible where Base: ConstraintView {
    public func asView() -> ConstraintView {
        return base
    }
}
#endif

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
        for view in sequence(first: base, next: { $0?.superview }) {
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
    /// 转为图片
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: base.bounds)
        return renderer.image { rendererContext in
            base.layer.render(in: rendererContext.cgContext)
        }
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
    /// 底部两圆角
    static var rxBottom = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
}

#endif
