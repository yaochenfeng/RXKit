//
//  RoutePageView.swift
//  Example
//
//  Created by yaochenfeng on 2023/4/28.
//
#if canImport(SwiftUI)
import SwiftUI
@available(iOS 13.0, *)
struct RoutePageView<Page: UIViewController>: UIViewControllerRepresentable {
    let builder: () -> UIViewControllerType
    init(_ builder: @escaping () -> UIViewControllerType) {
        self.builder = builder
    }
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return builder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    typealias UIViewControllerType = Page
}
#endif
