//
//  ChallengeViewModel.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 11/09/2022.
//

import RxSwift
import RxRelay
import RxCocoa

protocol ChallengeViewModeling {
    var suggestions: Driver<[String]> { get }
    var guesses: [ChampionCellItemModel] { get }
    func checkAnswer(_ name: String) -> Single<Bool>
    func prepare() -> Single<[String]>
}

final class ChallengeViewModel: ChallengeViewModeling {
    private let repository: ChampionsRepository
    private let getAllChampionsNamesUseCase: GettingAllChampionsNamesUseCase
    private let getChallengeSecretUseCase: GettingChallengeSecretUseCase
    
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
    
    // MARK: - Initialization
    init(challengeType: ChallengeType, getAllChampionsNamesUseCase: GettingAllChampionsNamesUseCase, repository: ChampionsRepository, getChallengeSecretUseCase: GettingChallengeSecretUseCase) {
        self.challengeType = challengeType
        self.getAllChampionsNamesUseCase = getAllChampionsNamesUseCase
        self.repository = repository
        self.getChallengeSecretUseCase = getChallengeSecretUseCase
    }
    
    // MARK: - ChallengeViewModeling
    func checkAnswer(_ name: String) -> Single<Bool> {
        removeSuggestion(name)
        
        return repository.getChampion(named: name).flatMap { [weak self] champion in
            guard let self = self, let champion = champion else { return .error(LoLdleError.databaseFailure) }
            
            return self.repository.getChampionIcon(id: champion.id)
                .do(onSuccess: { icon in
                    let answer = champion.isEqualTo(self.challengeSecret)
                    let guess = (answer: answer, champion: champion, icon: icon)
                    self._guesses.insert(guess, at: 0)
                })
                .map { _ in
                    return champion
                }
        }
        .map { [weak self] (champion: Champion) in
            self?.isAnswerValid(champion: champion) ?? false
        }
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
    
    private func isAnswerValid(champion: Champion) -> Bool {
        let answer = champion.isEqualTo(self.challengeSecret)
        return answer.name == .correct &&
        answer.gender == .correct &&
        answer.position == .correct &&
        answer.species == .correct &&
        answer.resource == .correct &&
        answer.rangeType == .correct &&
        answer.region == .correct &&
        answer.releaseYear == .correct
    }
}
