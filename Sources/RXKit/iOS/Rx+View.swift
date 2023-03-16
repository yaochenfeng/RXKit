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
    /// - Parameter radius: 度数
    /// - Returns: Reactive
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        base.layer.cornerRadius = radius
        base.layer.masksToBounds = true
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
public extension Reactive where Base: UICollectionView {
    /// 创建对象链式操作
    static var new: Reactive<Base> {
        return Base(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).rx
    }
}
#endif

#if canImport(SwiftUI)
import SwiftUI
@available(iOS 13.0, *)
extension Reactive: View, UIViewRepresentable where Base: UIView {
    public typealias Context = UIViewRepresentableContext<Self>
    public func makeUIView(context: Context) -> Base {
        return base
    }
    public func updateUIView(_ uiView: Base, context: Context) {}
    
    public typealias UIViewType = Base
}

#endif
