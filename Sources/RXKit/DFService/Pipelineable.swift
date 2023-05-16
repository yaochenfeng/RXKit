//
//  File.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/16.
//

import Foundation
/// 流水线
public protocol Pipelineable {
    /// 输入
    associatedtype Input
    /// 输出
    associatedtype Output
    /// 处理输入
    func process(_ input: Input) throws -> Output
    /// 上下文
    typealias Context = PipelineContext<Self>
}
/// 流水线Context
public struct PipelineContext<Base> where Base: Pipelineable {
    /// 参数
    public var options = [String: Any]()
}

public struct Pipeline<Input, Output> {
    
}
