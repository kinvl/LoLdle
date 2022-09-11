//
//  UseCaseMocks.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 27/10/2022.
//

@testable import LoLdle
import RxSwift

final class GetAllChampionsNamesUseCaseMock: GettingAllChampionsNamesUseCase {
    func execute() -> Single<[String]> {
        .just(["test1", "test2"])
    }
}

final class GetChallengeSecretUseCaseMock: GettingChallengeSecretUseCase {
    func execute(forChallengeType type: ChallengeType) -> Single<Champion?> {
        .just(Fake.Champions.one)
    }
}

final class GetRemoteDataCountUseCaseMock: GettingRemoteDataCountUseCase {
    var wasExecuteCalled = false
    let championCount: Int
    
    init(championCount: Int) {
        self.championCount = championCount
    }
    
    func execute() -> Single<[String : Int]> {
        wasExecuteCalled = true
        return .just(["champions": championCount])
    }
}

final class GetLocalDataCountUseCaseMock: GettingLocalDataCountUseCase {
    var wasExecuteCalled = false
    let championCount: Int
    let iconCount: Int
    
    init(championCount: Int, iconCount: Int) {
        self.championCount = championCount
        self.iconCount = iconCount
    }
    
    func execute() -> Single<[String : Int]> {
        wasExecuteCalled = true
        return .just(["champions": championCount, "icons": iconCount])
    }
}

final class DownloadhampionsDataUseCaseMock: DownloadingChampionsDataUseCase {
    var wasExecuteCalled = false
    func execute() -> Completable {
        wasExecuteCalled = true
        return .empty()
    }
}
