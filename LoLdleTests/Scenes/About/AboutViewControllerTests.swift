//
//  AboutViewControllerTests.swift
//  LoLdleTests
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

@testable import LoLdle
import XCTest

final class AboutViewControllerTests: XCTestCase {
    func testInitWithCoder() {
        // Given:
        let coder = NSCoder()
        
        // When:
        let viewController = AboutViewController(coder: coder)
        
        // Then:
        XCTAssertNil(viewController)
    }
}
