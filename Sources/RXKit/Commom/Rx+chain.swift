//
//  File.swift
//  
//
//  Created by yaochenfeng on 2023/3/9.
//

import Foundation

public extension Reactive where Base: AnyObject {
    /// 链式操作
    @discardableResult
    func then(_ block: (Base) throws -> Void) rethrows -> Base {
        try block(self.base)
        return self.base
    }
    /// 链式语法调用函数
    @discardableResult
    func chain(_ block: (Base) throws -> Void) rethrows -> Reactive<Base> {
        try block(base)
        return self
    }
    
    /// 链式设置
    /// - Parameters:
    ///   - keyPath: 属性
    ///   - value: 值
    /// - Returns: Reactive
    func set<Value>(by keyPath: WritableKeyPath<Base, Value>, _ value: Value) -> Reactive<Base> {
        var subject = self.base
        subject[keyPath: keyPath] = value
        return self
    }
    /// 同步锁调用
    /// - Parameter action: 方法
    /// - Returns: 值
    @discardableResult
    func synchronizedBag<T>( _ action: () -> T) -> T {
        objc_sync_enter(self.base)
        let result = action()
        objc_sync_exit(self.base)
        return result
    }
    /// 资源释放
    var disposeBag: DisposeBag {
        synchronizedBag {
            if let disposeObject = objc_getAssociatedObject(base, &AssociatedKeys.dispose) as? DisposeBag {
                return disposeObject
            }
            let disposeObject = DisposeBag()
            objc_setAssociatedObject(base, &AssociatedKeys.dispose, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return disposeObject
        }
    }
}

public extension Reactive where Base: NSObject {
    /// 创建对象链式操作
    static var new: Reactive<Base> {
        return Base().rx
    }
}
