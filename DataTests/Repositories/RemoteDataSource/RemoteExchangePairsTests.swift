//
//  RemoteExchangePairsTests.swift
//  DataTests
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import Converter
@testable import Data

class RemoteExchangePairsTests: XCTestCase {
    
    func testOne() {
        let client = URLSessionHTTPClient()
        let exp = expectation(description: "asd")
        let sut = RemoteExchangePairs(remoteClient: client)
        sut.getRates(for: [Testing.poundDollar, Testing.poundEuro, Testing.dollarEuro]) { result in
            dump(result)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
}

enum Testing {
    static let pairs = ["GBP", "USD", "EUR"].compactMap { Currency.Builder.build(from: $0) }
    static let poundDollar = Pair(with: pairs[0], and: pairs[1])
    static let poundEuro = Pair(with: pairs[0], and: pairs[2])
    static let dollarEuro = Pair(with: pairs[1], and: pairs[2])
}
