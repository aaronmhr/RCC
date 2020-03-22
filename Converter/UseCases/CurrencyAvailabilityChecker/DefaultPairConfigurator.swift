//
//  DefaultPairConfigurator.swift
//  Converter
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public final class DefaultPairConfigurator: PairConfigurator {
    private let selectedCurrency: Currency
    private var pairUseCase: PairInteractorProtocol
    
    public init(selectedCurrency: Currency, pairUseCase: PairInteractorProtocol) {
        self.selectedCurrency = selectedCurrency
        self.pairUseCase = pairUseCase
    }
    
    public func nonPairingAvailable(within currencies: [Currency]) -> [(currency: Currency, isVisible: Bool)] {
        let unavailableCurrencies = configuredPairs.filter { $0.first == selectedCurrency }.map { $0.second } + [selectedCurrency]
        return currencies.map { (currency: $0, isVisible: !unavailableCurrencies.contains($0)) }
    }
    
    public func savePairWith(_ currency: Currency) {
        let pair = Pair(with: selectedCurrency, and: currency)
        pairUseCase.save(pair)
    }
    
    private var configuredPairs: [Pair] {
        return pairUseCase.getConfiguredPairs()
    }
}
