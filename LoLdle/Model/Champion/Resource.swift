//
//  Resource.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

import Foundation
import RealmSwift

enum Resource: String, Codable, PersistableEnum, Titleable {
    case mana
    case energy
    case manaless
    case bloodthirst
    case health
    case fury
    case grit
    case heat
    case ferocity
    case rage
    case shield
    case courage
    case flow
    
    var title: String {
        switch self {
        case .mana:
            return R.string.localizable.champion_resource_mana()
        case .energy:
            return R.string.localizable.champion_resource_energy()
        case .manaless:
            return R.string.localizable.champion_resource_manaless()
        case .bloodthirst:
            return R.string.localizable.champion_resource_bloodthirst()
        case .health:
            return R.string.localizable.champion_resource_health()
        case .fury:
            return R.string.localizable.champion_resource_fury()
        case .grit:
            return R.string.localizable.champion_resource_grit()
        case .heat:
            return R.string.localizable.champion_resource_heat()
        case .ferocity:
            return R.string.localizable.champion_resource_ferocity()
        case .rage:
            return R.string.localizable.champion_resource_rage()
        case .shield:
            return R.string.localizable.champion_resource_shield()
        case .courage:
            return R.string.localizable.champion_resource_courage()
        case .flow:
            return R.string.localizable.champion_resource_flow()
        }
    }
}
