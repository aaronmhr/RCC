//
//  Currency.swift
//  Converter
//
//  Created by Aaron Huánuco on 14/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public struct Currency: Equatable {
    public let code: String
    public let name: String
    
    private init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

extension Currency {
    public enum Builder {
        public static func build(from code: String, locale: Locale = .current) -> Currency? {
            guard let name = locale.localizedString(forCurrencyCode: code) else  { return nil }
            return Currency(code: code, name: name)
        }
    }
}
