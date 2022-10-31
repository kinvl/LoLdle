//
//  ChallengeAssembly.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 11/09/2022.
//

import Swinject

final class ChallengeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ChallengeViewController.self) { (resolver, challengeType: ChallengeType) in
            let viewModel = resolver.resolve(ChallengeViewModeling.self, argument: challengeType)!
            return ChallengeViewController(viewModel: viewModel)
        }
        
        container.register(ChallengeViewModeling.self) { (resolver, challengeType: ChallengeType) in
            let getAllChampionsNamesUseCase = resolver.resolve(GettingAllChampionsNamesUseCase.self)!
            let getChampionUseCase = resolver.resolve(GettingChampionUseCase.self)!
            let getChallengeSecretUseCase = resolver.resolve(GettingChallengeSecretUseCase.self)!
            let getChampionIconUseCase = resolver.resolve(GettingChampionIconUseCase.self)!
            let challengeCompletionManager = resolver.resolve(ChallengeCompletionManaging.self)!
            return ChallengeViewModel(challengeType: challengeType, getAllChampionsNamesUseCase:getAllChampionsNamesUseCase, getChampionUseCase: getChampionUseCase, getChallengeSecretUseCase: getChallengeSecretUseCase, getChampionIconUseCase: getChampionIconUseCase, challengeCompletionManager: challengeCompletionManager)
        }
    }
}
