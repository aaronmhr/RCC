//
//  CurrencyAvailabilityChecker.swift
//  Converter
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public final class DefaultCurrencyAvailabilityChecker: CurrencyAvailabilityChecker {
    private let selectedCurrency: Currency
    private let configuredPairs: [Pair]
    
    public init(selectedCurrency: Currency, configuredPairs: [Pair]) {
        self.selectedCurrency = selectedCurrency
        self.configuredPairs = configuredPairs
    }
    
    public func nonPairingAvailable(within currencies: [Currency]) -> [(currency: Currency, isVisible: Bool)] {
        let unavailableCurrencies = configuredPairs.filter { $0.first == selectedCurrency }.map { $0.second } + [selectedCurrency]
        return currencies.map { (currency: $0, isVisible: !unavailableCurrencies.contains($0)) }
    }
}
