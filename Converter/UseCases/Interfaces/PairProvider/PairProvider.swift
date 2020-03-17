//
//  PairProvider.swift
//  Converter
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol PairProvider {
    func getConfiguredPairs() -> [Pair]
}
