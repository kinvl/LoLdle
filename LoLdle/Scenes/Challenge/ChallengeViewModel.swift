//
//  ChallengeViewModel.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 11/09/2022.
//

import RxSwift
import RxRelay
import RxCocoa
import Foundation

protocol ChallengeViewModeling {
    var suggestions: Driver<[String]> { get }
    var guesses: [ChampionCellItemModel] { get }
    var isTodaysAlreadyChallengeCompleted: Bool { get }
    var completedChallengeInfo: CompletedChallengeInfo? { get }
    var resetDate: Date { get }
    func isAnswerCorrect(_ name: String) -> Bool
    func prepare() -> Single<[String]>
}

final class ChallengeViewModel: ChallengeViewModeling {
    private let getChampionUseCase: GettingChampionUseCase
    private let getAllChampionsNamesUseCase: GettingAllChampionsNamesUseCase
    private let getChallengeSecretUseCase: GettingChallengeSecretUseCase
    private let getChampionIconUseCase: GettingChampionIconUseCase
    private let challengeCompletionManager: ChallengeCompletionManaging
    
    private let challengeType: ChallengeType
    private var _suggestions: BehaviorRelay<[String]> = .init(value: [])
    private var _guesses: [ChampionCellItemModel] = []
    private var challengeSecret: Champion!
    
    var suggestions: Driver<[String]> {
        _suggestions.asDriver()
    }
    
    var guesses: [ChampionCellItemModel] {
        _guesses
    }
    
    var isTodaysAlreadyChallengeCompleted: Bool {
        challengeCompletionManager.isTodaysChallengeCompleted(challengeType)
    }
    
    var completedChallengeInfo: CompletedChallengeInfo? {
        if let guess = guesses.first {
            return CompletedChallengeInfo(numberOfGuesses: guesses.count, icon: guess.icon, name: guess.champion.name)
        }
        
        return lastCompletedChallengeInfo()
    }
    
    var resetDate: Date {
        challengeCompletionManager.resetDate
    }
    
    // MARK: - Initialization
    init(challengeType: ChallengeType, getAllChampionsNamesUseCase: GettingAllChampionsNamesUseCase, getChampionUseCase: GettingChampionUseCase, getChallengeSecretUseCase: GettingChallengeSecretUseCase, getChampionIconUseCase: GettingChampionIconUseCase, challengeCompletionManager: ChallengeCompletionManaging) {
        self.challengeType = challengeType
        self.getAllChampionsNamesUseCase = getAllChampionsNamesUseCase
        self.getChampionUseCase = getChampionUseCase
        self.getChallengeSecretUseCase = getChallengeSecretUseCase
        self.getChampionIconUseCase = getChampionIconUseCase
        self.challengeCompletionManager = challengeCompletionManager
    }
    
    // MARK: - ChallengeViewModeling
    func isAnswerCorrect(_ name: String) -> Bool {
        guard let champion = self.getChampionUseCase.execute(forName: name) else {
            return false
        }
        
        self.removeSuggestion(name)
        self.updateGuessesArray(champion: champion)
        
        let isCorrect = champion.compareAgainst(challengeSecret).isAnswerCorrect
        
        if let guess = guesses.first, isCorrect {
            self.challengeCompletionManager.markTodaysChallengeAsCompleted(challengeType, numberOfGuesses: guesses.count, name: guess.champion.name, id: guess.champion.id)
        }
        
        return isCorrect
    }
    
    func prepare() -> Single<[String]> {
        return getChallengeSecretUseCase.execute(forChallengeType: challengeType)
            .do { [weak self] secret in
                guard let self = self, let secret = secret else { throw LoLdleError.databaseFailure }
                self.challengeSecret = secret
            }
            .asCompletable()
            .andThen(getAllChampionsNamesUseCase.execute())
            .do { [weak self] suggestions in
                self?._suggestions.accept(suggestions)
            }
    }
    
    // MARK: - Private
    private func removeSuggestion(_ suggestion: String) {
        if let index = _suggestions.value.firstIndex(of: suggestion) {
            var mutableCopy = _suggestions.value
            mutableCopy.remove(at: index)
            _suggestions.accept(mutableCopy)
        }
    }
    
    private func updateGuessesArray(champion: Champion) {
        let answer = champion.compareAgainst(self.challengeSecret)
        let icon = getChampionIconUseCase.execute(forChampionId: champion.id)
        let guess = (answer: answer, champion: champion, icon: icon)
        self._guesses.insert(guess, at: 0)
    }
    
    private func lastCompletedChallengeInfo() -> CompletedChallengeInfo? {
        guard let numberOfGuesses = challengeCompletionManager.lastNumberOfGuesses(forChallenge: challengeType),
              let name = challengeCompletionManager.lastChampionName(forChallenge: challengeType),
              let id = challengeCompletionManager.lastChampionId(forChallenge: challengeType),
              let icon = getChampionIconUseCase.execute(forChampionId: id) else { return nil}
        
        return CompletedChallengeInfo(numberOfGuesses: numberOfGuesses, icon: icon, name: name)
    }
}
