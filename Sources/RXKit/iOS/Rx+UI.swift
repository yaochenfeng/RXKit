//
//  Rx+UI.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/3/20.
//

#if canImport(UIKit)
import UIKit
/// 通用UIView拓展
public extension Reactive where Base: UILabel {
    /// 创建对象链式操作,Hugging 默认251
    static var new: Reactive<Base> {
        return Base(frame: .zero).rx.chain { base in
            base.setContentHuggingPriority(.init(251), for: .horizontal)
            base.setContentHuggingPriority(.init(251), for: .vertical)
        }
    }
}
public extension Reactive where Base: UIImageView {
    /// 创建对象链式操作,Hugging 默认251
    static var new: Reactive<Base> {
        return Base(frame: .zero).rx.chain { base in
            base.setContentHuggingPriority(.init(251), for: .horizontal)
            base.setContentHuggingPriority(.init(251), for: .vertical)
        }
    }
    
    /// 创建对象链式操作,Hugging 默认251
    static func named(_ named: String) -> Reactive<Base> {
        return new.set(by: \.image, UIImage(named: named)).chain { base in
            base.setContentHuggingPriority(.init(251), for: .horizontal)
            base.setContentHuggingPriority(.init(251), for: .vertical)
        }
    }
}
public extension Reactive where Base: UICollectionView {
    /// 创建对象链式操作
    static var new: Reactive<Base> {
        return Base(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).rx
    }
}
#endif
