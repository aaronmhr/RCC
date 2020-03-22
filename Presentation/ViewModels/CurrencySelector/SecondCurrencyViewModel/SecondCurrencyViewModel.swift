//
//  SecondCurrencyViewModel.swift
//  Presentation
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class SecondCurrencyViewModel {
    private let currencyProvider: CurrencyProvider
    private let currencyAvailabilityChecker: CurrencyAvailabilityChecker
    public private(set) var currencies: Box<[CurrencyView]> = Box([])
    
    init(currencyProvider: CurrencyProvider, currencyAvailabilityChecker: CurrencyAvailabilityChecker) {
        self.currencyProvider = currencyProvider
        self.currencyAvailabilityChecker = currencyAvailabilityChecker
    }
}

extension SecondCurrencyViewModel: CurrenciesViewModel{
    public func startLoaddingCurrencies() {
        let all = currencyProvider.getCurrencies()
        let currencyAvailable = currencyAvailabilityChecker.nonPairingAvailable(within: all)
        let models = currencyAvailable.map(CurrencyView.make(from:isActive:))
        currencies.value = models
    }
    
    public func didSelectCurrencyAtIndex(_ index: Int) {
        
    }
}
