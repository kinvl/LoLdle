//
//  ChallengeMocks.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 27/10/2022.
//

@testable import LoLdle
import RxSwift
import RxCocoa

final class ChallengeViewModelMock: ChallengeViewModeling {
    var wasPrepareCalled = false
    
    var suggestions: Driver<[String]> = .just([]).asDriver()
    var guesses: [ChampionCellItemModel] = []
    var isTodaysAlreadyChallengeCompleted: Bool = false
    var completedChallengeInfo: CompletedChallengeInfo? = nil
    
    func isAnswerCorrect(_ name: String) -> Bool {
        return false
    }
    
    func prepare() -> Single<[String]> {
        wasPrepareCalled = true
        return .just(["test1", "test2"])
    }
}
