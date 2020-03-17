//
//  AppDelegate.swift
//  RCC
//
//  Created by Aaron Huánuco on 14/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = RatesRouter.assembleModule()
        setRootViewController(viewController)
        return true
    }
}

extension AppDelegate {
    private func setRootViewController(_ viewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = viewController
    }
}
