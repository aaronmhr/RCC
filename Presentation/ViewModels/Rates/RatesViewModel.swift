//
//  RatesViewModel.swift
//  Presentation
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class RatesViewModel {
    private let pairUseCase: PairInteractorProtocol
    private let exchangePairProvider: ExchangePairProvider
    public var router: RatesRouterProtocol?
    
    public init(pairUseCase: PairInteractorProtocol, exchangePairProvider: ExchangePairProvider) {
        self.pairUseCase = pairUseCase
        self.exchangePairProvider = exchangePairProvider
    }
    
    public private(set) var pairs: Box<[ExchangePairView]> = Box([])
    
    func retrieve() {
        let pairs = pairUseCase.getConfiguredPairs()
        exchangePairProvider.getExchangePairs(for: pairs, at: Constants.defaultInterval) { result in
            switch result {
            case .success(let pairs):
                self.pairs.value = pairs.map(ExchangePairViewFormatter.make)
            case .failure: break
            }
        }
    }
    
    public func startFetchingExchangeRates() {
        let pairs = pairUseCase.getConfiguredPairs()
        exchangePairProvider.getExchangePairs(for: pairs, at: Constants.defaultInterval) { result in
            switch result {
            case .success(let pairs):
                self.pairs.value = pairs.map(ExchangePairViewFormatter.make)
            case .failure: break
            }
        }
    }
    
    public func stopFetchingExchangeRates() {
        exchangePairProvider.stopRetreavingPairs()
    }
    
    public func addPairDidTapp() {
        router?.showAddCurrencyScreen()
    }
    
    private enum Constants {
        static let defaultInterval: TimeInterval = 2.0
    }
}

final class ExchangePairViewFormatter {
    static func make(_ exchange: ExchangePair) -> ExchangePairView {
        let origin = OriginCurrencyView(
            title: "1 \(exchange.pair.first.code)",
            subtitle: exchange.pair.first.name
        )
        let rate = exchange.rate.toString(decimalDigits: 4) ?? "0.0000"
        let destination = DestinationCurrencyView(
            title: rate,
            subtitle: "\(exchange.pair.second.name) · \(exchange.pair.second.code)"
        )
        return ExchangePairView(origin: origin, destination: destination)
    }
    
    private static func format(_ string: String) -> String {
        let firstDigits = string.dropLast(2)
        let lastDigits = string.reversed().dropFirst(2)
        return String(firstDigits) + lastDigits
    }
}

public struct ExchangePairView {
    public let origin: OriginCurrencyView
    public let destination: DestinationCurrencyView
}

public struct OriginCurrencyView {
    public let title: String
    public let subtitle: String
}

public struct DestinationCurrencyView {
    public let title: String
    public let subtitle: String
}
