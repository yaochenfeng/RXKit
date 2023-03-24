//
//  RXControl.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/3/24.
//

import UIKit

public class RXControl: UIControl {
    internal var body: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            updateInset()
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    var clickEvent: RXEventAction = {}
    
    func commomInit() {
        rx.controlEvent(.touchUpInside)
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.clickEvent()
            }).disposed(by: rx.disposeBag)
    }
    func updateInset() {
        body?.rx.add2(self).layout { mk in
            mk.center.equalToSuperview()
            mk.width.lessThanOrEqualToSuperview()
            mk.height.lessThanOrEqualToSuperview()
        }
    }
}

public extension Reactive where Base: UIControl {
    /// 点击事件，不可重复设置
    @discardableResult
    func onClick(_ block: @escaping RXEventAction) -> Self {
        controlEvent(.touchUpInside).subscribe(onNext: { _ in
            block()
        }).disposed(by: disposeBag)
        return self
    }
}
public extension Reactive where Base: RXControl {
    /// 点击事件，不可重复设置
    @discardableResult
    func onClick(_ block: @escaping RXEventAction) -> Self {
        base.clickEvent = block
        return self
    }
    /// 设置内容
    @discardableResult
    func body(_ block: () -> RXViewConvertible) -> Self {
        base.body = block().asView()
        return self
    }
}
