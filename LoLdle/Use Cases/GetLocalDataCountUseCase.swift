//
//  GetLocalDataCountUseCase.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Foundation
import RxSwift

protocol GettingLocalDataCountUseCase {
    /// Get the number of data used in the application that is stored on a drive.
    /// - Returns: Dictionary with keys `champions` and `icons`, which contain the number of said objects on a drive.
    func execute() -> Single<[String: Int]>
}

class GetLocalDataCountUseCase: GettingLocalDataCountUseCase {
    private let repository: ChampionsRepository
    
    // MARK: - Initialization
    init(repository: ChampionsRepository) {
        self.repository = repository
    }
    
    // MARK: - GettingLocalDataCountUseCase
    func execute() -> Single<[String: Int]> {
        return repository.getAllChampions()
            .asObservable()
            .withLatestFrom(repository.getChampionsIconCount()) { champions, iconCount in
                [
                    "champions": champions.count,
                    "icons": iconCount
                ]
            }.asSingle()
    }
}
