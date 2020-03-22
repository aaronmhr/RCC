//
//  FirstCurrencyViewModelAssembler.swift
//  RCC
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter
import Data
import Presentation

final class FirstCurrencyViewModelAssembler {
    static func assemble() -> FirstCurrencyViewModel {
        let currencyUseCase = DefaultCurrencyProviderAssembler.assemble()
        return FirstCurrencyViewModel(currencyProvider: currencyUseCase)
    }
}

final class DefaultCurrencyProviderAssembler {
    static func assemble() -> DefaultCurrencyProvider {
        let availableCurrencyRepository = DefaultCurrencyRepository()
        let favoriteCurrencyRepository = DefaultFavoritesRepository()
        return  DefaultCurrencyProvider(availableCurrencyRepository: availableCurrencyRepository, favoriteCurrencyRepository: favoriteCurrencyRepository)
    }
}
