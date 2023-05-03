//
//  BeanFactory.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/4.
//

import Foundation

/// bean定义
public class BeanFactory {
    internal let serviceType: Any.Type
    internal let argumentsType: Any.Type
    internal let factory: Any
    internal init(serviceType: Any.Type, argumentsType: Any.Type, factory: Any) {
            self.serviceType = serviceType
            self.argumentsType = argumentsType
            self.factory = factory
    }
    internal weak var container: Container?
    fileprivate var initCompletedActions: [(Container) -> Void] = []
}

public extension BeanFactory {
    /// 完成回调
    @discardableResult
    func initCompleted(_ completed: @escaping (Container) -> Void) -> Self {
        initCompletedActions.append(completed)
        return self
    }
}
