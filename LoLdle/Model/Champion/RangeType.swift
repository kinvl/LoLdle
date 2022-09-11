//
//  RangeType.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

import Foundation
import RealmSwift

enum RangeType: String, Codable, PersistableEnum, Titleable {
    case melee
    case ranged
    case both
    
    var title: String {
        switch self {
        case .melee:
            return R.string.localizable.champion_rangeType_melee()
        case .ranged:
            return R.string.localizable.champion_rangeType_ranged()
        case .both:
            return "\(R.string.localizable.champion_rangeType_melee()), \(R.string.localizable.champion_rangeType_ranged())"
        }
    }
}
