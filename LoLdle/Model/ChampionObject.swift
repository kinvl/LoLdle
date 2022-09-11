//
//  ChampionObject.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//
import Foundation
import RealmSwift

final class ChampionObject: Object {
    @Persisted var id: Int
    @Persisted(primaryKey: true) var name: String
    @Persisted var gender: Gender
    @Persisted var position: List<Position>
    @Persisted var species: List<Species>
    @Persisted var resource: Resource
    @Persisted var rangeType: RangeType
    @Persisted var region: List<Region>
    @Persisted var releaseYear: Int
    
    convenience init(id: Int, name: String, gender: Gender, position: [Position], species: [Species], resource: Resource, rangeType: RangeType, region: [Region], releaseYear: Int) {
        self.init()
        self.id = id
        self.name = name
        self.gender = gender
        let positionList = List<Position>()
        positionList.append(objectsIn: position)
        self.position = positionList
        let speciesList = List<Species>()
        speciesList.append(objectsIn: species)
        self.species = speciesList
        self.resource = resource
        self.rangeType = rangeType
        let regionList = List<Region>()
        regionList.append(objectsIn: region)
        self.region = regionList
        self.releaseYear = releaseYear
    }
}

extension ChampionObject {
    func mapToDomain() -> Champion {
        return Champion(id: self.id, name: self.name, gender: self.gender, position: Array(self.position), species: Array(self.species), resource: self.resource, rangeType: self.rangeType, region: Array(self.region), releaseYear: self.releaseYear)
    }
}
