import UIKit
@_exported import RXKit

#if canImport(DoraemonKit)
import DoraemonKit
#endif
#if canImport(CocoaLumberjack)
        import CocoaLumberjack
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        commomService()
        setupDebug()
        
        return true
    }
}

extension AppDelegate {
    func commomService() {
#if canImport(CocoaLumberjack)
        DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.maximumFileSize = 1_024 * 1_024 * 20 // 20M
        fileLogger.logFileManager.maximumNumberOfLogFiles = 20 // 20 files
        DDLog.add(fileLogger)
#endif
    }
    
    func setupDebug() {
#if canImport(DoraemonKit)
        DoraemonCacheManager.sharedInstance().saveMemoryLeak(true)
        DoraemonCacheManager.sharedInstance().saveCrashSwitch(true)
        DoraemonCacheManager.sharedInstance().saveMemoryLeakAlert(true)
        DoraemonCacheManager.sharedInstance().saveLoggerSwitch(true)
        DoraemonCacheManager.sharedInstance().saveStartClass(NSStringFromClass(self.classForCoder))
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            DoraemonManager.shareInstance().install()
        })
#endif
    }
}

@available(iOS 13.0, *)
extension AppDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
