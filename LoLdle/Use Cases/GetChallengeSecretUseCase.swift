//
//  GetChallengeSecretUseCase.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 09/10/2022.
//

import Foundation
import RxSwift

protocol GettingChallengeSecretUseCase {
    func execute(forChallengeType type: ChallengeType) -> Single<Champion?>
}

final class GetChallengeSecretUseCase: GettingChallengeSecretUseCase {
    private let service: ChallengeService
    private let championsRepository: ChampionsRepository
    private let dataRepository: DataRepository
    
    // MARK: - Initialization
    init(service: ChallengeService, championsRepository: ChampionsRepository, dataRepository: DataRepository) {
        self.service = service
        self.championsRepository = championsRepository
        self.dataRepository = dataRepository
    }
    
    // MARK: - GettingChallengeSecretUseCase
    func execute(forChallengeType type: ChallengeType) -> Single<Champion?> {
        return service.getSecret(forChallengeType: type).flatMap { [weak self] (response: Data) -> Single<Champion?> in
            guard let self = self else { return .error(LoLdleError.networkRequestFailed) }
            return self.dataRepository.handleChallengeSecret(response: response).flatMap { [weak self] secret in
                guard let self = self else { return .error(LoLdleError.networkRequestFailed) }
                return self.championsRepository.getChampion(named: secret.championName)
                    .subscribe(on: ConcurrentMainScheduler.instance)
            }
        }
    }
}
