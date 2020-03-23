//
//  DefaultPairRepository.swift
//  Data
//
//  Created by Aaron Huánuco on 23/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public class DefaultPairRepository {
    private let datasource: PairDataSource
    private let currentDate: () -> Date
    
    public init(datasource: PairDataSource, currentDate: @escaping () -> Date) {
        self.datasource = datasource
        self.currentDate = currentDate
    }
}

extension DefaultPairRepository: PairRepository {
    public typealias FetchResult = PairRepository.FetchResult
    public typealias SaveResult = PairRepository.SaveResult
    
    public func fetch(completion: @escaping (FetchResult) -> Void) {
        datasource.retrieve(completion: completion)
    }
    
    public func save(_ pair: Pair, completion: @escaping (SaveResult) -> Void) {
        datasource.insert(pair, timestamp: currentDate(), completion: completion)
    }
}
