//
//  RXBoxView.swift
//  
//
//  Created by yaochenfeng on 2023/3/16.
//
#if canImport(UIKit)
import UIKit

open class RXBoxView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    open func commomInit() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    public override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    public var intrinsicSize: CGSize? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    open override var intrinsicContentSize: CGSize {
        if let size = intrinsicSize {
            return size
        }
        return super.intrinsicContentSize
    }
}
#endif
