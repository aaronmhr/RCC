//
//  RemoteExchangeRatesDataSource.swift
//  Data
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public protocol ExchangeRatesDataSource {
    typealias Result = Swift.Result<[ExchangePair], DatasourceError>
    
    func getRates(for pairs: [Pair], completion: @escaping (Result) -> Void)
}

public final class RemoteExchangeRatesDataSource: ExchangeRatesDataSource {
    typealias Rates = [String: Double]
    
    private let remoteClient: HTTPClient
    
    public init(remoteClient: HTTPClient) {
        self.remoteClient = remoteClient
    }
    
    public func getRates(for pairs: [Pair], completion: @escaping (ExchangeRatesDataSource.Result) -> Void) {
        let codes = pairs.map { $0.rateCode }
        guard let url = RatesAPI.pairs(codes).url else {
            completion(.failure(.invalidURL))
            return
        }
        remoteClient.get(from: url) { result in
            switch result {
            case .success(let data, let response):
                guard let rates = RemoteExchangeRatesDataSource.map(data, response: response) else {
                    completion(.failure(.invalidData))
                    return
                }
                let exchangePairs = pairs.compactMap { ExchangePair.Builder.build(pair: $0, rates: rates) }
                completion(.success(exchangePairs))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, response: HTTPURLResponse) -> Rates? {
        return try? RatesMapper.map(data, from: response)
    }
}

public enum DatasourceError: Error {
    case connectivity
    case invalidURL
    case invalidData
    case other
}

typealias Rates = [String: Double]

final class RatesMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [String: Double] {
        guard response.isOK,
            let exchangeRate = try? JSONDecoder().decode([String: Double].self, from: data) else {
                throw DatasourceError.invalidData
        }
        return exchangeRate
    }
}

extension Pair {
    fileprivate var rateCode: String {
        return first.code + second.code
    }
}

extension ExchangePair {
    fileprivate enum Builder {
        static func build(pair: Pair, rates: Rates) -> ExchangePair? {
            guard let rate = rates[pair.rateCode] else { return nil }
            return ExchangePair(pair: pair, rate: rate)
        }
    }
}
