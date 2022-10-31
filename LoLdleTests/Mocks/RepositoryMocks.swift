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
    
    func getChampion(named name: String) -> Champion? {
        name == "one" ? Fake.Champions.one : Fake.Champions.two
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
    
    func getChampionIcon(id: Int?) throws -> UIImage? {
        UIImage()
    }
}

final class ChallengesRepositoryMock: ChallengesRepository {
    var infoToSave: [String: Any] = [:]
    var wasSaveCompletionInfoCalled = false
    
    private let date: Date
    private let shouldReturnData: Bool
    
    init(date: Date, shouldReturnData: Bool) {
        self.date = date
        self.shouldReturnData = shouldReturnData
    }
    
    func lastCompletedChallengeInfoDictionary(type: ChallengeType) -> [AnyHashable : Any]? {
        let completionInfo: [String: Any] = [
            CompletedChallengeInfo.UserDefaultsKeys.numberOfGuesses: 1,
            CompletedChallengeInfo.UserDefaultsKeys.name: "one",
            CompletedChallengeInfo.UserDefaultsKeys.id: 1,
            CompletedChallengeInfo.UserDefaultsKeys.completionDate: date
        ]
        
        return shouldReturnData ? completionInfo : nil
    }
    
    func saveCompletionInfo(_ info: [String : Any], forType type: ChallengeType) {
        wasSaveCompletionInfoCalled = true
        infoToSave = info
    }
}
