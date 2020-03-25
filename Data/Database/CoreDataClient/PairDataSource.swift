//
//  PairDataSource.swift
//  Data
//
//  Created by Aaron Huánuco on 23/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public protocol PairDataSource {
    typealias DeletionResult = Result<Void, Error>
    typealias DeletionCompletion = (DeletionResult) -> Void
    
    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
    typealias RetrievalResult = Result<[Pair], Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void
    
    func delete(_ pair: Pair, completion: @escaping DeletionCompletion)
    func insert(_ pair: Pair, timestamp: Date, completion: @escaping InsertionCompletion)
    func retrieve(completion: @escaping RetrievalCompletion)
}
