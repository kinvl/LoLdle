//
//  Region.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

import RealmSwift

enum Region: String, Codable, PersistableEnum, Titleable {
    case demacia
    case noxus
    case ionia
    case shurima
    case zaun
    case targon
    case runeterra
    case freljord
    case blessedIsles
    case camavor
    case shadowIsles
    case piltover
    case bandleCity
    case void
    case ixtal
    case icathia
    case bilgewater
    case rhaast
    case kathkan
    
    var title: String {
        switch self {
        case .demacia:
            return R.string.localizable.champion_region_demacia()
        case .noxus:
            return R.string.localizable.champion_region_noxus()
        case .ionia:
            return R.string.localizable.champion_region_ionia()
        case .shurima:
            return R.string.localizable.champion_region_shurima()
        case .zaun:
            return R.string.localizable.champion_region_zaun()
        case .targon:
            return R.string.localizable.champion_region_targon()
        case .runeterra:
            return R.string.localizable.champion_region_runeterra()
        case .freljord:
            return R.string.localizable.champion_region_freljord()
        case .blessedIsles:
            return R.string.localizable.champion_region_blessedIsles()
        case .camavor:
            return R.string.localizable.champion_region_camavor()
        case .shadowIsles:
            return R.string.localizable.champion_region_shadowIsles()
        case .piltover:
            return R.string.localizable.champion_region_piltover()
        case .bandleCity:
            return R.string.localizable.champion_region_bandleCity()
        case .void:
            return R.string.localizable.champion_region_void()
        case .ixtal:
            return R.string.localizable.champion_region_ixtal()
        case .icathia:
            return R.string.localizable.champion_region_icathia()
        case .bilgewater:
            return R.string.localizable.champion_region_bilgewater()
        case .rhaast:
            return R.string.localizable.champion_region_rhaast()
        case .kathkan:
            return R.string.localizable.champion_region_kathkan()
        }
    }
}
