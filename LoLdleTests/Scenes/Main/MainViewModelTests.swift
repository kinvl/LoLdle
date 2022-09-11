//
//  MainViewModelTests.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 28/10/2022.
//

@testable import LoLdle
import XCTest

final class MainViewModelTests: XCTestCase {
    func testCheckingDataCompatibilityWhenCompatible() {
        // Given:
        let getRemoteDataCountUseCase = GetRemoteDataCountUseCaseMock(championCount: 1)
        let getLocalDataCountUseCase = GetLocalDataCountUseCaseMock(championCount: 1, iconCount: 1)
        let downloadChampionsDataUseCase = DownloadhampionsDataUseCaseMock()
        let viewModel = MainViewModel(getRemoteDataCountUseCase: getRemoteDataCountUseCase, getLocalDataCountUseCase: getLocalDataCountUseCase, downloadChampionsDataUseCase: downloadChampionsDataUseCase)
        
        // When:
        switch viewModel.checkDataCompatibility().toBlocking().materialize() {
        case .completed(_):
            XCTAssert(true)
        case .failed(_, _):
            XCTFail()
        }
        
        // Then:
        XCTAssert(getRemoteDataCountUseCase.wasExecuteCalled)
        XCTAssert(getLocalDataCountUseCase.wasExecuteCalled)
    }
    
    func testCheckingDataCompatibilityWhenIncompatible() {
        // Given:
        let getRemoteDataCountUseCase = GetRemoteDataCountUseCaseMock(championCount: 2)
        let getLocalDataCountUseCase = GetLocalDataCountUseCaseMock(championCount: 1, iconCount: 1)
        let downloadChampionsDataUseCase = DownloadhampionsDataUseCaseMock()
        let viewModel = MainViewModel(getRemoteDataCountUseCase: getRemoteDataCountUseCase, getLocalDataCountUseCase: getLocalDataCountUseCase, downloadChampionsDataUseCase: downloadChampionsDataUseCase)
        
        // When:
        switch viewModel.checkDataCompatibility().toBlocking().materialize() {
        case .completed(_):
            XCTAssert(true)
        case .failed(_, _):
            XCTFail()
        }
        
        // Then:
        XCTAssert(downloadChampionsDataUseCase.wasExecuteCalled)
    }
}
