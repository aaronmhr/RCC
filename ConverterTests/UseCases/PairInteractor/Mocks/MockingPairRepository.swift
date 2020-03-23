//
//  MockingPairRepository.swift
//  ConverterTests
//
//  Created by Aaron Huánuco on 23/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

class MockingPairRepository: PairRepository {
    private var reversedPair: [Pair] = []
    private var pairsStack: [Pair] {
        return reversedPair.reversed()
    }
    
    func save(_ pair: Pair, completion: @escaping (SaveResult) -> Void) {
        reversedPair.append(pair)
        completion(SaveResult.success(Void()))
    }
    
    func fetch(completion: @escaping (FetchResult) -> Void) {
        completion(.success(pairsStack))
    }
}
