//
//  ChallengeService.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 09/10/2022.
//

import Foundation
import RxSwift

protocol ChallengeService {
    func getSecret(forChallengeType challengeType: ChallengeType) -> Single<Data>
}

extension Network: ChallengeService {
    var challengeEndpoint: String {
        "challenge/"
    }
    
    // MARK: - ChallengeService
    func getSecret(forChallengeType challengeType: ChallengeType) -> Single<Data> {
        return get(challengeEndpoint + challengeType.urlComponent)
    }
}
