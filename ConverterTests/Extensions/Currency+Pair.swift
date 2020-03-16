//
//  Currency+Pair.swift
//  ConverterTests
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

extension Currency {
    static let euro = Currency.Builder.build(from: "EUR")!
    static let dollar = Currency.Builder.build(from: "USD")!
    static let pound = Currency.Builder.build(from: "GBP")!
}

extension Pair {
    static let euro_dollar = Pair(with: Currency.euro, and: Currency.dollar)
    static let euro_pound = Pair(with: Currency.euro, and: Currency.pound)
    static let dollar_euro = Pair(with: Currency.dollar, and: Currency.euro)
    static let dollar_pound = Pair(with: Currency.dollar, and: Currency.pound)
    static let pound_euro = Pair(with: Currency.pound, and: Currency.euro)
    static let pound_dollar = Pair(with: Currency.pound, and: Currency.dollar)
}

extension ExchangePair {
    static let euro_dolarOne = ExchangePair(pair: Pair.euro_dollar, rate: 1.0)
    static let euro_dolarTwo = ExchangePair(pair: Pair.euro_dollar, rate: 2.0)
    static let euro_dolarThree = ExchangePair(pair: Pair.euro_dollar, rate: 3.0)
}
