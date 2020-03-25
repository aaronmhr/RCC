//
//  ExchangePair.swift
//  Converter
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public struct ExchangePair: Equatable {
    public let pair: Pair
    public let rate: Double
    
    public init(pair: Pair, rate: Double) {
        self.pair = pair
        self.rate = rate
    }
}
