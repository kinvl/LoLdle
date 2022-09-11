//
//  ChallengeSecret.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 09/10/2022.
//

import Foundation

struct ChallengeSecret: Codable {
    let championName: String
    let challengeType: ChallengeType
    
    enum CodingKeys: String, CodingKey {
        case championName = "challengeSecret"
        case challengeType
    }
}
