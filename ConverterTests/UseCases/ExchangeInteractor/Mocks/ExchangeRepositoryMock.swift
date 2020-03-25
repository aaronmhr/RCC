//
//  ExchangeRepositoryMock.swift
//  ConverterTests
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

class ExchangeRepositoryMock: ExchangeRepository {
    var stub: ExchangeRepository.Result!
    var receivedPairs: [Pair]!
    
    func stub(_ stub: ExchangeRepository.Result) {
        self.stub = stub
    }
    
    func getExchangePairs(for pairs: [Pair], completion: @escaping (ExchangeRepository.Result) -> Void) {
        receivedPairs = pairs
        completion(stub)
    }
}
