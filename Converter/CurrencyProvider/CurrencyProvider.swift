//
//  CurrencyProvider.swift
//  Converter
//
//  Created by Aaron Huánuco on 14/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

public protocol CurrencyProvider {
    func getCurrencies() -> [String]
}

public final class DefaultCurrencyProvider: CurrencyProvider {
    public func getCurrencies() -> [String] {
        return []
    }
}
