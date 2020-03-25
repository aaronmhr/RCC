//
//  SecondCurrencyViewModel.swift
//  Presentation
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class SecondCurrencyViewModel {
    public var router: SecondCurrencyRouterProtocol?
    private let currencyProvider: CurrencyProvider
    private let currencyAvailabilityChecker: PairConfigurator
    private var currencyModels: [Currency] = []
    public private(set) var currencies: Box<[CurrencyView]> = Box([])
    
    public init(currencyProvider: CurrencyProvider, currencyAvailabilityChecker: PairConfigurator) {
        self.currencyProvider = currencyProvider
        self.currencyAvailabilityChecker = currencyAvailabilityChecker
    }
}

extension SecondCurrencyViewModel: CurrenciesViewModel {
    public func loadCurrencies() {
        currencyModels = currencyProvider.getCurrencies()
        currencyAvailabilityChecker.pairingAvailable(within: currencyModels) { [weak self] result in
            switch result {
            case .success(let availableCurrencies):
                let models = availableCurrencies.map(CurrencyView.make(from:isActive:))
                self?.currencies.value = models
            case .failure(let error):
                break
            }
        }
    }
    
    public func didSelectCurrencyAtIndex(_ index: Int) {
        currencyAvailabilityChecker.savePair(with: currencyModels[index]) { [weak self] result in
            switch result {
            case .success:
                self?.router?.dismiss()
            case .failure(let error):
                break
            }
        }
    }
}
