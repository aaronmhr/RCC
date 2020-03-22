//
//  FirstCurrencyViewModel.swift
//  Presentation
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class FirstCurrencyViewModel {
    public var router: FirstCurrencyRouterProtocol?
    private let currencyProvider: CurrencyProvider
    
    private var currencyEntities: [Currency] = [] {
        didSet { currencies.value = currencyEntities.map { CurrencyView.make(from: $0, isActive: true) } }
    }
    public private(set) var currencies: Box<[CurrencyView]> = Box([])
    
    public init(currencyProvider: CurrencyProvider) {
        self.currencyProvider = currencyProvider
    }
}

extension FirstCurrencyViewModel: CurrenciesViewModel {
    public func loadCurrencies() {
        currencyEntities = currencyProvider.getCurrencies()
    }
    
    public func didSelectCurrencyAtIndex(_ index: Int) {
        let selected = currencyEntities[index]
        router?.showSecondCurrencySelector(for: selected)
    }
}
