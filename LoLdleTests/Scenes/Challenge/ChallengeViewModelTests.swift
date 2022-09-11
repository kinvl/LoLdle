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

class ChallengeViewModelTests: XCTestCase {
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
        let isCorrect = try! viewModel.checkAnswer(answer).toBlocking().first()!
        
        // Then:
        XCTAssert(isCorrect)
    }
    
    func testCheckingIncorrectAnswer() {
        // Given:
        let viewModel = makeViewModel()
        let answer = "two"
        
        // When:
        _ = viewModel.prepare().toBlocking().materialize()
        let isCorrect = try! viewModel.checkAnswer(answer).toBlocking().first()!
        
        // Then:
        XCTAssertFalse(isCorrect)
        
    }
    
    func testSuggestionIsRemovedWhenCheckingAnswer() {
        // Given:
        let viewModel = makeViewModel()
        let answer = "test1"
        
        // When:
        _ = viewModel.prepare().toBlocking().materialize()
        _ = viewModel.checkAnswer(answer).toBlocking().materialize()
        
        // Then:
        let suggestions = try! viewModel.suggestions.toBlocking().first()!
        XCTAssertFalse(suggestions.isEmpty)
        XCTAssertFalse(suggestions.contains(answer))
    }
    
    
    /// Returns `ChallengeViewModel` initialized with mock objects.
    ///
    /// Default values from mocks:
    /// - challengeSecret: `Fake.Champions.one`
    /// - suggestions: `["test1", "test2"]`
    private func makeViewModel() -> ChallengeViewModel {
        let getAllChampionsNamesUseCase = GetAllChampionsNamesUseCaseMock()
        let repository = ChampionsRepositoryMock()
        let getChallengeSecretUseCase = GetChallengeSecretUseCaseMock()
        
        return ChallengeViewModel(challengeType: .champion, getAllChampionsNamesUseCase: getAllChampionsNamesUseCase, repository: repository, getChallengeSecretUseCase: getChallengeSecretUseCase)
    }
}
