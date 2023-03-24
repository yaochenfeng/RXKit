//
//  Rx+Ext.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/3/24.
//

extension ObservableType {
    
    /// 使用keyPath转化类型
    /// - Parameter keyPath: 属性
    public func map<Value>(by keyPath: WritableKeyPath<Element, Value>) -> Observable<Value> {
        return asObservable().map { value in
            return value[keyPath: keyPath]
        }
    }
}
