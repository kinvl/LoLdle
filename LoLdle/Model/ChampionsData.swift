//
//  ChampionsData.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 01/09/2022.
//

import Foundation
import RealmSwift

struct ChampionsData: Codable {
    let iconURL: String
    let champions: [Champion]
}
