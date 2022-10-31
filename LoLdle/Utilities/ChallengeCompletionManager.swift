//
//  ChallengeCompletionManager.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 30/10/2022.
//

import Foundation

protocol ChallengeCompletionManaging {
    func lastNumberOfGuesses(forChallenge type: ChallengeType) -> Int?
    func lastChampionName(forChallenge type: ChallengeType) -> String?
    func lastChampionId(forChallenge type: ChallengeType) -> Int?
    func isTodaysChallengeCompleted(_ type: ChallengeType) -> Bool
    func markTodaysChallengeAsCompleted(_ type: ChallengeType, numberOfGuesses: Int, name: String, id: Int)
}

final class ChallengeCompletionManager: ChallengeCompletionManaging {
    private let repository: ChallengesRepository
    
    // MARK: - Initialization
    init(repository: ChallengesRepository) {
        self.repository = repository
    }
    
    private var todays10PM: Date {
        var components = getComponents(.year, .month, .day)
        components.hour = 22
        components.minute = 00
        return Calendar.current.date(from: components)!
    }
    
    private var resetDate: Date {
        return Date() > todays10PM
        ? Calendar.current.date(byAdding: .day, value: 1, to: todays10PM)!
        : todays10PM
    }
    
    private var yesterdayResetDate: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: resetDate)!
    }
    
    // MARK: - ChallengeCompletionManaging
    func isTodaysChallengeCompleted(_ type: ChallengeType) -> Bool {
        if let dictionary = repository.lastCompletedChallengeInfoDictionary(type: type),
           let completionDate = dictionary[CompletedChallengeInfo.UserDefaultsKeys.completionDate] as? Date {
            
            return completionDate < yesterdayResetDate
                    ? false
                    : (min(yesterdayResetDate, resetDate) ... max(yesterdayResetDate, resetDate)).contains(completionDate)
        }
        
        return false
    }
    
    func markTodaysChallengeAsCompleted(_ type: ChallengeType, numberOfGuesses: Int, name: String, id: Int) {
        let completionInfo: [String: Any] = [
            CompletedChallengeInfo.UserDefaultsKeys.numberOfGuesses: numberOfGuesses,
            CompletedChallengeInfo.UserDefaultsKeys.name: name,
            CompletedChallengeInfo.UserDefaultsKeys.id: id,
            CompletedChallengeInfo.UserDefaultsKeys.completionDate: Date()
        ]
        
        repository.saveCompletionInfo(completionInfo, forType: type)
    }
    
    func lastNumberOfGuesses(forChallenge type: ChallengeType) -> Int? {
        if let dictionary = repository.lastCompletedChallengeInfoDictionary(type: type) {
            return dictionary[CompletedChallengeInfo.UserDefaultsKeys.numberOfGuesses] as? Int
        }
        
        return nil
    }
    
    func lastChampionName(forChallenge type: ChallengeType) -> String? {
        if let dictionary = repository.lastCompletedChallengeInfoDictionary(type: type) {
            return dictionary[CompletedChallengeInfo.UserDefaultsKeys.name] as? String
        }
        
        return nil
    }
    
    func lastChampionId(forChallenge type: ChallengeType) -> Int? {
        if let dictionary = repository.lastCompletedChallengeInfoDictionary(type: type) {
            return dictionary[CompletedChallengeInfo.UserDefaultsKeys.id] as? Int
        }
        
        return nil
    }
    
    // MARK: - Private
    private func getComponents(_ components: Calendar.Component...) -> DateComponents {
        return Calendar.current.dateComponents(Set(components), from: Date())
    }
}
