//
//  AppDelegate.swift
//  burgershop-finder
//
//  Created by e.vanags on 08/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private func isDebugModeEnabled() -> Bool {
        return ProcessInfo.processInfo.environment["DEBUG_MODE"] == "enable"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let dependencies: Dependencies = isDebugModeEnabled() ? TestDependencies() : MainDependencies()
        DependencyAssembler.register(dependencies: dependencies)

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let authService = DependencyAssembler.dependencies.authService()
        authService.requestToken(url)

        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        var didHandle = false

        if (userActivity.activityType == NSUserActivityTypeBrowsingWeb) {
            let authService = DependencyAssembler.dependencies.authService()
            authService.requestToken(userActivity.webpageURL!)

            didHandle = true
        }

        return didHandle
    }
}

