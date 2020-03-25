//
//  DefaultCurrencyRepository.swift
//  Data
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class DefaultCurrencyRepository: AvailableCurrencyRepository {
    public init() { }
    public var availableCurrencyCodes: [String] {
        let response: [String]? = try? String.readJSONFrom(from: "currencies", bundle: bundle)
        return response ?? []
    }
    
    private var bundle: Bundle  {
        return Bundle(for: type(of: self))
    }
}
