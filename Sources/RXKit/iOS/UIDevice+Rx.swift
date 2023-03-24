//
//  UIDevice+Rx.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/3/24.
//

#if canImport(UIKit)
import UIKit
/// 通用UIDevice拓展
public extension Reactive where Base: UIDevice {
    /// 是否iPhone
    static var isIphone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone && !isIpad
    }
    /// 是否iPad
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
#endif
