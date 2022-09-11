//
//  Fakes.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 27/10/2022.
//

@testable import LoLdle

final class Fake {
    final class Champions {
        static let one = Champion(id: 1, name: "one", gender: .male, position: [], species: [], resource: .mana, rangeType: .melee, region: [], releaseYear: 1)
        static let two = Champion(id: 2, name: "two", gender: .female, position: [], species: [], resource: .manaless, rangeType: .ranged, region: [], releaseYear: 2)
    }
}
