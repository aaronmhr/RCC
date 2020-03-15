//
//  DefaultCurrencyRepository.swift
//  Data
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

final class DefaultCurrencyRepository: CurrencyRepository {
    public func getCurrencies() -> [Currency] {
        return DefaultCurrencyRepository.codes.compactMap { Currency.Builder.build(from: $0) }
    }
}

extension DefaultCurrencyRepository {
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
