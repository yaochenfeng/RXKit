//
//  ExampleApp.swift
//  Example
//
//  Created by yaochenfeng on 2023/4/27.
//

@main
struct MainAppWrapper {
    static func main() {
        if #available(iOS 14.0, *) {
            MainApp.main()
        } else {
            #if os(iOS)
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil,
                NSStringFromClass(AppDelegate.self))
            #endif
        }
    }
}

#if canImport(SwiftUI)
import SwiftUI
@available(iOS 14.0, *)
struct MainApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            RXPagePreview {
                return MainAppWrapper.rootController()
            }.edgesIgnoringSafeArea(.all).onOpenURL { url in
                RXRouter.shared.open(url)
            }
        }
    }
}
@available(iOS 13.0, *)
extension AppDelegate: ObservableObject {}
#endif
