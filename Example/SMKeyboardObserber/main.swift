//
//  main.swift
//  SMKeyboardObserber_Example
//
//  Created by Shaptala Maksim on 20.06.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

final class Application: UIApplication {

    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)

        print(event)
    }
}

let argc = CommandLine.argc
let argv = CommandLine.unsafeArgv

_ = UIApplicationMain(argc, argv, NSStringFromClass(Application.self), NSStringFromClass(AppDelegate.self))
