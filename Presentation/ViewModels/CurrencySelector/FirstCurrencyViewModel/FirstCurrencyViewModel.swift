//
//  FirstCurrencyViewModel.swift
//  Presentation
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class FirstCurrencyViewModel {
    private let currencyProvider: CurrencyProvider
    private let currencyAvailabilityChecker: CurrencyAvailabilityChecker
    public private(set) var currencies: Box<[CurrencyView]> = Box([])
    
    init(currencyProvider: CurrencyProvider, currencyAvailabilityChecker: CurrencyAvailabilityChecker) {
        self.currencyProvider = currencyProvider
        self.currencyAvailabilityChecker = currencyAvailabilityChecker
    }
}

extension FirstCurrencyViewModel: CurrenciesViewModel {
    public func startLoaddingCurrencies() {
        let all = currencyProvider.getCurrencies()
        let models = all.map { CurrencyView.make(from: $0, isActive: true) }
        currencies.value = models
    }
    
    public func didSelectCurrencyAtIndex(_ index: Int) {
        
    }
}
