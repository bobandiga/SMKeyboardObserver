//
//  AppDelegate.swift
//  SMKeyboardObserber
//
//  Created by bobandiga on 03/20/2022.
//  Copyright (c) 2022 bobandiga. All rights reserved.
//

import UIKit
import SMKeyboardObserber

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let rootVC = ViewController()
        let rootNC = UINavigationController(rootViewController: rootVC)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()

        return true
    }
}

