//
//  ExchangePairProvider.swift
//  Converter
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

public protocol ExchangePairProvider {
    typealias Result = Swift.Result<[ExchangePair], ExchangeProviderError>
    
    func getExchangePairs(for pairs: [Pair], at interval: TimeInterval, completion: @escaping (ExchangePairProvider.Result) -> Void)
    func stopRetreavingPairs()
}

public enum ExchangeProviderError: Error {
    case remote
}
