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
            
            it("should filter invalid codes") {
                availableRepository.availableCurrencyCodes = ["USD", "GBP", "EUR", "google"]
                
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
        
        describe("getting currencies in invalid cases") {
            context("suppliying an empty list of available currencies and empty list of favorites") {
                it("should return empty array of currencies") {
                    availableRepository.availableCurrencyCodes = []
                    favoriteRepository.favoriteCurrencyCodes = []
                    
                    expect(sut.getCurrencies()).to(equal([]))
                }
            }
            
            context("suppliying an empty list of available currencies ") {
                it("should return empty array of currencies") {
                    availableRepository.availableCurrencyCodes = []
                    favoriteRepository.favoriteCurrencyCodes = []
                    
                    expect(sut.getCurrencies()).to(equal([]))
                }
            }
            
            context("suppliying an invalid list of available currencies ") {
                it("should return empty array of currencies") {
                    availableRepository.availableCurrencyCodes = ["google"]
                    favoriteRepository.favoriteCurrencyCodes = []
                    
                    expect(sut.getCurrencies()).to(equal([]))
                }
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
