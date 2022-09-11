//
//  Position.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

import Foundation
import RealmSwift

enum Position: String, Codable, PersistableEnum, Titleable {
    case top
    case jungle
    case middle
    case bottom
    case support
    
    var title: String {
        switch self {
        case .top:
            return R.string.localizable.champion_position_top()
        case .jungle:
            return R.string.localizable.champion_position_jungle()
        case .middle:
            return R.string.localizable.champion_position_middle()
        case .bottom:
            return R.string.localizable.champion_position_bottom()
        case .support:
            return R.string.localizable.champion_position_support()
        }
    }
}
