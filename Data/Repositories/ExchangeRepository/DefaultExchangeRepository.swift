//
//  DefaultExchangeRepository.swift
//  Data
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

//final class DefaultExchangeRepository: ExchangeRepository {
//    private let remoteClient: HTTPClient
//
//    public init(remoteClient: HTTPClient) {
//        self.remoteClient = remoteClient
//    }
//
//    func getExchangeRates(for pairs: [Pair], completion: @escaping (ExchangeRepository.Result) -> Void) {
//        guard let url = RatesAPI.pairs(["GBPEUR"]).url else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        remoteClient.get(from: url) { result in
//            switch result {
//            case .success(let data, let response):
//                break
//            case .failure(let error)
//                break
//            }
//        }
//    }
//}
