//
//  File.swift
//  
//
//  Created by yaochenfeng on 2023/3/10.
//

#if canImport(SnapKit)
import SnapKit

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
extension Reactive: RXViewConvertible where Base: ConstraintView {
    public func asView() -> ConstraintView {
        return base
    }
}
#endif
