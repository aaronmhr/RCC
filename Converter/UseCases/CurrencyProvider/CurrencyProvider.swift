//
//  CurrencyProvider.swift
//  Converter
//
//  Created by Aaron Huánuco on 14/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol CurrencyProvider {
    func getCurrencies() -> [Currency]
}

public final class DefaultCurrencyProvider: CurrencyProvider {
    public func getCurrencies() -> [Currency] {
        return DefaultCurrencyProvider.codes.compactMap { Currency.Builder.build(from: $0) }
    }
}

extension DefaultCurrencyProvider {
    static let codes = [
        "AUD",
        "BGN",
        "BRL",
        "CAD",
        "CHF",
        "CNY",
        "CZK",
        "DKK",
        "EUR",
        "GBP",
        "HKD",
        "HRK",
        "HUF",
        "IDR",
        "ILS",
        "INR",
        "ISK",
        "JPY",
        "KRW",
        "MXN",
        "MYR",
        "NOK",
        "NZD",
        "PHP",
        "PLN",
        "RON",
        "RUB",
        "SEK",
        "SGD",
        "THB",
        "USD",
        "ZAR"
    ]
}
