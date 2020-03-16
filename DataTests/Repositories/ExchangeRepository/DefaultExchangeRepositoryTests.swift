//
//  DefaultExchangeRepositoryTests.swift
//  Data
//
//  Created by Aaron Huánuco on 16/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import Converter
@testable import Data

final class DefaultExchangeRepositoryTests: XCTestCase {
    func testGetExchangePairs_onConnectivityErrorFromRemoteDatasource_returnsRemoteRepositoryError() {

    }
}

private extension DefaultExchangeRepositoryTests {
    func makeSUT() -> (DefaultExchangeRepository, ExchangeRatesDataSourceSpy) {
        let dataSource = ExchangeRatesDataSourceSpy()
        let sut = DefaultExchangeRepository(dataSource: dataSource)
        return (sut, dataSource)
    }
}
    

private class ExchangeRatesDataSourceSpy {
    typealias Result = ExchangeRatesDataSource.Result
    private var message: (pairs: [Pair], completion: (Result) -> Void)?
    
    func complete(with error: DatasourceError) {
        message?.completion(.failure(error))
    }
    
    func complete(with pair: [ExchangePair]) {
        message?.completion(.success(pair))
    }
}

extension ExchangeRatesDataSourceSpy: ExchangeRatesDataSource {
    func getRates(for pairs: [Pair], completion: @escaping (Result) -> Void) {
        message = (pairs, completion)
    }
}
