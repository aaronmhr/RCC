//
//  RatesAPITests.swift
//  DataTests
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
@testable import Data

class RatesAPITests: XCTestCase {
    
    func testRatesAPITestBuildTheRightURLForOnePair() {
        let sut = RatesAPI.pairs(["USDGBP"])
        let url = URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?pairs=USDGBP")!
        
        XCTAssertEqual(sut.url, url)
    }
    
    func testBuildsURLForMoreThanOnePair() {
        let sut = RatesAPI.pairs(["USDGBP", "USDEUR", "EURGBP"])
        let url = URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?pairs=USDGBP&pairs=USDEUR&pairs=EURGBP")!
        
        XCTAssertEqual(sut.url, url)
    }
}
