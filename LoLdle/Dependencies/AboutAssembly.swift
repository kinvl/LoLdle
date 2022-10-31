//
//  AboutAssembly.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

import Swinject

final class AboutAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AboutViewController.self) { _ in
            return AboutViewController()
        }
    }
}
