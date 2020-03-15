//
//  CurrencyTests.swift
//  ConverterTests
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import Converter

class CurrencyTests: XCTestCase {
    
    func testBuilderBuildsCurrencyFromCode() {
        let currency = Currency.Builder.build(from: "EUR")
        
        XCTAssertEqual(currency?.code, "EUR")
    }
    
    func testBuilderBuildsCurrencyFromCodeUsingLocale() {
        let spainLocale = Locale(identifier: "es_ES")
        
        let currency = Currency.Builder.build(from: "GBP", locale: spainLocale)
        
        XCTAssertEqual(currency?.code, "GBP")
        XCTAssertEqual(currency?.name, "libra esterlina")
    }
    
    func testBuilderBuildsCurrencyFromCodeFromCurrentLocale() {
        let usLocale = Locale(identifier: "en_US")
        
        let currency = Currency.Builder.build(from: "GBP", locale: usLocale)
        
        XCTAssertEqual(currency?.code, "GBP")
        XCTAssertEqual(currency?.name, "British Pound")
    }
}
