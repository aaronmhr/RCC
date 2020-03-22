//
//  CurrencyAvailabilityChecker.swift
//  Converter
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol CurrencyAvailabilityChecker {
    func nonPairingAvailable(within currencies: [Currency]) -> [(currency: Currency, isVisible: Bool)]
}
