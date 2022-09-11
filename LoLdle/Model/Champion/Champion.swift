//
//  Champion.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

import Foundation

struct Champion: Codable {
    let id: Int
    let name: String
    let gender: Gender
    let position: [Position]
    let species: [Species]
    let resource: Resource
    let rangeType: RangeType
    let region: [Region]
    let releaseYear: Int
}
