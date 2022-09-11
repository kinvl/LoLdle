//
//  ChallengeType.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 09/10/2022.
//

import Foundation

enum ChallengeType: String, Codable {
    case champion
    case quote
    case ability
    case splash
    
    var urlComponent: String {
        switch self {
        case .champion:
            return "champion/"
        case .quote:
            return "quote/"
        case .ability:
            return "ability/"
        case .splash:
            return "splash/"
        }
    }
}
