//
//  ChallengeViewControllerTests.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 27/10/2022.
//

@testable import LoLdle
import XCTest

class ChallengeViewControllerTests: XCTestCase {
    func testInitWithCoder() {
        // Given:
        let coder = NSCoder()
        
        // When:
        let viewController = ChallengeViewController(coder: coder)
        
        // Then:
        XCTAssertNil(viewController)
    }
    
    func testPreparingViewModel() {
        // Given:
        let viewModel = ChallengeViewModelMock()
        let viewController = ChallengeViewController(viewModel: viewModel)
        
        // When:
        viewController.viewDidLoad()
        
        // Then:
        XCTAssert(viewModel.wasPrepareCalled)
    }
}
