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

    func test_init_doesNotRequestDataFromUrl() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_getRates_requestsDataForThePair() {
        let pair = Pair.euro_pound
        let (sut, client) = makeSUT()
        
        sut.getRates(for: [pair]) { _ in }
        
        XCTAssertEqual(client.requestedURL?.query, "pairs=EURGBP")
    }
    
    func test_getRates_requestsDataForAllSentPairs() {
        let pair1 = Pair.euro_pound
        let pair2 = Pair.euro_dollar
        let pair3 = Pair.dollar_euro
        let (sut, client) = makeSUT()
        
        sut.getRates(for: [pair1, pair2, pair3]) { _ in }
        
        XCTAssertEqual(client.requestedURL?.query, "pairs=EURGBP&pairs=EURUSD&pairs=USDEUR")
    }
}

extension RemoteExchangePairsTests {
    private func makeSUT() -> (RemoteExchangePairs, HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteExchangePairs(remoteClient: client)
        return (sut, client)
    }
}
