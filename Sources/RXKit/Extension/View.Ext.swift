//
//  View.ext.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/7/12.
//

#if canImport(SwiftUI) && canImport(UIKit)
import SwiftUI
import UIKit

@available(iOS 13.0, *)
public extension View {
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
