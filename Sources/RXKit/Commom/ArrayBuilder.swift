/// 数组结构构造器
@resultBuilder
public struct ArrayBuilder<T> {
    /// 数组构造
    public static func buildOptional(_ component: [T]?) -> [T] {
        return component ?? []
    }
    /// 数组构造
    public static func buildBlock(_ components: [T]...) -> [T] {
        return Array(components.joined())
    }
    
    /// 数组构造
    public static func buildExpression(_ expression: T) -> [T] {
        return [expression]
    }
    /// 数组构造
    public static func buildArray(_ components: [[T]]) -> [T] {
        return Array(components.joined())
    }
    /// 数组构造
    public static func buildEither(first component: [T]) -> [T] {
        return component
    }
    /// 数组构造
    public static func buildEither(second component: [T]) -> [T] {
        return component
    }
    /// 数组构造
    public static func buildLimitedAvailability(_ component: [T]) -> [T] {
        return component
    }
}

public extension Array {
    /// 数组构造
    init(@ArrayBuilder<Element> builder: () -> [Element]) {
        self.init(builder())
    }
}
