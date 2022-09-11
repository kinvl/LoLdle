//
//  Gender.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

import Foundation
import RealmSwift

enum Gender: String, Codable, PersistableEnum, Titleable {
    case male
    case female
    case other
    
    var title: String {
        switch self {
        case .male:
            return R.string.localizable.champion_gender_male()
        case .female:
            return R.string.localizable.champion_gender_female()
        case .other:
            return R.string.localizable.champion_gender_other()
        }
    }
}
