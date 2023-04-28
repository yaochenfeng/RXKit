//
//  Rx+UI.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/3/20.
//

#if canImport(UIKit)
import UIKit
public extension Reactive where Base: UIImage {
    
    /// 通过色值创建图片
    static func new(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
// MARK: UIVIew
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
extension Reactive where Base: UIButton {
    /// Reactive wrapper for `setTitle(_:for:)`
    public func titleColor(for controlState: UIControl.State = []) -> Binder<UIColor?> {
        Binder(self.base) { button, value in
            button.setTitleColor(value, for: controlState)
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
