//
//  ChallengesRepository.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

import Foundation

protocol ChallengesRepository {
    func lastCompletedChallengeInfoDictionary(type: ChallengeType) -> [AnyHashable: Any]?
    func saveCompletionInfo(_ info: [String: Any], forType type: ChallengeType)
}

extension PersistentStorageRepository: ChallengesRepository {
    func lastCompletedChallengeInfoDictionary(type: ChallengeType) -> [AnyHashable: Any]? {
        dictionary(for: type.userDefaultsKey)
    }
    
    func saveCompletionInfo(_ info: [String: Any], forType type: ChallengeType) {
        save(value: info, forKey: type.userDefaultsKey)
    }
}
