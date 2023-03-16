//
//  RXView.swift
//  
//
//  Created by yaochenfeng on 2023/3/10.
//

#if canImport(UIKit)
import UIKit

/// 转换UIView协议
public protocol RXViewConvertible {
    
    /// 转为视图
    /// - Returns: UIView
    func asView() -> UIView
}


extension UIView: RXViewConvertible {
    public func asView() -> UIView {
        return self
    }
}
extension Reactive: RXViewConvertible where Base: UIView {
    public func asView() -> UIView {
        return base
    }
}

#endif
