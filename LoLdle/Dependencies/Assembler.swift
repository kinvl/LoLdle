//
//  Assembler.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Foundation
import Swinject

final class Assembler {
    @MainActor
    static let assembler: Swinject.Assembler = {
        return Swinject.Assembler([
            ApplicationAssembly(),
            MainAssembly(),
            ChallengeAssembly(),
            RepositoryAssembly(),
            StorageAssembly(),
            NetworkAssembly(),
            UseCaseAssembly(),
            UtilityAssembly(),
            AboutAssembly()
        ])
    }()
}
