//
//  UtilityAssembly.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

import Swinject

final class UtilityAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ChallengeCompletionManaging.self) { resolver in
            let repository = resolver.resolve(ChallengesRepository.self)!
            return ChallengeCompletionManager(repository: repository)
        }
    }
}
