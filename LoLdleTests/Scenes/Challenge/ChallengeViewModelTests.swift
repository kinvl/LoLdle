//
//  ChallengeViewModelTests.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 27/10/2022.
//

@testable import LoLdle
import XCTest
import RxSwift
import RxBlocking

final class ChallengeViewModelTests: XCTestCase {
    func testPreparingViewModel() {
        // Given:
        let viewModel = makeViewModel()
        
        // When:
        switch viewModel.prepare().toBlocking().materialize() {
        case .completed(_):
            XCTAssert(true)
        case .failed(_, _):
            XCTFail()
        }
        
        // Then:
        let suggestions = try! viewModel.suggestions.toBlocking().first()!
        XCTAssertFalse(suggestions.isEmpty)
    }
    
    func testCheckingCorrectAnswer() {
        // Given:
        let viewModel = makeViewModel()
        let answer = "one"
        
        // When:
        _ = viewModel.prepare().toBlocking().materialize()
        let isCorrect = viewModel.isAnswerCorrect(answer)
        
        // Then:
        XCTAssert(isCorrect)
    }
    
    func testCheckingIncorrectAnswer() {
        // Given:
        let viewModel = makeViewModel()
        let answer = "two"
        
        // When:
        _ = viewModel.prepare().toBlocking().materialize()
        let isCorrect = viewModel.isAnswerCorrect(answer)
        
        // Then:
        XCTAssertFalse(isCorrect)
        
    }
    
    func testSuggestionIsRemovedWhenCheckingAnswer() {
        // Given:
        let viewModel = makeViewModel()
        let answer = "test1"
        
        // When:
        _ = viewModel.prepare().toBlocking().materialize()
        _ = viewModel.isAnswerCorrect(answer)
        
        // Then:
        let suggestions = try! viewModel.suggestions.toBlocking().first()!
        XCTAssertFalse(suggestions.isEmpty)
        XCTAssertFalse(suggestions.contains(answer))
    }
    
    func testGettingCompletedChallengeInfoFromGuesses() {
        // Given:
        let viewModel = makeViewModel()
        let answer = "one"
        
        // When:
        _ = viewModel.prepare().toBlocking().materialize()
        _ = viewModel.isAnswerCorrect(answer)
        let info = viewModel.completedChallengeInfo
        
        // Then:
        XCTAssertNotNil(info)
        XCTAssertEqual(info!.numberOfGuesses, 1)
        XCTAssertEqual(info!.name, "one")
    }
    
    func testGettingCompletedChallengeInfoFromManager() {
        // Given:
        let viewModel = makeViewModel()
        
        // When:
        let info = viewModel.completedChallengeInfo
        
        // Then:
        XCTAssertNotNil(info)
        XCTAssertEqual(info!.numberOfGuesses, 100)
        XCTAssertEqual(info!.name, "three")
    }
    
    func testGettingCompletedChallengeWhenNoGuessesOrSavedChallenges() {
        // Given:
        let viewModel = makeViewModel(returnErrors: true)
        
        // When:
        let info = viewModel.completedChallengeInfo
        
        // Then:
        XCTAssertNil(info)
    }
    
    
    /// Returns `ChallengeViewModel` initialized with mock objects.
    ///
    /// Default values from mocks:
    /// - challengeSecret: `Fake.Champions.one`
    /// - suggestions: `["test1", "test2"]`
    private func makeViewModel(returnErrors: Bool = false) -> ChallengeViewModel {
        let getAllChampionsNamesUseCase = GetAllChampionsNamesUseCaseMock()
        let getChampionUseCase = GetChampionUseCaseMock()
        let getChallengeSecretUseCase = GetChallengeSecretUseCaseMock()
        let getChampionIconUseCase = GetChampionIconUseCaseMock()
        let challengeCompletionManager = ChallengeCompletionManagerMock(returnErrors: returnErrors)
        
        return ChallengeViewModel(challengeType: .champion, getAllChampionsNamesUseCase: getAllChampionsNamesUseCase, getChampionUseCase: getChampionUseCase, getChallengeSecretUseCase: getChallengeSecretUseCase, getChampionIconUseCase: getChampionIconUseCase, challengeCompletionManager: challengeCompletionManager)
    }
}
