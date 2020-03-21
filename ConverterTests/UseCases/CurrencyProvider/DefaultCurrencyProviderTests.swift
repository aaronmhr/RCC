//
//  DefaultCurrencyProviderTests.swift
//  Converter
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Quick
import Nimble
@testable import Converter

final class DefaultCurrencyProviderTests: QuickSpec {
    override func spec() {
        var availableRepository: AvailableCurrencyRepositoryMock!
        var favoriteRepository: FavoriteCurrencyRepositoryMock!
        var sut: DefaultCurrencyProvider!
        
        beforeEach {
            availableRepository = AvailableCurrencyRepositoryMock()
            favoriteRepository = FavoriteCurrencyRepositoryMock()
            sut = DefaultCurrencyProvider(availableCurrencyRepository: availableRepository, favoriteCurrencyRepository: favoriteRepository)
        }
        
        describe("getting currencies") {
            it("should return the currencies for the provided codes sorted alphabetically with respect to their codes") {
                availableRepository.availableCurrencyCodes = ["USD", "GBP", "EUR"]
                
                expect(sut.getCurrencies()).to(equal([Currency.euro, Currency.pound, Currency.dollar]))
            }
        }
        
        describe("getting currencies with favorites") {
            it("should return the currencies for the provided codes sorted alphabetically with respect to their codes, but the favorites should be first") {
                availableRepository.availableCurrencyCodes = ["USD", "GBP", "EUR"]
                favoriteRepository.favoriteCurrencyCodes = ["USD"]
                
                expect(sut.getCurrencies()).to(equal([Currency.dollar, Currency.euro, Currency.pound]))
            }
        }
    }
}
private final class AvailableCurrencyRepositoryMock: AvailableCurrencyRepository {
    var availableCurrencyCodes: [String] = []
}

private final class FavoriteCurrencyRepositoryMock: FavoriteCurrencyRepository {
    var favoriteCurrencyCodes: [String] = []
}
