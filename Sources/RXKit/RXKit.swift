@_exported import RxSwift
import RxCocoa

/// 响应事件 如点击
public typealias RXEventAction = () -> Void

extension ObservableType {
    /// 使用keyPath转化类型
    /// - Parameter keyPath: 属性
    public func map<Value>(by keyPath: WritableKeyPath<Element, Value>) -> Observable<Value> {
        return asObservable().map { value in
            return value[keyPath: keyPath]
        }
    }
}
