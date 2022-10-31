//
//  MainViewControllerTests.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 16/10/2022.
//

@testable import LoLdle
import XCTest

final class MainViewControllerTests: XCTestCase {
    func testInitWithCoder() {
        // Given:
        let coder = NSCoder()
        
        // When:
        let viewController = MainViewController(coder: coder)
        
        // Then:
        XCTAssertNil(viewController)
    }
    
    func testNavigatingToChallenge() {
        // Given:
        let viewModel = MainViewModelMock()
        let router = MainRouterMock()
        let viewController = MainViewController(viewModel: viewModel, router: router)
        
        // When:
        viewController.castView.championChallengeButton.sendActions(for: .touchUpInside)
        
        // Then:
        XCTAssertTrue(router.wasPresentChampionChallengeCalled)
    }
    
    func testNavigatingToAbout() {
        // Given:
        let viewModel = MainViewModelMock()
        let router = MainRouterMock()
        let viewController = MainViewController(viewModel: viewModel, router: router)
        
        // When:
        viewController.castView.aboutButton.sendActions(for: .touchUpInside)
        
        // Then:
        XCTAssertTrue(router.waspresentAboutCalled)
    }
}
