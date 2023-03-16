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
        setupUI()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    open func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    public override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
#endif
