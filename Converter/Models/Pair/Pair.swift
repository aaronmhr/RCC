//
//  Pair.swift
//  Converter
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public struct Pair {
    public let first: Currency
    public let second: Currency
    
    public init(with first: Currency, and second: Currency) {
        self.first = first
        self.second = second
    }
}
