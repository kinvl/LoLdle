//
//  GetChampionIconUseCase.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

import Foundation
import UIKit

protocol GettingChampionIconUseCase {
    func execute(forChampionId id: Int?) -> UIImage?
}

final class GetChampionIconUseCase: GettingChampionIconUseCase {
    private let repository: ChampionsRepository
    
    // MARK: - Initialization
    init(repository: ChampionsRepository) {
        self.repository = repository
    }
    
    // MARK: - GettingChampionIconUseCase
    func execute(forChampionId id: Int?) -> UIImage? {
        return try? repository.getChampionIcon(id: id)
    }
}
