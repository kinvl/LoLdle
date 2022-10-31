//
//  GetChampionUseCase.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

import RxSwift

protocol GettingChampionUseCase {
    func execute(forName name: String) -> Champion?
}

final class GetChampionUseCase: GettingChampionUseCase {
    private let repository: ChampionsRepository
    
    // MARK: - Initialization
    init(repository: ChampionsRepository) {
        self.repository = repository
    }
    
    // MARK: - GettingChampionUseCase
    func execute(forName name: String) -> Champion? {
        return repository.getChampion(named: name)
    }
}
