/// 服务容器
public protocol Container {
    /// 基于参数的服务注册
    func register<T, A>(_ serviceType: T.Type, name: String?, factory: @escaping (A) -> T)
    /// 基于参数的服务解析
    func resolve<T, A>(_ serviceType: T.Type, name: String?, argument: A) -> T?
}
public extension Container {
    /// 无参数服务注册
    func register<T>(_ serviceType: T.Type = T.self, factory: @escaping () -> T) {
        return register(serviceType, name: nil) { (_: Void) in
            factory()
        }
    }
    /// 无参数解析
    func resolve<T>(_ serviceType: T.Type = T.self) -> T? {
        return resolve(serviceType, name: nil, argument: ())
    }
}
protocol ServiceProvider {
    associatedtype ServiceType
    func resolve() -> ServiceType
    
    func register()
    func boot()
}

public class RXContainer: Container {
    public func resolve<T, A>(_ serviceType: T.Type, name: String?, argument: A) -> T? {
        let key = SerivceKey(serviceType: serviceType, arg: A.self, name: name)
        guard let factory = getFactory(key) else { return nil }
        let block = factory.factory as? (A) -> T
        return block?(argument)
    }
    
    public func register<T, A>(_ serviceType: T.Type, name: String?, factory: @escaping (A) -> T) {
        let key = SerivceKey(serviceType: serviceType, arg: A.self, name: name)
        let value = SerivceFactory(serviceType: serviceType, argumentsType: A.self, factory: factory)
        factories[key] = value
    }
    func getFactory(_ key: SerivceKey) -> SerivceFactory? {
        if let value = factories[key] { //类型参数别名一致
            return value
        } else if let value = factories[key.withoutName()] {    //类型参数一致
            return value
        } else if let value = factories[key.onlyService()] {    //类型一致
            return value
        }
        return nil
    }

    public static let shared = RXContainer()
    public init() {}
    private var factories = [SerivceKey: SerivceFactory]()
}

struct SerivceKey: Hashable {
    static func == (lhs: SerivceKey, rhs: SerivceKey) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(serviceType))
        hasher.combine(ObjectIdentifier(argumentType))
        hasher.combine(name)
    }
    
    let serviceType: Any.Type
    let argumentType: Any.Type
    let name: String?
    init(serviceType: Any.Type, arg: Any.Type, name: String?) {
        self.serviceType = serviceType
        self.argumentType = arg
        self.name = name
    }
    func withoutName() -> SerivceKey {
        return SerivceKey(serviceType: serviceType, arg: argumentType, name: nil)
    }
    func onlyService() -> SerivceKey {
        return SerivceKey(serviceType: serviceType, arg: Void.self, name: nil)
    }
}

struct SerivceFactory {
    internal let serviceType: Any.Type
    internal let argumentsType: Any.Type
    internal let factory: Any
    internal init(serviceType: Any.Type, argumentsType: Any.Type, factory: Any) {
            self.serviceType = serviceType
            self.argumentsType = argumentsType
            self.factory = factory
    }
}
