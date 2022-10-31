//
//  MainRouter.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 09/09/2022.
//

import Foundation
import UIKit

protocol MainRouting {
    func presentChampionChallenge(from parent: UINavigationController?)
    func presentAbout(from parent: UIViewController?)
}

class MainRouter: MainRouting {
    func presentChampionChallenge(from parent: UINavigationController?) {
        let controller = Assembler.assembler.resolver.resolve(ChallengeViewController.self, argument: ChallengeType.champion)!
        parent?.pushViewController(controller, animated: true)
    }
    
    func presentAbout(from parent: UIViewController?) {
        let controller = Assembler.assembler.resolver.resolve(AboutViewController.self)!
        parent?.present(controller, animated: true)
    }
}
