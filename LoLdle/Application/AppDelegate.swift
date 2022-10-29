//
//  AppDelegate.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = Assembler.assembler.resolver.resolve(UIWindow.self)!
        window?.makeKeyAndVisible()
        
        Analytics.shared.setup()
        
        return true
    }
}
