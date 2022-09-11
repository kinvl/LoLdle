//
//  Champion+Extensions.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 23/09/2022.
//

extension Champion {
    func mapToObject() -> ChampionObject {
        return ChampionObject(id: self.id, name: self.name, gender: self.gender, position: self.position, species: self.species, resource: self.resource, rangeType: self.rangeType, region: self.region, releaseYear: self.releaseYear)
    }
    
    func isEqualTo(_ aChampion: Champion) -> ChampionAnswer {
        return ChampionAnswer(name: self.name =?= aChampion.name,
                              gender: self.gender =?= aChampion.gender,
                              position: self.position =?= aChampion.position,
                              species: self.species =?= aChampion.species,
                              resource: self.resource =?= aChampion.resource,
                              rangeType: self.rangeType =?= aChampion.rangeType,
                              region: self.region =?= aChampion.region,
                              releaseYear: self.releaseYear =?= aChampion.releaseYear)
    }
}
