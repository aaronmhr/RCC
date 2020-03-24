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
    private var previouslyRetrievedPairs = 0
    
    public init(pairUseCase: PairInteractorProtocol, exchangePairProvider: ExchangePairProvider) {
        self.pairUseCase = pairUseCase
        self.exchangePairProvider = exchangePairProvider
    }
    
    public private(set) var pairs: Box<[ExchangePairView]> = Box([])
    public private(set) var newPair: Box<ExchangePairView?> = Box(nil)
    public private(set) var isEmptyScreen: Box<Bool> = Box(true) {
        willSet {
            guard isEmptyScreen.value else { return }
            stopFetchingExchangeRates()
        }
    }
    
    public func startFetchingExchangeRates() {
        pairUseCase.getConfiguredPairs { [weak self] result in
            switch result {
            case .success(let pairs):
                self?.fetchRates(for: pairs, at: Constants.defaultInterval)
            case .failure(let error): break
            }
        }
    }
    
    private func fetchRates(for pairs: [Pair], at interval: TimeInterval) {
        exchangePairProvider.getExchangePairs(for: pairs, at: interval) { [weak self] result in
            switch result {
            case .success(let exchangePairs):
                exchangePairs.isEmpty ? self?.setEmpty() : self?.setCongiguredPairs()
                self?.configure(with: exchangePairs.map(ExchangePairViewFormatter.make))
            case .failure:
                break
            }
        }
    }
    
    private func configure(with viewPairs: [ExchangePairView]) {
        if viewPairs.count == (previouslyRetrievedPairs + 1) {
            pairs.value = Array(viewPairs.dropFirst())
            newPair.value = viewPairs.first
        } else {
            pairs.value = viewPairs
        }
        previouslyRetrievedPairs = viewPairs.count
    }
    
    private func setEmpty() {
        stopFetchingExchangeRates()
        isEmptyScreen.value = true
    }
    
    private func setCongiguredPairs() {
        guard isEmptyScreen.value else { return }
        isEmptyScreen.value = false
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
