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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let authService = Dependencies.shared.authService()
        authService.requestToken(url)

        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        var didHandle = false

        if (userActivity.activityType == NSUserActivityTypeBrowsingWeb) {
            let authService = Dependencies.shared.authService()
            authService.requestToken(userActivity.webpageURL!)

            didHandle = true
        }

        return didHandle
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        let locationService = Dependencies.shared.locationService()
        locationService.setBackgroundAccuracy()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        let locationService = Dependencies.shared.locationService()
        locationService.setForegroundAccuracy()
    }
}

