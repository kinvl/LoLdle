//
//  RepositoryMocks.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 27/10/2022.
//

@testable import LoLdle
import Foundation
import UIKit
import RxSwift

final class ChampionsRepositoryMock: ChampionsRepository {
    func saveChampions(_ champions: [Champion]) -> Completable {
        .empty()
    }
    
    func saveChampionIcon(url: URL, fileName: String) -> Completable {
        .empty()
    }
    
    func getChampion(named name: String) -> Single<Champion?> {
        .just(name == "one" ? Fake.Champions.one : Fake.Champions.two)
    }
    
    func getAllChampions() -> Single<[Champion]> {
        .just([Fake.Champions.one, Fake.Champions.two])
    }
    
    func getAllChampionsNames() -> Single<[String]> {
        .just([])
    }
    
    func getChampionsIconCount() -> Single<Int> {
        .just(0)
    }
    
    func getChampionIcon(id: Int) -> Single<UIImage?> {
        .just(UIImage())
    }
    
    
}

