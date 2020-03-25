//
//  RCCTests.swift
//  RCCTests
//
//  Created by Aaron Huánuco on 14/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import RCC

final class AddPairViewTests: XCTestCase {

    func testFullScreenEmptyDispositionOfAddPairView() {
        let sut = AddPairView(frame: UIScreen.main.bounds)
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testFullScreenConfiguredDispositionOfAddPairView() {
        let sut = AddPairView(frame: UIScreen.main.bounds)
        sut.state = .configured
        
        assertSnapshot(matching: sut, as: .image)
    }
}
