//
//  MainMocks.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 16/10/2022.
//

@testable import LoLdle
import UIKit
import RxSwift

final class MainViewModelMock: MainViewModeling {
    func checkDataCompatibility() -> Completable {
        .empty()
    }
}

final class MainRouterMock: MainRouting {
    var wasPresentChampionChallengeCalled = false
    var waspresentAboutCalled = false
    
    func presentChampionChallenge(from parent: UINavigationController?) {
        wasPresentChampionChallengeCalled = true
    }
    
    func presentAbout(from parent: UIViewController?) {
        waspresentAboutCalled = true
    }
}
