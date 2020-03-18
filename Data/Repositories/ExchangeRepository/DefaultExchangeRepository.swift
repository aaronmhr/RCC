//
//  DefaultExchangeRepository.swift
//  Data
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class DefaultExchangeRepository: ExchangeRepository {
    private let dataSource: ExchangeRatesDataSource

    public init(dataSource: ExchangeRatesDataSource) {
        self.dataSource = dataSource
    }

    public func getExchangePairs(for pairs: [Pair], completion: @escaping (ExchangeRepository.Result) -> Void) {
        dataSource.getRates(for: pairs) { result in
            let newResult = result
                .mapError { _ -> RepositoryError in
                    return .remote
            }
            completion(newResult)
        }
    }
}
