//
//  ChallengeCompletionManagerTests.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

@testable import LoLdle
import XCTest
import Foundation

final class ChallengeCompletionManagerTests: XCTestCase {
    func testIfTodaysChallengeCompletedWhenCompleted2DaysAgo() {
        // Given:
        let date = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let repository = ChallengesRepositoryMock(date: date, shouldReturnData: true)
        let manager = ChallengeCompletionManager(repository: repository)
        
        // When:
        let isCompleted = manager.isTodaysChallengeCompleted(.champion)
        
        // Then:
        XCTAssertFalse(isCompleted)
    }
    
    func testIfTodaysChallengeCompletedWhenCompletedToday() {
        // Given:
        var components = Calendar.current.dateComponents(Set([.year, .month, .day]), from: Date())
        components.hour = 12
        components.minute = 00
        let date = Calendar.current.date(from: components)!
        let repository = ChallengesRepositoryMock(date: date, shouldReturnData: true)
        let manager = ChallengeCompletionManager(repository: repository)
        
        // When:
        let isCompleted = manager.isTodaysChallengeCompleted(.champion)
        
        // Then:
        XCTAssert(isCompleted)
    }
    
    func testIfTodaysChallengeCompletedWhenCompletedTodayAfterReset() {
        // Given:
        var components = Calendar.current.dateComponents(Set([.year, .month, .day]), from: Date())
        components.hour = 23
        components.minute = 00
        let date = Calendar.current.date(from: components)!
        let repository = ChallengesRepositoryMock(date: date, shouldReturnData: true)
        let manager = ChallengeCompletionManager(repository: repository)
        
        // When:
        let isCompleted = manager.isTodaysChallengeCompleted(.champion)
        
        // Then:
        XCTAssertFalse(isCompleted)
    }
    
    func testIfTodaysChallengeCompletedWhenNoSavedInfo() {
        // Given:
        let repository = ChallengesRepositoryMock(date: Date(), shouldReturnData: false)
        let manager = ChallengeCompletionManager(repository: repository)
        
        // When:
        let isCompleted = manager.isTodaysChallengeCompleted(.champion)
        
        // Then:
        XCTAssertFalse(isCompleted)
    }
    
    func testGettingLastNumberOfGuesses() {
        // Given:
        let repository = ChallengesRepositoryMock(date: Date(), shouldReturnData: true)
        let manager = ChallengeCompletionManager(repository: repository)
        
        // When:
        let numberOfGuesses = manager.lastNumberOfGuesses(forChallenge: .champion)
        
        // Then:
        XCTAssertEqual(numberOfGuesses, 1)
        
    }
    
    func testGettingChampionName() {
        // Given:
        let repository = ChallengesRepositoryMock(date: Date(), shouldReturnData: true)
        let manager = ChallengeCompletionManager(repository: repository)
        
        // When:
        let name = manager.lastChampionName(forChallenge: .champion)
        
        // Then:
        XCTAssertEqual(name, "one")
        
    }
    
    func testGettingChampionId() {
        // Given:
        let repository = ChallengesRepositoryMock(date: Date(), shouldReturnData: true)
        let manager = ChallengeCompletionManager(repository: repository)
        
        // When:
        let id = manager.lastChampionId(forChallenge: .champion)
        
        // Then:
        XCTAssertEqual(id, 1)
        
    }
    
    func testMarkingTodaysChallengeAsCompleted() {
        // Given:
        let repository = ChallengesRepositoryMock(date: Date(), shouldReturnData: true)
        let manager = ChallengeCompletionManager(repository: repository)
        let numberOfGuesses = 100
        let name = "test"
        let id = 999
        
        // When:
        manager.markTodaysChallengeAsCompleted(.champion, numberOfGuesses: numberOfGuesses, name: name, id: id)
        
        // Then:
        XCTAssert(repository.wasSaveCompletionInfoCalled)
        XCTAssertEqual(repository.infoToSave[CompletedChallengeInfo.UserDefaultsKeys.numberOfGuesses] as! Int, numberOfGuesses)
        XCTAssertEqual(repository.infoToSave[CompletedChallengeInfo.UserDefaultsKeys.name] as! String, name)
        XCTAssertEqual(repository.infoToSave[CompletedChallengeInfo.UserDefaultsKeys.id] as! Int, id)
    }
}
