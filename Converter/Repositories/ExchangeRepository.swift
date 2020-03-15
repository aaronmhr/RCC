//
//  ExchangeRepository.swift
//  Converter
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol ExchangeRepository {
    typealias Result = Swift.Result<[ExchangePair], RepositoryError>
    
    func getExchangeRates(for pairs: [Pair], completion: @escaping (Result) -> Void)
}

public enum RepositoryError: Error {
    case invalidURL
    case invalidData
    case connectivity
}
