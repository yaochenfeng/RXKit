//
//  Container+resoler.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/4.
//

import Foundation

extension RXContainer {
    /// 服务对象生成
    public func resolve<T, A>(_ serviceType: T.Type, name: String?, argument: A) -> T? {
        let key = SerivceKey(serviceType: serviceType, arg: A.self, name: name)
        guard let factory = getFactory(key) else { return nil }
        let block = factory.factory as? (Container, A) -> T
        let object = block?(self, argument)
        return object
    }
    func getFactory(_ key: SerivceKey) -> BeanFactory? {
        if let value = factories[key] { // 类型参数别名一致
            return value
        } else if let value = factories[key.withoutName()] {    // 类型参数一致
            return value
        } else if let value = factories[key.onlyService()] {    // 类型一致
            return value
        }
        return nil
    }
}
