//
//  DefaultCurrencyProvider.swift
//  Converter
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public final class DefaultCurrencyProvider: CurrencyProvider {
    private let availableCurrencyRepository: AvailableCurrencyRepository
    private let favoriteCurrencyRepository: FavoriteCurrencyRepository
    
    public init(availableCurrencyRepository: AvailableCurrencyRepository, favoriteCurrencyRepository: FavoriteCurrencyRepository) {
        self.availableCurrencyRepository = availableCurrencyRepository
        self.favoriteCurrencyRepository = favoriteCurrencyRepository
    }
    
    public func getCurrencies() -> [Currency] {
         return sortedCurrencies.compactMap { Currency.Builder.build(from: $0) }
    }
    
    private var sortedCurrencies: [String] {
        return favorites + Array(Set(availableCurrencyRepository.availableCurrencyCodes).subtracting(favorites)).sorted()
    }
    
    private var favorites: [String] {
        return favoriteCurrencyRepository.favoriteCurrencyCodes
    }
    
    private var available: [String] {
        return availableCurrencyRepository.availableCurrencyCodes
    }
}
