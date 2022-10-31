//
//  ApplicationAssembly.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 15/09/2022.
//

import UIKit
import Swinject

final class ApplicationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UIWindow.self) { resolver in
            let window = UIWindow()
            let controller = UINavigationController(rootViewController: resolver.resolve(MainViewController.self)!)
            window.rootViewController = controller
            return window
        }
    }
}
