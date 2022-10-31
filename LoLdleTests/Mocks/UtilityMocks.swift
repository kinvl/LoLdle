//
//  UtilityMocks.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

@testable import LoLdle
import Foundation

final class ChallengeCompletionManagerMock: ChallengeCompletionManaging {
    private let returnErrors: Bool
    var todays10PM: Date = Date()
    
    init(returnErrors: Bool) {
        self.returnErrors = returnErrors
    }
    
    func lastNumberOfGuesses(forChallenge type: ChallengeType) -> Int? {
        return returnErrors ? nil : 100
    }
    
    func lastChampionName(forChallenge type: ChallengeType) -> String? {
        return returnErrors ? nil : "three"
    }
    
    func lastChampionId(forChallenge type: ChallengeType) -> Int? {
        return returnErrors ? nil : 999
    }
    
    func isTodaysChallengeCompleted(_ type: ChallengeType) -> Bool {
        return !returnErrors
    }
    
    func markTodaysChallengeAsCompleted(_ type: ChallengeType, numberOfGuesses: Int, name: String, id: Int) {}
}
