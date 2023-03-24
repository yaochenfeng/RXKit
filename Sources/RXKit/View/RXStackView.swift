//
//  RXStackView.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/3/16.
//
#if canImport(UIKit)
import UIKit

public class RXStackView: UIStackView {
    
}

public extension Reactive where Base: UIStackView {
    
    /// 横向stackView 默认居中
    static func row(@ArrayBuilder<RXViewConvertible> builder: () -> [RXViewConvertible]) -> Reactive<Base> {
        return Base.rx.new.chain { base in
            let views = builder()
            for view in views {
                base.addArrangedSubview(view.asView())
            }
        }.set(by: \.axis, .horizontal)
            .set(by: \.alignment, .center)
    }
    /// 垂直stackView 
    static func column(@ArrayBuilder<RXViewConvertible> builder: () -> [RXViewConvertible]) -> Reactive<Base> {
        return Base.rx.new.chain { base in
            let views = builder()
            for view in views {
                base.addArrangedSubview(view.asView())
            }
        }.set(by: \.axis, .vertical)
    }
    
    /// 设置自定义间距
    @discardableResult
    func setSpacing(_ spacing: CGFloat, after: Int) -> Reactive<Base> {
        if after < base.arrangedSubviews.count {
            let view = base.arrangedSubviews[after]
            base.setCustomSpacing(spacing, after: view)
        }
        return self
    }
}

#endif
