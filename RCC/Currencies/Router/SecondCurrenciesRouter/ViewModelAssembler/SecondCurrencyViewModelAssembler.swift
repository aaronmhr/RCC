//
//  SecondCurrencyViewModelAssembler.swift
//  RCC
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter
import Data
import Presentation

final class SecondCurrencyViewModelAssembler {
    static func assemble(for currency: Currency) -> SecondCurrencyViewModel {
        let currencyUseCase = DefaultCurrencyProviderAssembler.assemble()
        let exchangeUseCase = DefaultCurrencyAvailabilityCheckerComposer.compose(selectedCurrency: currency)
        
        return SecondCurrencyViewModel(currencyProvider: currencyUseCase, currencyAvailabilityChecker: exchangeUseCase)
    }
}

final class DefaultCurrencyAvailabilityCheckerComposer {
    static func compose(selectedCurrency: Currency) -> DefaultPairConfigurator {
        let pairUseCase = PairUseCaseAssembler.assemble()
        return  DefaultPairConfigurator(selectedCurrency: selectedCurrency, pairUseCase: pairUseCase)
    }
}
