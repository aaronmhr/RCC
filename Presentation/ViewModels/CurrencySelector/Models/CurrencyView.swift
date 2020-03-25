//
//  CurrencyView.swift
//  Presentation
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public struct CurrencyView {
    public let code: String
    public let name: String
    public let isActive: Bool
}

public extension CurrencyView {
    static func make(from currency: Currency, isActive: Bool = true) -> CurrencyView {
        return CurrencyView(code: currency.code, name: currency.name, isActive: isActive)
    }
}
