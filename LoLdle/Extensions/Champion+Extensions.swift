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
    
    func compareAgainst(_ champion: Champion) -> ChampionAnswer {
        return ChampionAnswer(name: self.name =?= champion.name,
                              gender: self.gender =?= champion.gender,
                              position: self.position =?= champion.position,
                              species: self.species =?= champion.species,
                              resource: self.resource =?= champion.resource,
                              rangeType: self.rangeType =?= champion.rangeType,
                              region: self.region =?= champion.region,
                              releaseYear: self.releaseYear =?= champion.releaseYear)
    }
}
