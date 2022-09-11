//
//  GetAllChampionsNamesUseCase.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 23/09/2022.
//

import RxSwift

protocol GettingAllChampionsNamesUseCase {
    func execute() -> Single<[String]>
}

final class GetAllChampionsNamesUseCase: GettingAllChampionsNamesUseCase {
    private let repository: ChampionsRepository
    
    // MARK: - Initialization
    init(repository: ChampionsRepository) {
        self.repository = repository
    }
    
    // MARK: - GettingAllChampionsNamesUseCase
    func execute() -> Single<[String]> {
        return repository.getAllChampionsNames()
            .subscribe(on: ConcurrentMainScheduler.instance)
    }
}
