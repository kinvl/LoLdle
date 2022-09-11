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
}

class MainRouter: MainRouting {
    func presentChampionChallenge(from parent: UINavigationController?) {
        let controller = Assembler.assembler.resolver.resolve(ChallengeViewController.self, argument: ChallengeType.champion)!
        parent?.pushViewController(controller, animated: true)
    }
}
