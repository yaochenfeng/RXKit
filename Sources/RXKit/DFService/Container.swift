/// 服务容器
public protocol Container: AnyObject {
    /// 基于参数的服务注册
    func register<T, A>(_ beanType: T.Type, name: String?, factory: @escaping (Container, A) -> T) -> BeanFactory
    /// 基于参数的服务解析
    func resolve<T, A>(_ beanType: T.Type, name: String?, argument: A) -> T?
}
public extension Container {
    /// 无参数服务注册
    @discardableResult
    func register<T>(_ beanType: T.Type = T.self, factory: @escaping (Container) -> T) -> BeanFactory {
        return register(beanType, name: nil) { (_: Container, _: Void) in
            factory(self)
        }
    }
    /// 无参数解析
    func optional<T>(_ beanType: T.Type = T.self) -> T? {
        return resolve(beanType, name: nil, argument: ())
    }
    /// 无参数解析
    func resolve<T>(_ beanType: T.Type = T.self) throws -> T {
        guard let obj: T = optional() else {
            throw DFError.notFound
        }
        return obj
    }
}

public class RXContainer: Container {
    /// 注册
    @discardableResult
    public func register<T, A>(
        _ beanType: T.Type,
        name: String?,
        factory: @escaping (Container, A) -> T) -> BeanFactory {
            let key = SerivceKey(beanType: beanType, arg: A.self, name: name)
            let value = BeanFactory(beanType: beanType, argumentsType: A.self, factory: factory)
            value.container = self
            factories[key] = value
            return value
        }
    
    public static let shared = RXContainer()
    public init() {}
    internal var factories = [SerivceKey: BeanFactory]()
}

struct SerivceKey: Hashable {
    static func == (lhs: SerivceKey, rhs: SerivceKey) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(beanType))
        hasher.combine(ObjectIdentifier(argumentType))
        hasher.combine(name)
    }
    
    let beanType: Any.Type
    let argumentType: Any.Type
    let name: String?
    init(beanType: Any.Type, arg: Any.Type, name: String?) {
        self.beanType = beanType
        self.argumentType = arg
        self.name = name
    }
    func withoutName() -> SerivceKey {
        return SerivceKey(beanType: beanType, arg: argumentType, name: nil)
    }
    func onlyService() -> SerivceKey {
        return SerivceKey(beanType: beanType, arg: Void.self, name: nil)
    }
}
