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
    /// 创建对象链式操作
    static var new: Reactive<Base> {
        return Base().rx
    }
    
    /// 添加到父视图
    /// - Parameter sp: 父视图
    /// - Returns: Reactive
    @discardableResult
    func add2(_ sp: ConstraintView) -> Self {
        sp.addSubview(base)
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
#endif
