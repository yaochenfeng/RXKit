//
//  RXViewPreview.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/4/28.
//
#if canImport(SwiftUI) && canImport(UIKit)
import SwiftUI
import UIKit

/// view 转SwiftUI
@available(iOS 13.0, *)
public struct RXPreview<Base: UIView>: UIViewRepresentable {
    let builder: () -> Base
    /// 初始化
    public init(_ builder: @escaping () -> Base) {
        self.builder = builder
    }
    public func makeUIView(context: Context) -> Base {
        return builder()
    }
    
    public func updateUIView(_ uiView: Base, context: Context) {
    
    }
    public typealias UIViewType = Base
}

/// controller 转SwiftUI
@available(iOS 13.0, *)
public struct RXPagePreview<Page: UIViewController>: UIViewControllerRepresentable {
    let builder: () -> UIViewControllerType
    public init(_ builder: @escaping () -> UIViewControllerType) {
        self.builder = builder
    }
    public func makeUIViewController(context: Context) -> UIViewControllerType {
        return builder()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    public typealias UIViewControllerType = Page
}

@available(iOS 13.0, *)
extension View {
    func asController() -> UIViewController {
        UIHostingController(rootView: self)
    }
    func add2(_ view: UIView) -> Reactive<UIView> {
        let controller = asController()
        view.rx.controller?.addChild(controller)
        return controller.view.rx.add2(view).chain { _ in
            controller.didMove(toParent: view.rx.controller)
        }
    }
}
#endif
