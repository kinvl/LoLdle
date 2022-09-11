//
//  Species.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

import Foundation
import RealmSwift

enum Species: String, Codable, PersistableEnum, Titleable {
    case human
    case yordle
    case golem
    case darkin
    case godWarrior
    case aspect
    case vastayan
    case minotaur
    case celestial
    case magicallyAltered
    case iceborn
    case cyborg
    case voidBeing
    case spirit
    case chemicallyAltered
    case demon
    case magicborn
    case undead
    case spiritualist
    case god
    case unknown
    case revenant
    case dragon
    case brackern
    case troll
    case rat
    case cat
    
    var title: String {
        switch self {
        case .human:
            return R.string.localizable.champion_species_human()
        case .yordle:
            return R.string.localizable.champion_species_yordle()
        case .golem:
            return R.string.localizable.champion_species_golem()
        case .darkin:
            return R.string.localizable.champion_species_darkin()
        case .godWarrior:
            return R.string.localizable.champion_species_godWarrior()
        case .aspect:
            return R.string.localizable.champion_species_aspect()
        case .vastayan:
            return R.string.localizable.champion_species_vastayan()
        case .minotaur:
            return R.string.localizable.champion_species_minotaur()
        case .celestial:
            return R.string.localizable.champion_species_celestial()
        case .magicallyAltered:
            return R.string.localizable.champion_species_magicallyAltered()
        case .iceborn:
            return R.string.localizable.champion_species_iceborn()
        case .cyborg:
            return R.string.localizable.champion_species_cyborg()
        case .voidBeing:
            return R.string.localizable.champion_species_voidBeing()
        case .spirit:
            return R.string.localizable.champion_species_spirit()
        case .chemicallyAltered:
            return R.string.localizable.champion_species_chemicallyAltered()
        case .demon:
            return R.string.localizable.champion_species_demon()
        case .magicborn:
            return R.string.localizable.champion_species_magicborn()
        case .undead:
            return R.string.localizable.champion_species_undead()
        case .spiritualist:
            return R.string.localizable.champion_species_spiritualist()
        case .god:
            return R.string.localizable.champion_species_god()
        case .unknown:
            return R.string.localizable.champion_species_unknown()
        case .revenant:
            return R.string.localizable.champion_species_revenant()
        case .dragon:
            return R.string.localizable.champion_species_dragon()
        case .brackern:
            return R.string.localizable.champion_species_brackern()
        case .troll:
            return R.string.localizable.champion_species_troll()
        case .rat:
            return R.string.localizable.champion_species_rat()
        case .cat:
            return R.string.localizable.champion_species_cat()
        }
    }
}
