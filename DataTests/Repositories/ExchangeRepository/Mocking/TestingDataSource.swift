//
//  TestingDataSource.swift
//  DataTests
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Data
import Converter

final class TestingUserDataSource: ExchangeRatesDataSource {
    var stubResult: ExchangeRatesDataSource.Result!

    func getRates(for pairs: [Pair], completion: @escaping (ExchangeRatesDataSource.Result) -> Void) {
        completion(stubResult)
    }
}
