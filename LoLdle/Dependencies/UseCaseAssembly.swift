//
//  UseCaseAssembly.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 16/10/2022.
//

import Swinject

final class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GettingLocalDataCountUseCase.self) { resolver in
            let repository = resolver.resolve(ChampionsRepository.self)!
            return GetLocalDataCountUseCase(repository: repository)
        }
        
        container.register(GettingRemoteDataCountUseCase.self) { resolver in
            let service = resolver.resolve(DataService.self)!
            let repository = resolver.resolve(DataRepository.self)!
            return GetRemoteDataCountUseCase(service: service, repository: repository)
        }
        
        container.register(DownloadingChampionsDataUseCase.self) { resolver in
            let service = resolver.resolve(DataService.self)!
            let dataRepository = resolver.resolve(DataRepository.self)!
            let championsRepository = resolver.resolve(ChampionsRepository.self)!
            return DownloadChampionsDataUseCase(service: service, dataRepository: dataRepository, championsRepository: championsRepository)
        }
        
        container.register(GettingAllChampionsNamesUseCase.self) { resolver in
            let repository = resolver.resolve(ChampionsRepository.self)!
            return GetAllChampionsNamesUseCase(repository: repository)
        }
        
        container.register(GettingChallengeSecretUseCase.self) { resolver in
            let service = resolver.resolve(ChallengeService.self)!
            let championsRepository = resolver.resolve(ChampionsRepository.self)!
            let dataRepository = resolver.resolve(DataRepository.self)!
            return GetChallengeSecretUseCase(service: service, championsRepository: championsRepository, dataRepository: dataRepository)
        }
        
        container.register(GettingChampionUseCase.self) { resolver in
            let repository = resolver.resolve(ChampionsRepository.self)!
            return GetChampionUseCase(repository: repository)
        }
        
        container.register(GettingChampionIconUseCase.self) { resolver in
            let repository = resolver.resolve(ChampionsRepository.self)!
            return GetChampionIconUseCase(repository: repository)
        }
    }
}
