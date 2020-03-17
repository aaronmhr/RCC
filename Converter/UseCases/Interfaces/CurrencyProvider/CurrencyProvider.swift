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
