//
//  RemoteExchangeRatesDataSourceTests.swift
//  DataTests
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import Converter
@testable import Data

class RemoteExchangeRatesDataSourceTests: XCTestCase {

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
    
    func test_getRates_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.connectivity), for: [Pair.euro_dollar], when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_getRates_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { tuple in
            let (index, code) = tuple
            expect(sut, toCompleteWith: .failure(.invalidData), for: [], when: {
                let json = try! JSONSerialization.data(withJSONObject: ["EURUSD": 1.0])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_getRates_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.invalidData), for: [], when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }
}

extension RemoteExchangeRatesDataSourceTests {
    private func makeSUT() -> (RemoteExchangeRatesDataSource, HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteExchangeRatesDataSource(remoteClient: client)
        return (sut, client)
    }
    
    private func expect(_ sut: RemoteExchangeRatesDataSource,
                        toCompleteWith expectedResult: RemoteExchangeRatesDataSource.Result,
                        for pairs: [Pair],
                        when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for getRates completion")
        
        sut.getRates(for: pairs) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedPairs), .success(expectedPairs)):
                assertDumpsEqual(receivedPairs, expectedPairs)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1.0)
    }
}


func assertDumpsEqual<T>(_ lhs: @autoclosure () -> T, _ rhs: @autoclosure () -> T, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(String(dumping: lhs()), String(dumping: rhs()), "Expected dumps to be equal.", file: file, line: line)
}

extension String {
    init<T>(dumping x: T) {
        self.init()
        dump(x, to: &self)
    }
}
