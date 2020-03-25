//
//  ExchangePairViewFormatter.swift
//  Presentation
//
//  Created by Aaron Huánuco on 24/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

final class ExchangePairViewFormatter {
    static func make(_ exchange: ExchangePair) -> ExchangePairView {
        let origin = OriginCurrencyView(
            title: "1 \(exchange.pair.first.code)",
            subtitle: exchange.pair.first.name
        )
        let rate = exchange.rate.toString(decimalDigits: 4) ?? "0.0000"
        let destination = DestinationCurrencyView(
            title: rate,
            subtitle: "\(exchange.pair.second.name) · \(exchange.pair.second.code)"
        )
        return ExchangePairView(origin: origin, destination: destination)
    }
    
    private static func format(_ string: String) -> String {
        let firstDigits = string.dropLast(2)
        let lastDigits = string.reversed().dropFirst(2)
        return String(firstDigits) + lastDigits
    }
}
